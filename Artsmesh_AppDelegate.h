////  Artsmesh_AppDelegate.h////  Version: 0.2.1//  Created by WANG Hailei on 7/19/10.//  Modified by WANG Hailei, JIA Chao//  Copyright 2010 Farefore. All rights reserved.//#import <Cocoa/Cocoa.h>#import "JackTripTaskContainer.h"#import "RESTfulRequestHelper.h"#import "ChatTaskHelper.h"@interface Artsmesh_AppDelegate : NSObject <NSApplicationDelegate> {		NSWindow * window;		NSPersistentStoreCoordinator * persistentStoreCoordinator;	NSManagedObjectModel * managedObjectModel;	NSManagedObjectContext * managedObjectContext;		JackTripTaskContainer *taskContainer;}@property (nonatomic, retain) IBOutlet NSWindow *window;@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;@property (assign) IBOutlet NSTextField * myIPAddress;@property (assign) IBOutlet NSTextField * serverUrl;@property (assign) IBOutlet NSTextField * artistName;@property (nonatomic, retain) IBOutlet NSTableView * contactsTable;- (IBAction) saveAction:sender;- (IBAction) stopTerminalCommands:(id)sender;- (IBAction) callTerminalCommands:(id)sender;- (IBAction) launchiChat:(id)sender;- (IBAction) createRoom:(id)sender;- (IBAction) removeRoom:(id)sender;- (IBAction) readyCommand:(id)sender;//- (void)invokeTask:(NSTask*)task;//- (void)terminateTask:(NSTask*)task;@end