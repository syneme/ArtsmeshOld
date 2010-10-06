//
//  StatusNetUserInfo.m
//  Artsmesh
//
//  Created by hui on 10-8-2.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import "StatusNetUser.h"


@implementation StatusNetUser

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

@synthesize userid;
@synthesize name;
@synthesize screen_name;
@synthesize location;
@synthesize profile_url;

-(id) init:(NSXMLNode *) node{
    if ((self = [super init])) {
        NSError * err = nil;
        NSXMLNode * element = nil;
        
        element = [[node nodesForXPath:@"id" error:&err] objectAtIndex:0];
        userid = [element stringValue];
        element = [[node nodesForXPath:@"name" error:&err] objectAtIndex:0];
        name = [element stringValue];
        element = [[node nodesForXPath:@"screen_name" error:&err] objectAtIndex:0];
        screen_name = [element stringValue];
        element = [[node nodesForXPath:@"location" error:&err] objectAtIndex:0];
        location = [element stringValue];
        element = [[node nodesForXPath:@"statusnet:profile_url" error:&err] objectAtIndex:0];
        profile_url = [element stringValue];
        
        [err release];
        [element release];
    }
    
    return self;
}

+(NSString *) getHostUrl{
    //return [@"http://syneme.ucalgary.ca:8080/index.php" autorelease];
    return [PreferencesHelper statusNetWebServiceAddress];
}
+(NSString *) getFriendsUrl:(NSString *)userName{
    return [[NSString stringWithFormat:@"%@/api/statuses/friends_timeline/%@.xml",[StatusNetUser getHostUrl],userName] autorelease];
}
+(NSArray *) getStatusNetFriends:(NSString *)userName{
    NSString * data = [HttpRequestHelper sendGETRequest:[StatusNetUser getFriendsUrl:userName]];
    NSMutableDictionary * friends = [[NSMutableDictionary alloc] init];
	if(data == nil){
        [data release];
        return [[friends allValues] autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	[data release];
    if(err != nil){
		[err release];
		[xmlDocument release];
		return [[friends allValues] autorelease];
	}
    
    NSXMLNode * node = nil;
	NSXMLNode * element = nil;
    NSString * key = nil;
    NSArray * nodes = [[xmlDocument rootElement] nodesForXPath:@"status/user" error:&err];
	if(err != nil){
		[err release];
		[key release];
		[element release];
		[node release];
		[nodes release];
		[xmlDocument release];
		return [[friends allValues] autorelease];
	}
    	
	for(node in nodes){
        element = [[node nodesForXPath:@"name" error:&err] objectAtIndex:0];
        key = [element stringValue];
        if(![[friends allKeys] containsObject:key]){
            StatusNetUser * user = [[StatusNetUser alloc] init:node];
            [friends setValue:[user autorelease] forKey:key];
        }
    }
	
    [err release];
    [key release];
    [element release];
    [node release];
    [nodes release];
	[xmlDocument release];
	return [[friends allValues] autorelease];
}

@end
