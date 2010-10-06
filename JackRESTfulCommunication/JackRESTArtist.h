//
//  RestArtist.h
//  Artsmesh
//
//  Created by hui on 10-8-9.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HttpRequestHelper.h"
#import "JackRESTMessage.h"
#import "JackRESTRoom.h"

@interface JackRESTArtist : NSObject {
@private
    NSString * name;
	NSString * ip;
    NSString * roomName;
    //NSInteger index;
    NSInteger status;
    JackRESTMessage * message;
}

@property (retain) NSString * name;
@property (retain) NSString * ip;
@property (retain) NSString * roomName;
//@property (assign) NSInteger index;
@property (assign) NSInteger status;
@property (retain) JackRESTMessage * message;

-(id) init:(NSXMLNode *) node;
-(id) init:(NSString *) artistName 
        ip:(NSString *) artistIP 
  roomName:(NSString *) artistRoomName;
-(NSString *) toXmlString;

+(NSString *) getCreateArtistUrl;
+(NSString *) getArtistUrl:(NSString *) artistName;
+(NSString *) getUpdateArtistStatusUrl:(NSString *) artistName
                                status:(NSInteger) artistStatus;
+(id) createArtist:(JackRESTArtist *) artist;
+(id) getArtist:(NSString *) artistName;
+(id) updateArtistStatus:(NSString *) artistName 
                  status:(NSInteger) artistStatus;

@end
