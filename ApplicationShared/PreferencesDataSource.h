//
//  Preferences.h
//  Artsmesh
//
//  Created by WANG Hailei on 8/10/10.
//  Copyright 2010 Farefore Co. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreAudio/CoreAudio.h>
#import "ArtsmeshConstDefinition.h"
#import "ChatTaskHelper.h"

@interface PreferencesDataSource : NSObject

@property (assign) NSArray * driverOptions;
@property (assign) NSArray * jackServerSampleRatePreferenceOptions;
@property (assign) NSArray * jackServerBufferSizePreferenceOptions;
@property (assign) NSArray * ipAddressVersionPreferenceOptions;
@property (assign) NSArray * iChatJabberAccountPreferenceOptions;
@property (assign) NSArray * coreAudioInputDeviceOptions;
@property (assign) NSArray * coreAudioOutputDeviceOptions;

- (void) prepareDriverOptions;
- (void) prepareJackServerSampleRatePreferenceOptions;
- (void) prepareJackServerBufferSizePreferenceOptions;
- (void) prepareIPAddressVersionPreferenceOptions;
- (void) prepareiChatJabberAccountPreferenceOptions;
- (void) prepareCoreAudioDeviceOptions;

UInt32 GetVolumeDeviceCanBeDefaultDevice(AudioDeviceID inDevice, bool inIsInput);

@end
