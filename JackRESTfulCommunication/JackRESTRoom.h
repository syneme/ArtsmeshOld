//
//  RestRoom.h
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HttpRequestHelper.h"
#import "JackRESTMessage.h"
#import "PreferencesHelper.h"

@interface JackRESTRoom : NSObject {
@private
	NSString * artists;
    NSString * creator;
    NSString * ipVersion;
    JackRESTMessage * message;
}

@property (retain) NSString * name;
@property (retain) NSString * artists;
@property (retain) NSString * creator;
@property (retain) NSString * ipVersion;
@property (retain) JackRESTMessage * message;

-(id) init:(NSXMLNode *) node;
//-(id) init:(NSString *) roomName 
//   artists:(NSArray *) roomArtists 
//   creator:(NSString *) roomCreator 
// ipVersion:(NSString *) roomIPVersion;
-(NSString *) toXmlString;
-(NSArray *) getArtistsArray;
-(void) setArtistsArray:(NSArray *) value;

+(NSString *) getHostUrl;
+(NSString *) getCreateRoomUrl;
+(NSString *) getRoomUrl:(NSString *) artistName;
+(NSString *) getLeaveRoomUrl:(NSString *) artistName;
+(NSString *) getRemoveRoomUrl:(NSString *) roomName;
+(id) createRoom:(JackRESTRoom *) room;
+(id) getRoom:(NSString *) artistName;
+(JackRESTMessage *) leaveRoom:(NSString *) artistName;
+(JackRESTMessage *) removeRoom:(NSString *) roomName;

@end
