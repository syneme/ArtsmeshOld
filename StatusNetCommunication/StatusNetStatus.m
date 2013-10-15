//
//  StatusNetStatusInfo.m
//  Artsmesh
//
//  Created by hui on 10-8-2.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import "StatusNetStatus.h"


@implementation StatusNetStatus

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

@synthesize statusid;
@synthesize source;
@synthesize created_at;
@synthesize text;
@synthesize html;
@synthesize user;

-(id) init:(NSXMLNode *) node{
    if ((self = [super init])) {
        NSError * err = nil;
        NSXMLNode * element = nil;
        
        element = [[node nodesForXPath:@"id" error:&err] objectAtIndex:0];
        statusid = [element stringValue];
        element = [[node nodesForXPath:@"source" error:&err] objectAtIndex:0];
        source = [element stringValue];
        element = [[node nodesForXPath:@"created_at" error:&err] objectAtIndex:0];
        created_at =[NSDate dateWithString:[element stringValue]];
        element = [[node nodesForXPath:@"text" error:&err] objectAtIndex:0];
        text = [element stringValue];
        element = [[node nodesForXPath:@"statusnet:html" error:&err] objectAtIndex:0];
        html = [element stringValue];
        
        NSXMLNode * userNode = [[node nodesForXPath:@"user" error:&err] objectAtIndex:0];
        StatusNetUser * userInfo = [[StatusNetUser alloc] init:userNode];
        user = [userInfo autorelease];
        
        [element release];
        [userNode release];
        [err release];
    }
    return self;
}

+(NSString *) getFriendsUrl:(NSString *)userName{
    return [[NSString stringWithFormat:@"%@/api/statuses/friends_timeline/%@.xml",[StatusNetUser getHostUrl],userName] autorelease];
}

+(NSString *) getUpdateUrl{
    return [[NSString stringWithFormat:@"%@/api/statuses/update.xml",[StatusNetUser getHostUrl]] autorelease];
}
+(NSArray *) getStatusNetFriendsStatuses:(NSString *)userName{
    NSString * data = [HttpRequestHelper sendGETRequest:[StatusNetStatus getFriendsUrl:userName]];
    NSMutableArray * statuses = [[NSMutableArray alloc] init];
	if(data == nil){
        [data release];
        return (NSArray *)[statuses autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	[data release];
    if(err != nil){
		[err release];
		[xmlDocument release];
		return (NSArray *)[statuses autorelease];
	}
    NSXMLNode * node = nil;
    NSArray * nodes = [[xmlDocument rootElement] nodesForXPath:@"status" error:&err];
	if(err != nil){
		[err release];
		[node release];
		[nodes release];
		[xmlDocument release];
		return (NSArray *)[statuses autorelease];
	}
    
	for(node in nodes){
        StatusNetStatus * status = [[StatusNetStatus alloc] init:node];
        [statuses addObject:[status autorelease]];
    }
	
    [err release];
    [node release];
    [nodes release];
	[xmlDocument release];
	return (NSArray *)[statuses autorelease];
}

+(StatusNetStatus *) setStatusNetStatus:(NSString *)status
                                   userName:(NSString *)name 
                                   password:(NSString *)pw{
    NSMutableArray * postDatas = [[NSMutableArray alloc] init];
    HttpPostData * postData = [[HttpPostData alloc] init];
    [postData setKey:@"status"];
    [postData setValue:status];
    [postDatas addObject:[postData autorelease]];
    
    NSString * data = [HttpRequestHelper sendPOSTRequest:[StatusNetStatus getUpdateUrl] 
                                           postDataArray:(NSArray *)[postDatas autorelease] 
                                                username:name 
                                                password:pw];
 	if(data == nil){
        StatusNetStatus * statusEmptyInfo = [[StatusNetStatus alloc] init];
        [data release];
        return [statusEmptyInfo autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
    [data release];
    if(err != nil){
		StatusNetStatus * statusEmptyInfo = [[StatusNetStatus alloc] init];
        [err release];
		[xmlDocument release];
		return [statusEmptyInfo autorelease];
	}
    
    StatusNetStatus * statusInfo = [[StatusNetStatus alloc] init:[xmlDocument rootElement]];
    [err release];
    [xmlDocument release];
	return [statusInfo autorelease];
}

@end
