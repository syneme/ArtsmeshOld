//
//  MainMenuWindowController.m
//  Artsmesh
//
//  Created by Sky Jia on 8/9/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "MainMenuWindowController.h"

@implementation MainMenuWindowController

#pragma mark -
#pragma mark Console Window

@synthesize outputTextView;

-(void) appendOutputTextLine:(NSString*)textLine
{
	[self appendOutputText:[NSString stringWithFormat:@"  %@ > %@\r",[[NSDate date] description],textLine]];
}

-(void) appendOutputText:(NSString*)text
{
	printf("%s",[text UTF8String]);
	[self performSelectorOnMainThread:@selector(appendOutputTextOnMainThread:) withObject:text waitUntilDone:NO];
	

}

-(void) appendOutputTextOnMainThread:(id)data
{
	NSString *text=data;
	[[[outputTextView textStorage] mutableString] appendString:text];
	
	NSRange range;
    range = NSMakeRange ([[outputTextView string] length], 0);
	
    [outputTextView scrollRangeToVisible: range];
    
    NSColor * color = [NSColor colorWithDeviceRed:0.65 green:0.82 blue:0.86 alpha: 1.0];
    [outputTextView setTextColor:color];
    
    NSFont * font = [NSFont fontWithName:@"Consolas" size: 12];
    [outputTextView setFont:font];
}

#pragma mark -
#pragma mark Loading Window
@synthesize loadingWindow;
@synthesize loadingProgressIndicator;


#pragma mark -
#pragma mark Toolbar

@synthesize ipAddressPopup;
@synthesize ipHostDataSourceController;

-(void) selectDefaultItemInIPComboBox{
	[self.ipAddressPopup selectItemAtIndex:0];
}

-(NSString*) selectedHostIPAddress{
	NSString * ip = [NSString stringWithString:[self.ipAddressPopup titleOfSelectedItem]];
	
	return [ip autorelease];
}

#pragma mark -
@synthesize playInstrumentButton;
@synthesize stopInsrumentButton;


- (IBAction) playInstrument:(id)sender {
	BOOL ableToPlay=YES;
	
	if ([[self.statusNetContactsController selectedObjects] count]==0)
	{
		ableToPlay=NO;
		
		NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert addButtonWithTitle:@"OK"];
		[alert setMessageText:@"Alert"];
		[alert setInformativeText:@"Please select an artist at least."];
		[alert setAlertStyle:NSWarningAlertStyle];
		
		[alert beginSheetModalForWindow: [self window]
						  modalDelegate:self 
						 didEndSelector:@selector(doNothingAlertDidEnd:returnCode:contextInfo:) 
							contextInfo:nil];
	}
	
	if(ableToPlay)
	{
		[playInstrumentButton setEnabled:NO];
		[stopInsrumentButton setEnabled:YES];
		
		[self stopBackgroundWorkingTimer];
		
		NSInvocationOperation* createRoomTask=[[[NSInvocationOperation alloc] 
												initWithTarget:self selector:@selector(createRoom:) object:nil] autorelease];
		[self performOperation:createRoomTask];
	}
	
}

- (IBAction) stopInsrument:(id)sender{
	[self stopBackgroundWorkingTimer];
	[self.jackTaskContainer stopAllTasks];
	[self startInvitationCheckTimer:nil];
	
	[self.currentUserStatusTextField setStringValue:@""];
	[playInstrumentButton setEnabled:YES];
	[stopInsrumentButton setEnabled:NO];
}

@synthesize backgroundWorkingTimer;
@synthesize jackTaskContainer;

-(void) stopBackgroundWorkingTimer
{
	if (backgroundWorkingTimer!=nil) {
		[backgroundWorkingTimer invalidate];
	}
	self.backgroundWorkingTimer=nil;
	currentWorkingTimer=NoneWorkingTimer;
}

-(void) removeRoom{
	[self appendOutputTextLine:@"Removing room from server."];
	JackRESTMessage * message = [JackRESTRoom removeRoom:kRoomName];
	[self appendOutputTextLine:message.contents];
	[self appendOutputTextLine:@"Room has been removed succesfully."];
}

