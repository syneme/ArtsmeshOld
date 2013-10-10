//
//  IPHostDataSourceController.m
//  Artsmesh
//
//  Created by Sky Jia on 8/20/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "IPHostDataSourceController.h"


@implementation IPHostDataSourceController

@synthesize myHostIPAddressList;
@synthesize isIPv6;

- (id) init {	
	if(self=[super init])
	{
		[self getMyHostIPAddressList];
	}

	return self;
}

-(void) getMyHostIPAddressList{
	
	isIPv6=NO;
	NSString *ipAddressVersion=[[NSUserDefaults standardUserDefaults] stringForKey:kIPAddressVersion];
	if([ipAddressVersion isEqualToString:@"IPv6"])
		isIPv6=YES;
	
	[ipAddressVersion release];
	
	NSArray * originalIpAddressList=[[NSHost currentHost] addresses];
	NSMutableArray * retArray=[NSMutableArray arrayWithCapacity:1];
	
	NSString * ipAddress=nil;
	for(ipAddress in originalIpAddressList)
	{
		if ([ipAddress isEqualToString:@"127.0.0.1"])
			continue;
		else if ([ipAddress isEqualToString:@"::1"]) 
			continue;
		else if ([ipAddress isEqualToString:@"fe80::1%lo0"]) 
			continue;
		else if (isIPv6 && [ipAddress rangeOfString:@":"].location!=NSNotFound ) 
		{
			[retArray addObject:ipAddress];
		}
		else if (!isIPv6 && [ipAddress rangeOfString:@"."].location!=NSNotFound)
		{
			[retArray addObject:ipAddress];
		}
	}
	
	[originalIpAddressList release];
	
	self.myHostIPAddressList =(NSArray*)retArray;
}

@end
