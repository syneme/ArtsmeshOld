//
//  OSCGroupTaskHelper.m
//  Artsmesh
//
//  Created by Sky Jia on 8/26/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "OSCGroupTaskHelper.h"


@implementation OSCGroupTaskHelper

+(NSString*) OSCGroupClientGUIApplicationLaunchPath
{
	// "./OSCGroupClientGUI.app/Contents/MacOS/OSCGroupClientGUI";
	NSString * path=[NSString stringWithFormat:@"%@/Contents/MacOS/%@",
					 [[[NSBundle mainBundle] bundlePath] stringByReplacingOccurrencesOfString:@"/Artsmesh.app" withString:[NSString stringWithFormat:@"/%@.app",kOSCGroupClientApplicationName]],
					 kOSCGroupClientApplicationName];
	
	return path;
}

+(void) launchOSCGroupClientApplication{
	NSTask *task=[[NSTask alloc] init];
	
	// OSCGroupClientGUI.app/Contents/MacOS/OSCGroupClientGUI 
	
	[task setLaunchPath:[OSCGroupTaskHelper OSCGroupClientGUIApplicationLaunchPath]];
	
	[task setArguments:
	 [NSArray arrayWithObjects:	
	  [PreferencesHelper statusNetUserName],
	  nil]];
	 
	[task launch];
	[task release];
}

+(void) quitOSCGroupClientApplication{
	// osascript -e 'quit app "OSCGroupClientGUI"
	
	NSTask *task=[[NSTask alloc] init];
	
	[task setLaunchPath:@"/usr/bin/osascript"];
	
	[task setArguments:
	 [NSArray arrayWithObjects:	
	  @"-e",
	  [NSString stringWithFormat:@"quit app \"%@\"", kOSCGroupClientApplicationName],
	  nil]];
	 
	[task launch];
	[task release];
}

@end
