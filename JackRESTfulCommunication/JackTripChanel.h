//
//  RestScript.h
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HttpRequestHelper.h"
#import "JackRESTMessage.h"
#import "JackRESTRoom.h"

#define JACK_TRIP_BASE_PORT 4464

@interface JackTripChanel : NSObject

@property (retain) NSString * clientName;
@property (retain) NSString * ipAddress;
@property (assign) NSInteger port;

+(NSString *) getServerScriptsUrl:(NSString *) artistName;
+(NSString *) getClientScriptsUrl:(NSString *) artistName;
+(NSArray *) getServerScripts:(NSString *) artistName message:(JackRESTMessage **) message;
+(NSArray *) getClientScripts:(NSString *) artistName message:(JackRESTMessage **) message;

@end
