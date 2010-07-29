//
//  JackServerPreference.h
//  Artsmesh
//
//  Created by Sky Jia on 7/29/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface JackServerPreference : NSObject {
	NSString *driver;
	NSString *inputDevice;
	NSString *outputDevice;
	NSString *sampleRate;
	NSString *bufferSize;
	NSString *interfaceInputChannels;
	NSString *interfaceOutputChanels;
}

@property (copy) NSString *driver;
@property (copy) NSString *inputDevice;
@property (copy) NSString *outputDevice;
@property (copy) NSString *sampleRate;
@property (copy) NSString *bufferSize;
@property (copy) NSString *interfaceInputChannels;
@property (copy) NSString *interfaceOutputChanels;


@end