-(void) createRoom:(id)data{
	// Before creating new room, remove/destroy the might existing previous room.
	[self removeRoom];
	
	[self appendOutputTextLine:@"Creating new room on server."];
	JackRESTRoom * room = [[JackRESTRoom alloc] init];
    room.name = kRoomName;
    [room setArtistsArray:[self selectedParticipatedArtistNames]];
	room.creator = [PreferencesHelper statusNetUserName];
	room.ipVersion = [PreferencesHelper ipAddressVersion];
    [JackRESTRoom createRoom:room];
	[self appendOutputTextLine:@"Room has been created succesfully."];
	
	// Invoke Ready
	[self getReady:nil];
}


- (void) getReady:(id)data{
	NSString *currentHostIP=[self selectedHostIPAddress];
	
	JackRESTArtist * art = [[JackRESTArtist alloc] init:[PreferencesHelper statusNetUserName] ip:currentHostIP roomName:kRoomName];
    [JackRESTArtist createArtist:art];
	
	// Change status to 1
	
	[self appendOutputTextLine:@"Connecting server to change status to READY."]; // READY=1
	[JackRESTArtist updateArtistStatus:[PreferencesHelper statusNetUserName] status:1];
	[self appendOutputTextLine:@"Changed status to READY succesfully."];
	
	// Get server chanel list
	[self performSelectorOnMainThread:@selector(startGetServerChanelListTimer:) withObject:nil waitUntilDone:NO];
}


-(void) startGetServerChanelListTimer:(id)data
{
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0
													  target:self
													selector:@selector(getServerChanelList:)
													userInfo:nil
													 repeats:YES];
	
    self.backgroundWorkingTimer = timer;
	currentWorkingTimer=GetServerChanelListTimer;
}

-(void) getServerChanelList:(NSTimer*)timer
{
	JackRESTMessage *message=nil;
	NSArray * jackTripChanelList = [JackTripChanel getServerScripts:[PreferencesHelper statusNetUserName] message:&message];
	
	if (message ==nil) {
		
		if ([jackTripChanelList count]>0) {
			
			// Stop timer
			[self appendOutputTextLine:@"Got the Jack Trip server chanel list from server succesfully."];
			[self stopBackgroundWorkingTimer];
			
			// Execute server tasks
			BOOL isIPv6=NO;
			NSString *ipAddressVersion=[[NSUserDefaults standardUserDefaults] stringForKey:kIPAddressVersion];
			if([ipAddressVersion isEqualToString:@"IPv6"])
				isIPv6=YES;
			
			[jackTripChanelList retain];
			self.jackTaskContainer.jackServerChanelList=jackTripChanelList;
			
			// Launch server tasks
			[self appendOutputTextLine:@"Launching Jack Trip server side task list on local."];
			self.jackTaskContainer.jackTripServerTaskList=[JackTaskHelper buildJackTaskList:jackTripChanelList isIPv6Version:isIPv6];
			NSArray *serverTaskList=self.jackTaskContainer.jackTripServerTaskList;
			[serverTaskList retain];
			[JackTaskHelper launchTaskList:&serverTaskList];
			[self appendOutputTextLine:@"Finish to lauch Jack Trip server side task list on local."];
			
			// Change status to 2
			[self appendOutputTextLine:@"Connecting server to change status to SERVER CREATED."];	// SERVER CREATED:=2
			[JackRESTArtist updateArtistStatus:[PreferencesHelper statusNetUserName] status:2];
			[self appendOutputTextLine:@"Changed status to SERVER CREATED sucessfully."];
			
			// Begin to get client chanel list
			[self startGetClientChanelListTimer:nil];
		}
		else {
			[self appendOutputTextLine:@"There is NO artists in the room. Please click the STOP button."];
		}
	}
	else {
		// Next loop
		[self appendOutputTextLine:@"Connecting to server..."];
	}
}

-(void) startGetClientChanelListTimer:(id)data
{	
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0
													  target:self
													selector:@selector(getClientChanelList:)
													userInfo:nil
													 repeats:YES];
    self.backgroundWorkingTimer = timer;
	currentWorkingTimer=GetClientChanelListtimer;
}

