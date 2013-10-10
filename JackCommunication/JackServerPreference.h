//
//  JackServerPreference.h
//  Artsmesh
//
//  Created by Sky Jia on 7/29/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface JackServerPreference : NSObject {
	NSString *inputDevice;
	NSString *outputDevice;
	NSString *sampleRate;
	NSString *bufferSize;
    NSInteger hogMode;
    NSInteger clockDriftCompensation;
    NSInteger systemPortMonitoring;
    NSInteger activateMIDI;
	NSString *interfaceInputChannels;
	NSString *interfaceOutputChannels;
}

@property (copy) NSString *inputDevice;
@property (copy) NSString *outputDevice;
@property (copy) NSString *sampleRate;
@property (copy) NSString *bufferSize;
@property (assign) NSInteger hogMode;
@property (assign) NSInteger clockDriftCompensation;
@property (assign) NSInteger systemPortMonitoring;
@property (assign) NSInteger activateMIDI;
@property (copy) NSString *interfaceInputChannels;
@property (copy) NSString *interfaceOutputChannels;


@end
