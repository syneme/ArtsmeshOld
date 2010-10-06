//
//  RestRoom.m
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import "JackRESTRoom.h"


@implementation JackRESTRoom

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@synthesize name;
@synthesize artists;
@synthesize creator;
@synthesize ipVersion;
@synthesize message;

-(id) init:(NSXMLNode *) node{
    if ((self = [super init])) {
        NSError * err = nil;
        NSXMLNode * element = nil;
        
        if([[node name] isEqualToString:@"message"]){
            message = [[[JackRESTMessage alloc] init:node] autorelease];
        }
        else{
            element = [[node nodesForXPath:@"Name" error:&err] objectAtIndex:0];
            name = [element stringValue];
            element = [[node nodesForXPath:@"Artists" error:&err] objectAtIndex:0];
            artists = [element stringValue];
            element = [[node nodesForXPath:@"Creator" error:&err] objectAtIndex:0];
            creator = [element stringValue];
            element = [[node nodesForXPath:@"IPVersion" error:&err] objectAtIndex:0];
            ipVersion = [element stringValue];
        }
        
        [element release];
        [err release];
    }
    
    return self;
}
//-(id) init:(NSString *) roomName 
//   artists:(NSArray *) roomArtists 
//   creator:(NSString *) roomCreator 
// ipVersion:(NSString *) roomIPVersion{
//    if ((self = [super init])) {
//        name = roomName;
//        [self setArtists:roomArtists];
//        creator = roomCreator;
//        ipVersion = roomIPVersion;
//    }
//    
//    return self;
//}
-(NSString *) toXmlString{
    return [[NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8' ?><room><Name>%@</Name><Artists>%@</Artists><Creator>%@</Creator><IPVersion>%@</IPVersion></room>",name,artists,creator,ipVersion] autorelease];
}
-(NSArray *) getArtistsArray{
    return [artists componentsSeparatedByString:@","];
}
-(void) setArtistsArray:(NSArray *) value{
    artists = [[value valueForKey:@"description"] componentsJoinedByString:@","];
    //NSLog(@"%@",artists);
}

+(NSString *) getHostUrl{
	return [PreferencesHelper jackWebServiceAddress];
}
+(NSString *) getCreateRoomUrl{
    return [[NSString stringWithFormat:@"%@/rooms.xml",[JackRESTRoom getHostUrl]] autorelease];
}
+(NSString *) getRoomUrl:(NSString *) artistName{
    return [[NSString stringWithFormat:@"%@/rooms/%@.artist.xml",[JackRESTRoom getHostUrl],artistName] autorelease];
}
+(NSString *) getLeaveRoomUrl:(NSString *) artistName{
    return [[NSString stringWithFormat:@"%@/rooms/%@.remove.xml",[JackRESTRoom getHostUrl],artistName] autorelease];
}
+(NSString *) getRemoveRoomUrl:(NSString *) roomName{
    return [[NSString stringWithFormat:@"%@/rooms/%@.delete.xml",[JackRESTRoom getHostUrl],roomName] autorelease];
}
+(id) createRoom:(JackRESTRoom *) room{
    NSString * data = [HttpRequestHelper sendPOSTRequestWithXmlText:[JackRESTRoom getCreateRoomUrl] 
                                                            xmlText:[room toXmlString]];
    if(data == nil){
        JackRESTRoom * roomEmptyInfo = [[JackRESTRoom alloc] init];
        [data release];
        return [roomEmptyInfo autorelease];
    }
    
    NSError * err = nil;
    NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	if(err != nil){
		JackRESTRoom * roomEmptyInfo = [[JackRESTRoom alloc] init];
        [err release];
		[xmlDocument release];
		return [roomEmptyInfo autorelease];
	}
    
    JackRESTRoom * roomInfo = [[JackRESTRoom alloc] init:[xmlDocument rootElement]];
    [err release];
    [xmlDocument release];
	return [roomInfo autorelease];
}
+(id) getRoom:(NSString *) artistName{
    NSString * data = [HttpRequestHelper sendGETRequest:[JackRESTRoom getRoomUrl:artistName]];
    if(data == nil){
        JackRESTRoom * roomEmptyInfo = [[JackRESTRoom alloc] init];
        [data release];
        return [roomEmptyInfo autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	if(err != nil){
		JackRESTRoom * roomEmptyInfo = [[JackRESTRoom alloc] init];
        [err release];
		[xmlDocument release];
		return [roomEmptyInfo autorelease];
	}
    
    JackRESTRoom * roomInfo = [[JackRESTRoom alloc] init:[xmlDocument rootElement]];	
    [err release];
    [xmlDocument release];
	return [roomInfo autorelease];
}
+(JackRESTMessage *) leaveRoom:(NSString *) artistName{
    NSString * data = [HttpRequestHelper sendGETRequest:[JackRESTRoom getLeaveRoomUrl:artistName]];
    if(data == nil){
        JackRESTMessage * messageEmptyInfo = [[JackRESTMessage alloc] init];
        [data release];
        return [messageEmptyInfo autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	if(err != nil){
		JackRESTMessage * messageEmptyInfo = [[JackRESTMessage alloc] init];
        [err release];
		[xmlDocument release];
		return [messageEmptyInfo autorelease];
	}
    
    JackRESTMessage * messageInfo = [[JackRESTMessage alloc] init:[xmlDocument rootElement]];
    [err release];
    [xmlDocument release];
	return [messageInfo autorelease];
}
+(JackRESTMessage *) removeRoom:(NSString *) roomName{
    NSString * data = [HttpRequestHelper sendGETRequest:[JackRESTRoom getRemoveRoomUrl:roomName]];
    if(data == nil){
        JackRESTMessage * messageEmptyInfo = [[JackRESTMessage alloc] init];
        [data release];
        return [messageEmptyInfo autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	if(err != nil){
		JackRESTMessage * messageEmptyInfo = [[JackRESTMessage alloc] init];
        [err release];
		[xmlDocument release];
		return [messageEmptyInfo autorelease];
	}
    
    JackRESTMessage * messageInfo = [[JackRESTMessage alloc] init:[xmlDocument rootElement]];	
    [err release];
    [xmlDocument release];
	return [messageInfo autorelease];
}

@end
