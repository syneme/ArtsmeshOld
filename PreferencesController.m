//
//  PreferencesController.m
//  Artsmesh
//
//  Created by WANG Hailei on 8/5/10.
//  Copyright (c) 2010 Farefore Co. All rights reserved.
//

#import "PreferencesController.h"


@implementation PreferencesController



/*
- (id) initWithWindow:(NSWindow *)window {
	
	if ((self = [super initWithWindow:window])) {
		// Initialization code here.
		[self showWindow:self];
	}
	
	return self;
}
*/

- (id) initWithWindowNibName:(NSString *)windowNibName {
	
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		[self showWindow:self];
	}
	
	return self;
}

- (void)dealloc {
	// Clean-up code here.
	
	[super dealloc];
}

- (void)windowDidLoad {
	[super windowDidLoad];
	
	// Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void) awakeFromNib {
//	[self.preferenceJackWebServiceAddress setStringValue:[NSUserDefaults standardUserDefaults] URLForKey:@"JackWebServiceAddress"];
}


#pragma mark -
#pragma mark IBActions


- (IBAction) setPreferenceJackWebServiceAddress:(id)sender {
//	[[NSUserDefaults standardUserDefaults] setURL:[self.preferenceJackWebServiceAddress stringValue] forKey:@"JackWebServiceAddress"];
}

- (IBAction) setPreferenceJackIPVersion:(id)sender {
	
}

- (IBAction) setPreferenceStatusNetWebServiceAddress:(id)sender {
	
}

- (IBAction) setPreferenceStatusNetAccount:(id)sender {
	
}

- (IBAction) setPreferenceStatusNetPassword:(id)sender {
	
}


@end

