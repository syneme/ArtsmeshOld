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

-(void) dealloc{
	[self->jackClientChanelList release];
	[self->jackServerChanelList release];
	
	[JackTripTaskHelper terminateTaskList:&(self->jackTripClientTaskList)];
	[self->jackTripClientTaskList release];
	
	[JackTripTaskHelper terminateTaskList:&(self->jackTripServerTaskList)];
	[self->jackTripServerTaskList release];
	
	[JackTripTaskHelper terminateTask:&(self->jackServerTask)];
	[self->jackServerTask release];
	
	[super dealloc];
}

@end
