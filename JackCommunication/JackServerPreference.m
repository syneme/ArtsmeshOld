//
//  JackServerPreference.m
//  Artsmesh
//
//  Created by Sky Jia on 7/29/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "JackServerPreference.h"


@implementation JackServerPreference

@synthesize inputDevice;
@synthesize outputDevice;
@synthesize sampleRate;
@synthesize bufferSize;
@synthesize hogMode;
@synthesize clockDriftCompensation;
@synthesize systemPortMonitoring;
@synthesize activateMIDI;
@synthesize interfaceInputChannels;
@synthesize interfaceOutputChannels;

-(void) dealloc{
	[inputDevice release];
	[outputDevice release];
	[sampleRate release];
	[bufferSize release];
	[interfaceInputChannels release];
	[interfaceOutputChannels release];
	
	[super dealloc];
}

@end
