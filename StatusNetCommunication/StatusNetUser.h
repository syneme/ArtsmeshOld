//
//  StatusNetUserInfo.h
//  Artsmesh
//
//  Created by hui on 10-8-2.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HttpRequestHelper.h"
#import "PreferencesHelper.h"

@interface StatusNetUser : NSObject {
@private
    NSString * userid;
	NSString * name;
	NSString * screen_name;
	NSString * location;
	NSString * profile_url;
}

@property (retain) NSString * userid;
@property (retain) NSString * name;
@property (retain) NSString * screen_name;
@property (retain) NSString * location;
@property (retain) NSString * profile_url;

-(id) init:(NSXMLNode *) node;

+(NSString *) getHostUrl;
+(NSString *) getFriendsUrl:(NSString *)userName;
+(NSArray *) getStatusNetFriends:(NSString *)userName;

@end
