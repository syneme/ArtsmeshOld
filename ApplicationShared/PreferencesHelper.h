//
//  PreferenceSetting.h
//  Artsmesh
//
//  Created by Sky Jia on 8/8/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ArtsmeshConstDefinition.h"

@interface PreferencesHelper : NSObject {
    
}

+(void) initialize;
+(void) loadDefaultPreferences;
+(BOOL) checkAllRequiredPreferences:(NSString**)errorMessage;

BOOL stringIsEmptyOrNil(NSString *str);

#pragma mark -
#pragma mark Preferences

+(NSString*) jackWebServiceAddress;
+(NSString*) ipAddressVersion;

#pragma mark -
+(NSString*) statusNetUserName;
+(NSString*) statusNetPassword;
+(NSString*) statusNetWebServiceAddress;

#pragma mark -
+ (NSString *) jackDriver;
+ (NSString *) jackServerInputDevice;
+ (NSString *) jackServerOutputDevice;
+ (NSString *) jackServerSampleRate;
+ (NSString *) jackServerBufferSize;
+ (NSInteger) jackServerHogMode;
+ (NSInteger) jackServerClockDriftCompensation;
+ (NSInteger) jackServerSystemPortMonitoring;
+ (NSInteger) jackServerActivateMIDI;
+ (NSString *) jackServerInterfaceInputChannels;
+ (NSString *) jackServerInterfaceOutputChannels;

#pragma mark -
+ (NSString *) artsmeshiChatServiceGuid;

@end
