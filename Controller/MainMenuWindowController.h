//
//  MainMenuWindowController.h
//  Artsmesh
//
//  Created by Sky Jia on 8/9/10.
//  Copyright 2010 Farefore. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "PreferencesWindowController.h"
#import "ArtsmeshContacts.h"
#import "ChatTaskHelper.h"
#import "JackTaskContainer.h"
#import "JackRESTRoom.h"
#import "JackRESTArtist.h"
#import "JackTripChanel.h"
#import "StatusNetStatus.h"
#import "StatusNetTimeline.h"
#import "ProcessInfo.h"
#import "FOAFInformationWindowController.h"
#import "OSCGroupTaskHelper.h"

#define kRoomName @"room1"

typedef enum _BackgroundWorkingTimer
{
	NoneWorkingTimer=0,
	InvitationCheckTimer=1,
	GetServerChanelListTimer=2,
	GetClientChanelListtimer=3
	
} BackgroundWorkingTimer;

@interface MainMenuWindowController : NSWindowController {
	BackgroundWorkingTimer currentWorkingTimer;
	NSTimer *	backgroundWorkingTimer;
	NSTimer *	statusNetUserRefreshTimer;
	NSTimer *	statusTimelineRefreshTimer;
}

#pragma mark -
#pragma mark Console Window
@property (assign) IBOutlet NSTextView *outputTextView;

-(void) appendOutputText:(NSString*)text;
-(void) appendOutputTextLine:(NSString*)textLine;
-(void) appendOutputTextOnMainThread:(id)data;

#pragma mark -
#pragma mark Loading Window
@property (assign) IBOutlet NSWindow * loadingWindow;
@property (assign) IBOutlet NSProgressIndicator * loadingProgressIndicator;

#pragma mark -
#pragma mark Toolbar

@property (assign) IBOutlet NSPopUpButton *ipAddressPopup;
@property (retain) IBOutlet IPHostDataSourceController * ipHostDataSourceController;
-(void) selectDefaultItemInIPComboBox;
-(NSString*) selectedHostIPAddress;

#pragma mark -

@property (assign) IBOutlet NSButton *playInstrumentButton;
@property (assign) IBOutlet NSButton *stopInsrumentButton;
- (IBAction) playInstrument:(id)sender;
- (IBAction) stopInsrument:(id)sender;

@property (retain) NSTimer *backgroundWorkingTimer;
@property (retain) IBOutlet JackTaskContainer * jackTaskContainer;

-(void) stopBackgroundWorkingTimer;
-(void) removeRoom;
-(void) createRoom:(id)data;
-(void) getReady:(id)data;

-(void) startGetServerChanelListTimer:(id)data;
-(void) getServerChanelList:(NSTimer*)timer;

-(void) startGetClientChanelListTimer:(id)data;
-(void) getClientChanelList:(NSTimer*)timer;

#pragma mark -
#pragma mark Split View
//@property (assign) IBOutlet NSSplitView * splitView;

#pragma mark -
#pragma mark View Switch
@property (assign) IBOutlet NSSegmentedControl * mainViewSwitcher;
@property (assign) IBOutlet NSTabView * mainView;
- (IBAction) switchMainViewTo:(id)sender; 

#pragma mark -
#pragma mark Status.net contacts panel
@property (assign) IBOutlet NSTextField * currentUserStatusTextField;
@property (retain) IBOutlet NSArrayController *statusNetContactsController;
@property (assign) IBOutlet ArtsmeshContacts *currentStatusNetContacts;
@property (retain) NSTimer * statusNetUserRefreshTimer;

-(NSArray*) selectedParticipatedArtistNames;
-(void) startStatusNetUserRefreshTimer:(id)data;
-(void) stopStatusNetUserRefreshTimer;
-(void) refreshContactsTableViewWithTimer:(NSTimer*)timer;
-(void) refreshContactsTableView:(id)data;

#pragma mark -
#pragma mark iChat actions
- (IBAction) launchiChat:(id)sender;
- (IBAction) iChatActionsSwitch:(id)sender;

-(IBAction) startiChatChatFromMenu:(id)sender;
-(void) startiChatWithChatType:(ChatType)chatType;

#pragma mark -
#pragma mark Jack Pilot actions
- (IBAction) launchJackPilot:(id)sender;

#pragma mark -
#pragma mark Status.net timeline
@property (retain) IBOutlet NSArrayController *statusNetTimeLineController;
@property (assign) IBOutlet StatusNetTimeline *currentStatusNetTimeLine;
@property (retain) NSTimer * statusTimelineRefreshTimer;

- (IBAction) postStatusNetMessage:(id)sender;
-(void) sendStatusNetMessage:(id)messageData;

-(void) startStatusNetTimelineRefreshTimer:(id)data;
-(void) stopStatusNetTimelineRefreshTimer;
-(void) refreshStatusNetTimelineTableViewWithTimer:(NSTimer*)timer;
-(void) refreshStatusNetTimelineTableView:(id)data;


#pragma mark -
#pragma mark Preferences window
- (IBAction) showPreferencesWindow:(id)sender;


#pragma mark -
#pragma mark Invitation Window
@property (assign) IBOutlet NSWindow *invitationWindow;
@property (assign) IBOutlet NSProgressIndicator *invitationProgressIndicator;
@property (assign) IBOutlet NSTextField * invitationMessageTextField;

-(IBAction) acceptInvitation:(id)sender;
-(IBAction) rejectInvitation:(id)sender;
- (void) closeInvitationWindow;
- (void) showInvitationWindow:(id)data;

-(void) startInvitationCheckTimer:(id)data;
-(void) checkInvitationStatusWithTimer:(NSTimer*)timer;
-(void) checkInvitationStatus:(id)data;

#pragma mark -
#pragma mark FOAF
- (void) showFOAFInformation;

#pragma mark -
#pragma mark OSCGroupClient

-(IBAction) launchOSCGroupClientApplication:(id)sender;
-(IBAction) quitOSCGroupClientApplication:(id)sender;

#pragma mark -
- (BOOL)performOperation:(NSOperation*)anOp;

@end
