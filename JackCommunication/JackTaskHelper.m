//
//  JackTaskHelper.m
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/18/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "JackTaskHelper.h"

@implementation JackTaskHelper

+(NSString*) toolsDirectioryPath
{
    static NSString * path = @"/usr/bin";

    return path;
}

+(NSString*) jackdmpLaunchPath
{
	return @"/usr/local/bin/jackdmp";
}

+(NSString*) jacktripIPv4LaunchPath
{
	return [NSString stringWithFormat:@"%@/%@", 
            [JackTaskHelper toolsDirectioryPath],
            [JackTaskHelper jacktripIPv4CommandName]];
}

+(NSString*) jacktripIPv6LaunchPath
{
	return [NSString stringWithFormat:@"%@/%@", 
            [JackTaskHelper toolsDirectioryPath],
            [JackTaskHelper jacktripIPv6CommandName]];
}

+(NSString*) jacktripIPv4CommandName
{
	return @"jacktrip";
}

+(NSString*) jacktripIPv6CommandName
{
	return @"jacktrip";
}

+(NSTask*) startJackServerWithPreference:(JackServerPreference*)preference
{
	NSTask *task=[[NSTask alloc] init];
	
	// jackdmp --realtime -d coreaudio -C "Built-in Input" -P "Built-in Output" -i2 -o2 -r44100 -p128
	[task setLaunchPath:[JackTaskHelper jackdmpLaunchPath]];
    
    NSMutableArray * args = [NSMutableArray arrayWithObjects:
                             @"--realtime",
                             @"-d",
                             @"coreaudio",
                             @"-C",
                             preference.inputDevice,
                             @"-P",
                             preference.outputDevice,
                             [NSString stringWithFormat:@"-i%@",preference.interfaceInputChannels],
                             [NSString stringWithFormat:@"-o%@",preference.interfaceOutputChanels],
                             [NSString stringWithFormat:@"-r%@",preference.sampleRate],
                             [NSString stringWithFormat:@"-p%@",preference.bufferSize],
                             nil];
    
    if (preference.hogMode) {
        [args addObject:@"-H"];
    }
    
    if(preference.clockDriftCompensation){
        [args addObject:@"-s"];
    }
    
    if(preference.systemPortMonitoring){
        [args addObject:@"-m"];
    }
    
    if(preference.activateMIDI){
        [args addObject:@"-X"];
        [args addObject:@"coremidi"];
    }
    
	[task setArguments: args];
	
 	[JackTaskHelper launchTask:&task];
	
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
			[JackTaskHelper launchTask:&task];
			
			// If the CPU is fast, not all tasks will be launched correctly.
			[NSThread sleepForTimeInterval:sleepSecondsForTimeInterval];
		}
	}
}

+(void) terminateTask :(NSTask**) task{
	NSTask *curTask=*task;
	if (curTask!=nil) {
		[curTask terminate];
	}
}

+(void) terminateTaskList:(NSArray**)taskList{
	NSArray *curTaskList=*taskList;
	
	if(curTaskList!=nil){
		NSTask *task;
		for(task in curTaskList){
			[JackTaskHelper terminateTask:&task];
		}
	}
}


+(NSArray*) buildJackTaskList:(NSArray*) jackChanelList
					   isIPv6Version:(BOOL)isIPv6Version
{
	int count=(jackChanelList==nil)?10:[jackChanelList count];
	
	NSMutableArray *taskList;
	taskList=[NSMutableArray arrayWithCapacity:count];
	
	if(jackChanelList!=nil){
		JackTripChanel *chanel;
		for(chanel in jackChanelList){
			
			NSTask *jackTripTask;
			NSArray *args;
			NSString *launchPath;
			
			NSNumber *portOffset=[NSNumber numberWithInteger:(chanel.port-JACK_TRIP_BASE_PORT)];
			
			if([chanel.ipAddress isEqualToString:@""]){
				//Server
				if (isIPv6Version) {
					// IPv6 version
					args=[NSArray arrayWithObjects:	
						  @"-V",	// flag for IPv6 verson
  						  @"-s",
						  @"--clientname",
						  chanel.clientName,
						  @"-o",
						  [portOffset stringValue],
						  nil];
					
					launchPath=[JackTaskHelper jacktripIPv6LaunchPath];
				}
				else 
				{
					// IPv4 version
					args=[NSArray arrayWithObjects:	
						 @"-s",
						 @"--clientname",
						 chanel.clientName,
						 @"-o",
						 [portOffset stringValue],
						 nil];
					
					launchPath=[JackTaskHelper jacktripIPv4LaunchPath];
				}	
			}
			else {
				// Client
				if (isIPv6Version) {
					// IPv6 version
					args=[NSArray arrayWithObjects:	
						  @"-V",	// flag for IPv6 verson
						  @"-c",
						  chanel.ipAddress,
						  @"--clientname",
						  chanel.clientName,
						  @"-o",
						  [portOffset stringValue],
						  nil];
					
					launchPath=[JackTaskHelper jacktripIPv6LaunchPath];
				}
				else {
					// IPv4 version
					args=[NSArray arrayWithObjects:	
						  @"-c",
						  chanel.ipAddress,
						  @"--clientname",
						  chanel.clientName,
						  @"-o",
						  [portOffset stringValue],
						  nil];
					
					launchPath=[JackTaskHelper jacktripIPv4LaunchPath];				
				}
			}
			
			// set task info
			jackTripTask=[[NSTask alloc] init];
			[jackTripTask setLaunchPath:launchPath];
			[jackTripTask setArguments:args];
		
			[taskList addObject:[jackTripTask autorelease]];
		}
	}
	
	return (NSArray*)taskList;
}

@end
