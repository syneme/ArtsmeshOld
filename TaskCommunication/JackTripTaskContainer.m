//
//  JackTripTaskContainer.m
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/23/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "JackTripTaskContainer.h"


@implementation JackTripTaskContainer

@synthesize jackClientChanelList;
@synthesize jackServerChanelList;
@synthesize jackTripClientTaskList;
@synthesize jackTripServerTaskList;
@synthesize jackServerTask;

-(void) stopAllTasks{

	
	[NSTask launchedTaskWithLaunchPath:@"/usr/bin/killall" 
							 arguments:[NSArray arrayWithObjects:	
										@"-c",
										@"jacktrip",
										nil]];
	

	
	[NSTask launchedTaskWithLaunchPath:@"/usr/bin/killall" 
							 arguments:[NSArray arrayWithObjects:	
										@"-c",
										@"jackdmp",
										nil]];
	
	[NSTask launchedTaskWithLaunchPath:@"/usr/bin/killall" 
							 arguments:[NSArray arrayWithObjects:	
										@"-c",
										@"JackPilot",
										nil]];
	
	//[JackTripTaskHelper terminateTaskList:&(self->jackTripClientTaskList)];
	//[JackTripTaskHelper terminateTaskList:&(self->jackTripServerTaskList)];
	//[JackTripTaskHelper terminateTask:&(self->jackServerTask)];
}

-(void) dealloc{
	[self stopAllTasks];
	
	[jackClientChanelList release];
	[jackServerChanelList release];
	[jackTripClientTaskList release];
	[jackTripServerTaskList release];
	[jackServerTask release];
	
	[super dealloc];
}

@end