-(void) getClientChanelList:(NSTimer*)timer
{
	JackRESTMessage *message=nil;
	NSArray * jackTripChanelList = [JackTripChanel getClientScripts:[PreferencesHelper statusNetUserName] message:&message];
	
	if (message ==nil) {
		// Stop timer
		[self appendOutputTextLine:@"Got the Jack Trip client chanel list from server succesfully."];
		[self stopBackgroundWorkingTimer];
		
		// Execute client tasks
		BOOL isIPv6=NO;
		NSString *ipAddressVersion=[[NSUserDefaults standardUserDefaults] stringForKey:kIPAddressVersion];
		if([ipAddressVersion isEqualToString:@"IPv6"])
			isIPv6=YES;
		
		[jackTripChanelList retain];
		self.jackTaskContainer.jackClientChanelList=jackTripChanelList;
		
		// Launch client tasks
		[self appendOutputTextLine:@"Launching Jack Trip client side task list on local."];
		self.jackTaskContainer.jackTripClientTaskList=[JackTaskHelper buildJackTaskList:jackTripChanelList isIPv6Version:isIPv6];
		
		NSArray *clientTaskList=self.jackTaskContainer.jackTripClientTaskList;
		[clientTaskList retain];
		[JackTaskHelper launchTaskList:&clientTaskList];
		[self appendOutputTextLine:@"Finish to lauch Jack Trip client side task list on local."];
		
		// Change status to 2
		[self appendOutputTextLine:@"Connecting server to change status to CLIENT CREATED."];	// CLIENT CREATED=3
		[JackRESTArtist updateArtistStatus:[PreferencesHelper statusNetUserName] status:3];
		[self appendOutputTextLine:@"Changed status to CLIENT CREATED sucessfully."];
		[self appendOutputTextLine:@"Jack Trip connections had been established."];
		
		[self.currentUserStatusTextField setStringValue:@"(Jack Trip is connected.)"];
	}
	else {
		// Next loop
		[self appendOutputTextLine:@"Connecting to server..."];
	}
}

#pragma mark -
#pragma mark Split View
//@synthesize splitView;


#pragma mark -
#pragma mark View Switch

@synthesize mainViewSwitcher;
@synthesize mainView;


- (IBAction) switchMainViewTo:(id)sender {
	if (sender!=nil) {
		switch ([sender selectedSegment]) {
			case 0:
				[self.mainView selectTabViewItemAtIndex:0];
				break;
			case 1:
				[self.mainView selectTabViewItemAtIndex:1]; 
				[self performSelectorInBackground:@selector(refreshStatusNetTimelineTableView:)  withObject:nil];
				break;
		}
	}
	else {
		[self.mainView selectTabViewItemAtIndex:0];
	}
}


#pragma mark -
#pragma mark Status.net contacts panel

@synthesize currentUserStatusTextField;
@synthesize statusNetContactsController;
@synthesize currentStatusNetContacts;
@synthesize statusNetUserRefreshTimer;

-(NSArray*) selectedParticipatedArtistNames{
	NSMutableArray *names=[NSMutableArray arrayWithCapacity:[[self.statusNetContactsController selectedObjects] count]];
	
	for (id anArtistInfo in [self.statusNetContactsController selectedObjects] ) {
		NSString *name=[anArtistInfo name]; 
		[names addObject:name];
	}
	
	[names addObject:[PreferencesHelper statusNetUserName]];
	
	return [(NSArray*)names autorelease];
}

-(void) startStatusNetUserRefreshTimer:(id)data{
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:29.0
													  target:self
													selector:@selector(refreshContactsTableViewWithTimer:)
													userInfo:data
													 repeats:YES];
    self.statusNetUserRefreshTimer = timer;
}

-(void) stopStatusNetUserRefreshTimer{
	if (statusNetUserRefreshTimer!=nil) {
		[statusNetUserRefreshTimer invalidate];
	}
	self.statusNetUserRefreshTimer=nil;
}

-(void) refreshContactsTableViewWithTimer:(NSTimer*)timer{
	[self performSelectorInBackground:@selector(refreshContactsTableView:)  withObject:[timer userInfo]];
}

-(void) refreshContactsTableView:(id)data{
	[self appendOutputTextLine:@"Refreshing contacts from server."];
	[self.currentStatusNetContacts refreshArtsmeshContacts];
	[self.statusNetContactsController setContent:self.currentStatusNetContacts.artsmeshContacts];
}

#pragma mark -
#pragma mark iChat actions

- (IBAction) launchiChat:(id)sender {
	
	[ChatTaskHelper launchiChat];
}

