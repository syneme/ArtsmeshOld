//
//  RestScript.m
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import "JackTripChanel.h"


@implementation JackTripChanel

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

@synthesize clientName;
@synthesize ipAddress;
@synthesize port;
//@synthesize message;

-(id) init:(NSXMLNode *) node{
    if ((self = [super init])) {
        NSXMLElement * element = (NSXMLElement *) node;
        
        clientName = [[element attributeForName:@"name"] stringValue];
        ipAddress = [[element attributeForName:@"ip"] stringValue];
        port =  [[[element attributeForName:@"port"] stringValue] integerValue];
        
        [element release];
    }
    
    return self;
}

+(NSString *) getServerScriptsUrl:(NSString *) artistName{
    return [[NSString stringWithFormat:@"%@/scripts/server/%@.xml",[JackRESTRoom getHostUrl],artistName] autorelease];
}

+(NSString *) getClientScriptsUrl:(NSString *) artistName{
    return [[NSString stringWithFormat:@"%@/scripts/client/%@.xml",[JackRESTRoom getHostUrl],artistName] autorelease];
}

+(NSArray *) getServerScripts:(NSString *) artistName message:(JackRESTMessage **) message{
    NSString * data = [HttpRequestHelper sendGETRequest:[JackTripChanel getServerScriptsUrl:artistName]];
    NSMutableArray * scripts = [[NSMutableArray alloc] init];
	if(data == nil){
        [data release];
        return (NSArray *)[scripts autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	[data release];
    if(err != nil){
		[err release];
		[xmlDocument release];
		return (NSArray *)[scripts autorelease];
	}
    
    if([[[xmlDocument rootElement] name] isEqualToString:@"message"]){
		*message = [[JackRESTMessage alloc] init:[xmlDocument rootElement]];
    }
    else{
        NSXMLNode * node = nil;
        NSArray * nodes = [[xmlDocument rootElement] nodesForXPath:@"chanel" error:&err];
        if(err != nil){
            [err release];
            [node release];
            [xmlDocument release];
            return (NSArray *)[scripts autorelease];
        }
        
        for(node in nodes){
            JackTripChanel * scriptInfo = [[JackTripChanel alloc] init:node];
            [scripts addObject:[scriptInfo autorelease]];
        }
        [node release];
        //[nodes release];
    }

    [err release];
    [xmlDocument release];
	return (NSArray *)[scripts autorelease];
}
+(NSArray *) getClientScripts:(NSString *) artistName message:(JackRESTMessage **) message{
    NSString * data = [HttpRequestHelper sendGETRequest:[JackTripChanel getClientScriptsUrl:artistName]];
    NSMutableArray * scripts = [[NSMutableArray alloc] init];
	if(data == nil){
        [data release];
        return (NSArray *)[scripts autorelease];
    }
    
    NSError * err = nil;
	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data 
                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA) 
                                                                     error:&err];
	[data release];
    if(err != nil){
		[err release];
		[xmlDocument release];
		return (NSArray *)[scripts autorelease];
	}
    
    if([[[xmlDocument rootElement] name] isEqualToString:@"message"]){
        *message = [[JackRESTMessage alloc] init:[xmlDocument rootElement]];
    }
    else{
        NSXMLNode * node = nil;
        NSArray * nodes = [[xmlDocument rootElement] nodesForXPath:@"chanel" error:&err];
        if(err != nil){
            [err release];
            [node release];
            [xmlDocument release];
            return (NSArray *)[scripts autorelease];
        }
        
        for(node in nodes){
            JackTripChanel * scriptInfo = [[JackTripChanel alloc] init:node];
            [scripts addObject:[scriptInfo autorelease]];
        }
        [node release];
        //[nodes release];
    }
    
    [err release];
    [xmlDocument release];
	return (NSArray *)[scripts autorelease];
}

@end
