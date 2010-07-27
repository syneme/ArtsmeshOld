//
//  JackTaskHelper.m
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/18/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "JackTripTaskHelper.h"

@implementation JackTripTaskHelper

+(NSTask*) startJackServer{
	// TODO: change the command arguments for staring jack server.
	// init jackServerTask
	NSTask *task=[[NSTask alloc] init];
	
	[task setLaunchPath:@"/usr/local/bin/jackdmp"];
	[task setArguments:
	 [NSArray arrayWithObjects:	
	  @"--version",
	  nil]];
	
	[JackTripTaskHelper launchTask:&task];
	
	return [task autorelease];
}

+(void) launchTask :(NSTask**) task{
	NSTask *curTask=*task;
	
	if(curTask!=nil)
		[curTask launch];
}

+(void) launchTaskList:(NSArray**)taskList{
	static int sleepSecondsForTimeInterval=5;
	
	NSArray *curTaskList=*taskList;
	
	if(curTaskList!=nil){
		NSTask *task;
		for(task in curTaskList){
			[JackTripTaskHelper launchTask:&task];
			
			// If the CPU is fast, not all tasks will be launched correctly.
			[NSThread sleepForTimeInterval:sleepSecondsForTimeInterval];
		}
	}
}

+(void) terminateTask :(NSTask**) task{
	NSTask *curTask=*task;
	if (curTask!=nil) {
		if ([curTask isRunning]) {
			[curTask terminate];
		}
	}
}

+(void) terminateTaskList:(NSArray**)taskList{
	NSArray *curTaskList=*taskList;
	
	if(curTaskList!=nil){
		NSTask *task;
		for(task in curTaskList){
			if ([task isRunning]) {
				[JackTripTaskHelper terminateTask:&task];
			}
			
		}
	}
}


+(NSArray*) buildJackTaskList:(NSArray*) jackChanelList{
	int count=(jackChanelList==nil)?10:[jackChanelList count];
	
	NSMutableArray *taskList;
	taskList=[NSMutableArray arrayWithCapacity:count];
	
	if(jackChanelList!=nil){
		JackTripChanelInfo *chanel;
		for(chanel in jackChanelList){

			NSTask *jackTripTask;
			jackTripTask=[[NSTask alloc] init];
			[jackTripTask setLaunchPath:@"/usr/bin/jacktrip"];
			
			NSNumber *portOffset=[NSNumber numberWithInteger:(chanel.port-JACK_TRIP_BASE_PORT)];
			
			if([chanel.ipAddress isEqualToString:@""]){
				//Server
				[jackTripTask setArguments:
				 [NSArray arrayWithObjects:	
				  @"-s",
				  @"--clientname",
				  [NSString stringWithFormat:@"Server_%@_%d", chanel.ipAddress,chanel.port],
				  @"-o",
				  [portOffset stringValue],
				  nil]];
			}
			else {
				// Client
				[jackTripTask setArguments:
				 [NSArray arrayWithObjects:	
				  @"-c",
				  chanel.ipAddress,
				  @"--clientname",
				  [NSString stringWithFormat:@"Client_%@_%d", chanel.ipAddress,chanel.port],
				  @"-o",
				  [portOffset stringValue],
				  nil]];
			}
			
			[jackTripTask autorelease];
			[taskList addObject:jackTripTask];
		}
	}
	
	return (NSArray*)taskList;
}

@end