- (IBAction) iChatActionsSwitch:(id)sender {
	switch ([sender selectedSegment]) {
		case 0:
			[self launchiChat:sender];
			break;
		case 1:
			[self startiChatWithChatType:VideoChat];
			break;
		case 2:
			[self startiChatWithChatType:AudioChat];
			break;
		case 3:
			[self startiChatWithChatType:TextChat];
			break;
		case 4:
			[self showFOAFInformation];
			break;
	}
}


-(IBAction) startiChatChatFromMenu:(id)sender
{
	NSInteger tag=[sender tag];
	switch (tag) {
		case 0:
			[self startiChatWithChatType:TextChat];
			break;
		case 1:
			[self startiChatWithChatType:AudioChat];
			break;
		case 2:
			[self startiChatWithChatType:VideoChat];
			break;
	}
}

-(void) startiChatWithChatType:(ChatType)chatType
{
	NSArray * buddyList=[ChatTaskHelper getBuddyListWithArtsmeshUserNameList:
						 [[self.statusNetContactsController selectedObjects] valueForKey:@"name"]
						 ];
	
	[ChatTaskHelper startChat:buddyList chatType:chatType];
}

#pragma mark -
#pragma mark Jack Pilot actions

- (IBAction) launchJackPilot:(id)sender{
    NSTask *task=[[NSTask alloc] init];
	
	[task setLaunchPath:@"/Applications/Jack/JackPilot.app/Contents/MacOS/JackPilot"];
    
	[task launch];
	[task release];
}


#pragma mark -
#pragma mark Status.net timeline

@synthesize statusNetTimeLineController;
@synthesize currentStatusNetTimeLine;
@synthesize statusTimelineRefreshTimer;

- (IBAction) postStatusNetMessage:(id)sender {
	NSString * message=[(NSTextField *)sender stringValue];
	[(NSTextField *)sender setStringValue: @""];
	
	[self performSelectorInBackground:@selector(sendStatusNetMessage:) withObject:message];
}

-(void) sendStatusNetMessage:(id)messageData
{
	[StatusNetStatus setStatusNetStatus:messageData 
							   userName:[PreferencesHelper statusNetUserName] 
							   password:[PreferencesHelper statusNetPassword]];
	
	
	[self refreshStatusNetTimelineTableView:nil];
	
}

-(void) startStatusNetTimelineRefreshTimer:(id)data
{
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:31.0
													  target:self
													selector:@selector(refreshStatusNetTimelineTableViewWithTimer:)
													userInfo:data
													 repeats:YES];
    self.statusTimelineRefreshTimer = timer;
}

-(void) stopStatusNetTimelineRefreshTimer
{
	if (statusTimelineRefreshTimer!=nil) {
		[statusTimelineRefreshTimer invalidate];
	}
	self.statusTimelineRefreshTimer=nil;
}

-(void) refreshStatusNetTimelineTableViewWithTimer:(NSTimer*)timer
{
	[self performSelectorInBackground:@selector(refreshStatusNetTimelineTableView:)  withObject:[timer userInfo]];
}

-(void) refreshStatusNetTimelineTableView:(id)data{
	[self.currentStatusNetTimeLine prepareStatusNetTimelineMessages];
	[self.statusNetTimeLineController setContent:self.currentStatusNetTimeLine.statusNetTimelineMessages];
}


#pragma mark -
#pragma mark Preferences window

- (IBAction) showPreferencesWindow:(id)sender {
	[[PreferencesWindowController sharedInstance] showWindow:[PreferencesWindowController sharedInstance]];
}


#pragma mark -
#pragma mark Invitation Window
@synthesize invitationWindow;
@synthesize invitationProgressIndicator;
@synthesize invitationMessageTextField;

-(IBAction) acceptInvitation:(id)sender{
	[self closeInvitationWindow];
	
	[playInstrumentButton setEnabled:NO];
	[stopInsrumentButton setEnabled:YES];
	
	// Get ready
	NSInvocationOperation* getReadyTask=[[[NSInvocationOperation alloc] 
										  initWithTarget:self selector:@selector(getReady:) object:nil] autorelease];
	[self performOperation:getReadyTask];
}

-(IBAction) rejectInvitation:(id)sender{
	
	[JackRESTRoom leaveRoom: [PreferencesHelper statusNetUserName]];
	[self closeInvitationWindow];
	
	[self startInvitationCheckTimer:nil];
}

