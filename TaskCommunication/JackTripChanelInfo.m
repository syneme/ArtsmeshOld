//
//  ChanelInfo.m
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/19/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "JackTripChanelInfo.h"

NSInteger const JACK_TRIP_BASE_PORT=4464;

@implementation JackTripChanelInfo

@synthesize ipAddress;
@synthesize port;

+(NSArray*) getJackTripChanelListFromXml:(NSString*) xmlText{
	NSXMLDocument *xmlDoc;
	NSError *err=nil;
	xmlDoc=[[NSXMLDocument alloc] initWithXMLString:xmlText 
						options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA)
						  error:&err];
	
	if (xmlDoc == nil) {
		xmlDoc = [[NSXMLDocument alloc] initWithXMLString:xmlText
							  options:NSXMLDocumentTidyXML
							    error:&err];
	}
	
	if(err!=nil){
		return nil;
	}
	
	NSXMLElement *chanelNode;
	NSArray *nodes = [xmlDoc nodesForXPath:@"./chanels/chanel"
					 error:&err];
	NSMutableArray *jackChanelList=[NSMutableArray arrayWithCapacity:[nodes count]];
	
	if ([nodes count] > 0 ) {
		for(chanelNode in nodes){
			
			JackTripChanelInfo *chanel=[[JackTripChanelInfo alloc] init];
			
			chanel.ipAddress=[[chanelNode attributeForName:@"ip"] stringValue];
			chanel.port=[[[chanelNode attributeForName:@"port"] stringValue] integerValue];
			
			[jackChanelList addObject:[chanel autorelease]];
		}
	}
	if(err!=nil){
		return nil;
	}
	
	[xmlDoc release];
	
	return (NSArray*)jackChanelList;
}

-(void) dealloc{
	[ipAddress release];
	
	[super dealloc];
}



@end
