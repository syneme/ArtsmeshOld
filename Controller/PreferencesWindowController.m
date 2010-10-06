//
//  PreferencesController.m
//  Artsmesh
//
//  Created by WANG Hailei on 8/5/10.
//  Copyright (c) 2010 Farefore Co. All rights reserved.
//

#import "PreferencesWindowController.h"


@implementation PreferencesWindowController

static PreferencesWindowController * theInstance=nil;

+(void) initialize
{
	if (theInstance==nil) {
		theInstance=[[PreferencesWindowController alloc] init];
	}
}

+(PreferencesWindowController*) sharedInstance{
	return theInstance;
}

-(id) init{
	return [self initWithWindowNibName:@"PreferencesWindow"];
}


- (void)windowWillClose:(NSNotification *)notification
{	
	[[NSApplication sharedApplication] stopModal];
	
	[[[NSApplication sharedApplication] delegate] performSelector:@selector(applyPreferencesChanges)];
}



@end

