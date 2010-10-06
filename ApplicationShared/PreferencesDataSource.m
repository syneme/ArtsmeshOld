//
//  Preferences.m
//  Artsmesh
//
//  Created by WANG Hailei on 8/10/10.
//  Copyright 2010 Farefore Co. All rights reserved.
//

#import "PreferencesDataSource.h"


@implementation PreferencesDataSource

@synthesize jackServerSampleRatePreferenceOptions;
@synthesize jackServerBufferSizePreferenceOptions;
@synthesize ipAddressVersionPreferenceOptions;
@synthesize iChatJabberAccountPreferenceOptions;
@synthesize coreAudioInputDeviceOptions;
@synthesize coreAudioOutputDeviceOptions;

- (void) awakeFromNib {	
	[self prepareJackServerSampleRatePreferenceOptions];
	[self prepareJackServerBufferSizePreferenceOptions];
	[self prepareIPAddressVersionPreferenceOptions];
	[self prepareiChatJabberAccountPreferenceOptions];
	[self prepareCoreAudioDeviceOptions];
}

	 
- (void) prepareJackServerSampleRatePreferenceOptions {
	self.jackServerSampleRatePreferenceOptions = [NSArray arrayWithObjects:
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:44100] forKey:kJackServerSampleRate],
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:48000] forKey:kJackServerSampleRate], 
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:88200] forKey:kJackServerSampleRate], 
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:96000] forKey:kJackServerSampleRate], 
						      nil];	
}

- (void) prepareJackServerBufferSizePreferenceOptions {
	self.jackServerBufferSizePreferenceOptions = [NSArray arrayWithObjects:
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:32]   forKey:kJackServerBufferSize],
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:64]   forKey:kJackServerBufferSize],
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:128]  forKey:kJackServerBufferSize],
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:256]  forKey:kJackServerBufferSize],
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:512]  forKey:kJackServerBufferSize],
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:1024] forKey:kJackServerBufferSize],
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:2048] forKey:kJackServerBufferSize],
						      [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:4096] forKey:kJackServerBufferSize],
							  nil];
}

- (void) prepareIPAddressVersionPreferenceOptions{
	self.ipAddressVersionPreferenceOptions=[NSArray arrayWithObjects:
											[NSMutableDictionary dictionaryWithObject:@"IPv4" forKey:kIPAddressVersion],
											[NSMutableDictionary dictionaryWithObject:@"IPv6" forKey:kIPAddressVersion],
											nil];
}

- (void) prepareiChatJabberAccountPreferenceOptions {
	
	SBElementArray * currentUseriChatServices = [[ChatTaskHelper currentiChatApplication] services];
	
	NSMutableArray * iChatJabberAccounts = [[NSMutableArray alloc] initWithCapacity:1];
	for ( iChatService * aniChatService in currentUseriChatServices ) {
		// Only show the Jabbser services
		if ( aniChatService.serviceType == iChatServiceTypeJabber) {
			[iChatJabberAccounts addObject:aniChatService];
		}
	}
	self.iChatJabberAccountPreferenceOptions = iChatJabberAccounts;
}

- (void) prepareCoreAudioDeviceOptions
{
	NSMutableArray * audioInputDevices=[[NSMutableArray alloc] initWithCapacity:1];
	NSMutableArray * audioOutputDevices=[[NSMutableArray alloc] initWithCapacity:1];
	
	AudioObjectPropertyAddress  propertyAddress;
	AudioObjectID               *deviceIDs;
	UInt32                      propertySize;
	NSInteger                   numDevices;
	
	propertyAddress.mSelector =kAudioHardwarePropertyDevices;
	propertyAddress.mScope = kAudioObjectPropertyScopeGlobal;
	propertyAddress.mElement = kAudioObjectPropertyElementMaster;
	if (AudioObjectGetPropertyDataSize(kAudioObjectSystemObject, &propertyAddress, 0, NULL, &propertySize) == noErr) {
		numDevices = propertySize / sizeof(AudioDeviceID);
		deviceIDs = (AudioDeviceID *)calloc(numDevices, sizeof(AudioDeviceID));
		
		if (AudioObjectGetPropertyData(kAudioObjectSystemObject, &propertyAddress, 0, NULL, &propertySize, deviceIDs) == noErr) {
			AudioObjectPropertyAddress      deviceAddress;
			char                            deviceName[64];
			
			int idx=0;
			for (idx=0; idx<numDevices; idx++) {
				propertySize = sizeof(deviceName);
				deviceAddress.mSelector = kAudioDevicePropertyDeviceName;
				deviceAddress.mScope = kAudioObjectPropertyScopeGlobal;
				deviceAddress.mElement = kAudioObjectPropertyElementMaster;
				if (AudioObjectGetPropertyData(deviceIDs[idx], &deviceAddress, 0, NULL, &propertySize, deviceName) == noErr) {
					// is Input device
					UInt32 value=-1;
					
					value=GetVolumeDeviceCanBeDefaultDevice(deviceIDs[idx],true);
					if (value==1) {
						// kJackServerInterfaceInputChannels
						[audioInputDevices addObject:[NSString stringWithUTF8String:deviceName]];
						NSLog(@"Input device: %s", deviceName);
						continue;
					}
					
					value=GetVolumeDeviceCanBeDefaultDevice(deviceIDs[idx],false);
					if (value==1) {
						[audioOutputDevices addObject:[NSString stringWithUTF8String:deviceName]];
						NSLog(@"Output device %s", deviceName);
						continue;
					}
				}
			}
		}
		
		free(deviceIDs);
	}
	
	self.coreAudioInputDeviceOptions=audioInputDevices;
	self.coreAudioOutputDeviceOptions=audioOutputDevices;
}

UInt32 GetVolumeDeviceCanBeDefaultDevice(AudioDeviceID inDevice, bool inIsInput)
{
    UInt32 theAnswer = 0;
    UInt32 theSize = sizeof(UInt32);
    AudioObjectPropertyScope theScope = inIsInput ? kAudioDevicePropertyScopeInput :kAudioDevicePropertyScopeOutput;
    AudioObjectPropertyAddress theAddress = { kAudioDevicePropertyDeviceCanBeDefaultDevice, theScope, kAudioObjectPropertyElementMaster };
	
    OSStatus theError = AudioObjectGetPropertyData(inDevice,
                                                   &theAddress,
                                                   0,
                                                   NULL,
                                                   &theSize,
                                                   &theAnswer);
    // handle errors
	if (theError!=noErr) {
		return -1;
	}
	
	return theAnswer;
}

@end
