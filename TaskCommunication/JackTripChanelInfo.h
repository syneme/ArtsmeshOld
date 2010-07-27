//
//  ChanelInfo.h
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/19/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSInteger const JACK_TRIP_BASE_PORT;

@interface JackTripChanelInfo : NSObject {
	NSString *ipAddress;
	NSInteger port;
}

@property (assign) NSString *ipAddress;
@property (assign) NSInteger port;

+(NSArray*) getJackTripChanelListFromXml:(NSString*) xmlText;

@end
