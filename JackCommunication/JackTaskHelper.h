//
//  JackTaskHelper.h
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/18/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JackTripChanel.h"
#import "JackServerPreference.h"

@interface JackTaskHelper : NSObject {	
}

+(NSTask*) startJackServerWithPreference:(JackServerPreference*)preference;

+(NSArray*) buildJackTaskList:(NSArray*) jackChanelList 					 
				isIPv6Version:(BOOL)isIPv6Version;

+(void) launchTask :(NSTask**) task;

+(void) launchTaskList:(NSArray**)taskList;

+(NSString*)toolsDirectoryPath;
+(NSString*) jackdmpLaunchPath;
+(NSString*) jacktripIPv4LaunchPath;
+(NSString*) jacktripIPv6LaunchPath;
+(NSString*) jacktripIPv4CommandName;
+(NSString*) jacktripIPv6CommandName;

@end
