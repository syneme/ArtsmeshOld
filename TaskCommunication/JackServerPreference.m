//
//  JackServerPreference.m
//  Artsmesh
//
//  Created by Sky Jia on 7/29/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "JackServerPreference.h"


@implementation JackServerPreference

@synthesize driver;
@synthesize inputDevice;
@synthesize outputDevice;
@synthesize sampleRate;
@synthesize bufferSize;
@synthesize interfaceInputChannels;
@synthesize interfaceOutputChanels;

-(void) dealloc{
	[driver release];
	[inputDevice release];
	[outputDevice release];
	[sampleRate release];
	[bufferSize release];
	[interfaceInputChannels release];
	[interfaceOutputChanels release];
	
	[super dealloc];
}

@end
