//
//  RESTfulPostData.m
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/22/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "RESTfulPostData.h"


@implementation RESTfulPostData

@synthesize key;
@synthesize value;

-(void) dealloc{
	[key release];
	[value release];
	
	[super dealloc];
}


@end
