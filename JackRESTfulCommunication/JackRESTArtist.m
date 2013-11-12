//
//  RestArtist.m
//  Artsmesh
//
//  Created by hui on 10-8-9.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import "JackRESTArtist.h"


@implementation JackRESTArtist

- (id)init {
    if ((self = [super init])) {
    }
    
    return self;
}

- (void)dealloc {

    [super dealloc];
}

@synthesize name;
@synthesize ip;
@synthesize roomName;
@synthesize status;
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
            element = [[node nodesForXPath:@"IP" error:&err] objectAtIndex:0];
            ip = [element stringValue];
            element = [[node nodesForXPath:@"RoomName" error:&err] objectAtIndex:0];
            roomName = [element stringValue];
            element = [[node nodesForXPath:@"Status" error:&err] objectAtIndex:0];
            status = [[element stringValue] integerValue];
        }
        
        [element release];
        [err release];
    }
    
    return self;
}
-(id) init:(NSString *) artistName 
        ip:(NSString *) artistIP 
  roomName:(NSString *) artistRoomName{
    if ((self = [self init])) {
        name = artistName;
        ip = artistIP;
        roomName = artistRoomName;
    }
    
    return self;
}
-(NSString *) toXmlString{
    return [NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8' ?><artist><Name>%@</Name><IP>%@</IP><RoomName>%@</RoomName><Status>%d</Status></artist>",name,ip,roomName,status];
}

+(NSString *) getCreateArtistUrl{
    return [[NSString stringWithFormat:@"%@/artists.xml",[JackRESTRoom getHostUrl]] autorelease];
}
+(NSString *) getArtistUrl:(NSString *) artistName{
    return [[NSString stringWithFormat:@"%@/artists/%@.xml",[JackRESTRoom getHostUrl],artistName] autorelease];
}
+(NSString *) getUpdateArtistStatusUrl:(NSString *) artistName
                                status:(NSInteger) artistStatus{
    return [[NSString stringWithFormat:@"%@/artists/%@.%d.xml",[JackRESTRoom getHostUrl],artistName,artistStatus] autorelease];
}
+(id) createArtist:(JackRESTArtist *) artist{
    NSString * data = [HttpRequestHelper sendPOSTRequestWithXmlText:[JackRESTArtist getCreateArtistUrl] 
                                                            xmlText:[artist toXmlString]];
    if(data == nil){
        JackRESTArtist * artistEmptyInfo = [[JackRESTArtist alloc] init];
        [data release];
        return [artistEmptyInfo autorelease];
    }
    
    NSError * err = nil;
    NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	if(err != nil){
        JackRESTArtist * artistEmptyInfo = [[JackRESTArtist alloc] init];
		[err release];
		[xmlDocument release];
		return [artistEmptyInfo autorelease];
	}
    
    JackRESTArtist * artistInfo = [[JackRESTArtist alloc] init:[xmlDocument rootElement]];
    [err release];
    [xmlDocument release];
	return [artistInfo autorelease];
}
+(id) getArtist:(NSString *) artistName{
    NSString * data = [HttpRequestHelper sendGETRequest:[JackRESTArtist getArtistUrl:artistName]];
    if(data == nil){
        JackRESTArtist * artistEmptyInfo = [[JackRESTArtist alloc] init];
        [data release];
        return [artistEmptyInfo autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString: data
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	if(err != nil){
		JackRESTArtist * artistEmptyInfo = [[JackRESTArtist alloc] init];
        [err release];
		[xmlDocument release];
		return [artistEmptyInfo autorelease];
	}
    
    JackRESTArtist * artistInfo = [[JackRESTArtist alloc] init:[xmlDocument rootElement]];
    [err release];
    [xmlDocument release];
	return [artistInfo autorelease];
}
+(id) updateArtistStatus:(NSString *) artistName 
                  status:(NSInteger) artistStatus{
    NSString * data = [HttpRequestHelper sendGETRequest:[JackRESTArtist getUpdateArtistStatusUrl:artistName status:artistStatus]];
    if(data == nil){
        JackRESTArtist * artistEmptyInfo = [[JackRESTArtist alloc] init];
        [data release];
        return [artistEmptyInfo autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	if(err != nil){
		JackRESTArtist * artistEmptyInfo = [[JackRESTArtist alloc] init];
        [err release];
		[xmlDocument release];
		return [artistEmptyInfo autorelease];
	}
    
    JackRESTArtist * artistInfo = [[JackRESTArtist alloc] init:[xmlDocument rootElement]];
    [err release];
    [xmlDocument release];
    return [artistInfo autorelease];
}

@end
