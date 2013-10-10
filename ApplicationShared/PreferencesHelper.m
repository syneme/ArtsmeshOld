//
//  PreferenceSetting.m
//  Artsmesh
//
//  Created by Sky Jia on 8/8/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "PreferencesHelper.h"


@implementation PreferencesHelper

+ (void) initialize {
	[PreferencesHelper loadDefaultPreferences];
}

+(void) loadDefaultPreferences
{
	// Prepare the factory defaults values
	NSDictionary * registrationDomainDefaultsValues = [NSDictionary dictionaryWithObjectsAndKeys:
													   @"http://syneme.ucalgary.ca:8085", kJackWebServiceAddress,
													   @"IPv4", kIPAddressVersion, 
													   @"http://syneme.ucalgary.ca:8080/index.php", kStatusNetWebServiceAddress,
                                                       @"coreaudio", kJackDriver,
													   @"Built-in Microphone", kJackServerInputDevice,
													   @"Built-in Output", kJackServerOutputDevice,
													   @"44100", kJackServerSampleRate,
													   @"512", kJackServerBufferSize,
                                                       [NSNumber numberWithInteger:0], kJackServerHogMode,
                                                       [NSNumber numberWithInteger:0], kJackServerClockDriftCompensation,
                                                       [NSNumber numberWithInteger:0], kJackServerSystemPortMonitoring,
                                                       [NSNumber numberWithInteger:0], kJackServerActivateMIDI,
													   @"2", kJackServerInterfaceInputChannels,
													   @"2", kJackServerInterfaceOutputChannels,
													   nil];
	
	// Set the factory defaults values in the standard user defaults.
	[[NSUserDefaults standardUserDefaults] registerDefaults:registrationDomainDefaultsValues];	
}

+(BOOL) checkAllRequiredPreferences:(NSString**)errorMessage{
	BOOL flag=YES;
	NSMutableString *outMessage= [[[NSMutableString alloc] initWithString:@""] autorelease];
	
	if (!stringIsEmptyOrNil([PreferencesHelper jackWebServiceAddress]))
    {[outMessage appendString:@"Jack web serice addres can't be empty.\r\n"];flag=NO;}
    if (!stringIsEmptyOrNil([PreferencesHelper statusNetUserName]))
    {[outMessage appendString:@"StatusNet UserName can't be empty.\r\n"];flag=NO;}
    if (!stringIsEmptyOrNil([PreferencesHelper statusNetPassword]))
    {[outMessage appendString:@"statusNet Password can't be empty.\r\n"];flag=NO;}
    if (!stringIsEmptyOrNil([PreferencesHelper statusNetWebServiceAddress]))
    {[outMessage appendString:@"StatusNet WebService Address can't be empty.\r\n"];flag=NO;}
    if (!stringIsEmptyOrNil([PreferencesHelper jackServerInputDevice]))
    {[outMessage appendString:@"Jack Server Input Device can't be empty.\r\n"];flag=NO;}
    if (!stringIsEmptyOrNil([PreferencesHelper jackServerOutputDevice]))
    {[outMessage appendString:@"Jack Server Output Device can't be empty.\r\n"];flag=NO;}
    if (!stringIsEmptyOrNil([PreferencesHelper jackServerInterfaceInputChannels]))
    {[outMessage appendString:@"Jack Server Interface Input Channels can't be empty.\r\n"];flag=NO;}
    if (!stringIsEmptyOrNil([PreferencesHelper jackServerInterfaceOutputChannels]))
    {[outMessage appendString:@"Jack Server Interface Output Channels can't be empty.\r\n"];flag=NO;}
    if (!stringIsEmptyOrNil([PreferencesHelper artsmeshiChatServiceGuid]))
    {[outMessage appendString:@"iChat Service can't be empty.\r\n"];flag=NO;}
	
	if (flag==NO) {
		*errorMessage= outMessage;
	}

	return flag;
}

BOOL stringIsEmptyOrNil(NSString *str){
	if(str==nil || [str length]==0)
		return NO;
	
	return YES;
}

#pragma mark -
#pragma mark Preferences

+(NSString*) jackWebServiceAddress{
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kJackWebServiceAddress] autorelease];
}

+(NSString*) ipAddressVersion{
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kIPAddressVersion] autorelease];
}

#pragma mark -

+(NSString*) statusNetUserName{
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kStatusNetUsername] autorelease];
}

+(NSString*) statusNetPassword{
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kStatusNetPassword] autorelease];
}

+(NSString*) statusNetWebServiceAddress{
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kStatusNetWebServiceAddress] autorelease];
}

#pragma mark -

+ (NSString *) jackServerInputDevice {
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kJackServerInputDevice] autorelease];	
}

+ (NSString *) jackServerOutputDevice {
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kJackServerOutputDevice] autorelease];	
}

+ (NSString *) jackServerSampleRate {
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kJackServerSampleRate] autorelease];	
}

+ (NSString *) jackServerBufferSize {
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kJackServerBufferSize] autorelease];	
}

+ (NSInteger) jackServerHogMode{
    return [[[NSUserDefaults standardUserDefaults] valueForKey: kJackServerHogMode] integerValue];
}

+ (NSInteger) jackServerClockDriftCompensation{
    return [[[NSUserDefaults standardUserDefaults] valueForKey: kJackServerClockDriftCompensation] integerValue];
}

+ (NSInteger) jackServerSystemPortMonitoring{
    return [[[NSUserDefaults standardUserDefaults] valueForKey: kJackServerSystemPortMonitoring] integerValue];
}
+ (NSInteger) jackServerActivateMIDI{
    return [[[NSUserDefaults standardUserDefaults] valueForKey: kJackServerActivateMIDI] integerValue];
}

+ (NSString *) jackServerInterfaceInputChannels {
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kJackServerInterfaceInputChannels] autorelease];	
}

+ (NSString *) jackServerInterfaceOutputChannels {
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kJackServerInterfaceOutputChannels] autorelease];	
}

#pragma mark -
+ (NSString *) artsmeshiChatServiceGuid
{
	return [[[NSUserDefaults standardUserDefaults] stringForKey:kArtsmeshiChatServiceGuid] autorelease];
}


@end
