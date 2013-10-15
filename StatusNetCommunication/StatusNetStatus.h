//
//  StatusNetStatusInfo.h
//  Artsmesh
//
//  Created by hui on 10-8-2.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StatusNetUser.h"

@interface StatusNetStatus : NSObject {
@private
    NSString * statusid;
	NSString * source;
	NSDate   * created_at;
	NSString * text;
	NSString * html;
    StatusNetUser * user;
}

@property (retain) NSString * statusid;
@property (retain) NSString * source;
@property (assign) NSDate * created_at;
@property (retain) NSString * text;
@property (retain) NSString * html;
@property (retain) StatusNetUser * user;

-(id) init:(NSXMLNode *) node;

+(NSString *) getFriendsUrl:(NSString *)userName;
+(NSString *) getUpdateUrl;
+(NSArray *) getStatusNetFriendsStatuses:(NSString *)userName;

+(StatusNetStatus *) setStatusNetStatus:(NSString *)status
                                   userName:(NSString *)name 
                                   password:(NSString *)pw;

@end
