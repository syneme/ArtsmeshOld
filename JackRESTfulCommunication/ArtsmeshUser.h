//
//  RestUser.h
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HttpRequestHelper.h"
#import "JackRESTMessage.h"
#import "JackRESTRoom.h"
#import "StatusNetUser.h"
#import "ChatTaskHelper.h"

@interface ArtsmeshUser : NSObject {
@private
    NSString * name;
    NSInteger status;
    NSString * accountProfilePage;
    BOOL hasLogon;
    BOOL hasiChatLogon;
    JackRESTMessage * message;
}

@property (retain) NSString * name;
@property (assign) NSInteger status;
@property (retain) NSString * accountProfilePage;
@property (assign) BOOL hasLogon;
@property (assign) BOOL hasiChatLogon;
@property (retain) JackRESTMessage * message;

-(id) init:(NSXMLNode *) node;
-(id) initUserName:(NSString *) userName;
-(NSString *) toXmlString;

+(NSString *) getCreateUserUrl;
+(NSString *) getRemoveUserUrl:(NSString *) userName;
+(NSString *) getFriendsUrl:(NSString *)userName;
+(NSString *) getHasLogonUrl:(NSString *) userName;
+(NSString *) getAllLogonUrl;
+(id) login:(NSString *) userName;
+(JackRESTMessage *) logout:(NSString *) userName;
+(NSString *) getFriendsHTML:(NSString *)userName;
+(NSArray *) getFriends:(NSString *)userName;
+(NSArray *) getFriendsWithStatus:(NSString *)userName;
+(BOOL) hasLogon:(NSString *) userName;
+(NSDictionary *) allLogon;

@end
