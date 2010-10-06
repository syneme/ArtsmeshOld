//
//  FOAFInformationWindowController.m
//  Artsmesh
//
//  Created by Sky Jia on 8/17/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "FOAFInformationWindowController.h"


@implementation FOAFInformationWindowController

static FOAFInformationWindowController * theInstance=nil;

+(void) initialize
{
	if (theInstance==nil) {
		theInstance=[[FOAFInformationWindowController alloc] init];
	}
}

+(FOAFInformationWindowController*) sharedInstance{
	return theInstance;
}

-(id) init{
	return [self initWithWindowNibName:@"FOAFInformationWindow"];
}

#pragma mark -

@synthesize table;
@synthesize dataSourceController;

- (void) showWindowWithFriendName:(NSString *)name
{
	[self.window setTitle:[NSString stringWithFormat:@"%@'s Friends", name]];
	[self showWindow:self];
	
	[self.dataSourceController loadFOAFInfomationWithFriendName:name];
	[self.table reloadData];
}

@end