- (void) showInvitationWindow:(id)data{
	// FIXME: Can't click ACCEPT button twice
	
	JackRESTRoom *room=[JackRESTRoom getRoom:[PreferencesHelper statusNetUserName]];
	JackRESTArtist *creator=[JackRESTArtist getArtist:room.creator];
	
	NSString *message=[NSString stringWithFormat:@"Organizor: %@ (%@ - %@)\r\nParticipated artists: %@",
					   room.creator,room.ipVersion,creator.ip, room.artists];
	
	[self.invitationMessageTextField  setStringValue:message];
	
	// Make invitation window always in front, but not modal.
	[self.invitationProgressIndicator startAnimation:self];
	[self.invitationWindow makeKeyAndOrderFront:self];
	[self.invitationWindow setHidesOnDeactivate:NO];
	[self.invitationWindow setLevel:NSFloatingWindowLevel];		
}

- (void) closeInvitationWindow {
	[self.invitationProgressIndicator stopAnimation:self]; 
	[self.invitationWindow close]; 
}

-(void) startInvitationCheckTimer:(id)data
{
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:11.0
													  target:self
													selector:@selector(checkInvitationStatusWithTimer:)
													userInfo:nil
													 repeats:YES];
    self.backgroundWorkingTimer = timer;
}

-(void) checkInvitationStatusWithTimer:(NSTimer*)timer
{
	[self performSelectorInBackground:@selector(checkInvitationStatus:)  withObject:[timer userInfo]];
}

-(void) checkInvitationStatus:(id)data{
	[self appendOutputTextLine:@"Checking room invitation from server..."];
	
	JackRESTRoom *room = [JackRESTRoom getRoom:[PreferencesHelper statusNetUserName]];
	JackRESTArtist *artist=[JackRESTArtist getArtist:[PreferencesHelper statusNetUserName]];
	
	if (room.message==nil && [artist.message.contents isEqualToString:@"empty"]) {
		// Find my name in room
		[self appendOutputTextLine:@"Found room invitation from server."];
		
		[self stopBackgroundWorkingTimer];
		
		[self performSelectorOnMainThread:@selector(showInvitationWindow:) withObject:nil waitUntilDone:NO];	
	}
}


#pragma mark -
#pragma mark FOAF
- (void) showFOAFWindow:(NSString*)name
{
    FOAFInformationWindowController * controller = [[FOAFInformationWindowController alloc] init];
    [controller showWindowWithFriendName:name];
    [controller autorelease];
	//[[FOAFInformationWindowController sharedInstance] showWindowWithFriendName:name];
}

- (void) showFOAFInformation
{
	NSString * name= nil;
	
	for (id anArtistInfo in [self.statusNetContactsController selectedObjects] ) {
		name=[anArtistInfo name];
		break;
	}
	
	if (name!=nil) {
        [self showFOAFWindow: name];
		//[self performSelectorInBackground:@selector(showFOAFWindow:) withObject:name];
	}
}



#pragma mark -
#pragma mark OSCGroupClient

-(IBAction) launchOSCGroupClientApplication:(id)sender
{
	[OSCGroupTaskHelper launchOSCGroupClientApplication];
}

-(IBAction) quitOSCGroupClientApplication:(id)sender
{
	[OSCGroupTaskHelper quitOSCGroupClientApplication];
}

#pragma mark -

-(void)awakeFromNib
{
	[self.loadingProgressIndicator startAnimation:self.loadingWindow];
    
    [self appendOutputText:@"\r"];
    
}

- (void)doNothingAlertDidEnd:(NSAlert *)alert 
				  returnCode:(NSInteger)returnCode 
				 contextInfo:(void *)contextInfo 
{
	// Do nothing
}

- (BOOL)performOperation:(NSOperation*)anOp 
{
	BOOL ranIt = NO;
	
	if ([anOp isReady] && ![anOp isCancelled]) { 
		if ([anOp isConcurrent])
			[anOp start];	// The operation object handles the concurrency 
		else
			[NSThread detachNewThreadSelector:@selector(start) toTarget:anOp withObject:nil];
		ranIt = YES; 
	}
	return ranIt;
}

-(void) dealloc
{
	[backgroundWorkingTimer release];
	[statusNetUserRefreshTimer release];
	
	[super dealloc];
}

@end
