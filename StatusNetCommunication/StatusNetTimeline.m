//
//  StatusNetTimeline.m
//  Artsmesh
//
//  Created by WANG Hailei on 8/12/10.
//  Copyright 2010 Farefore Co. All rights reserved.
//

#import "StatusNetTimeline.h"


@implementation StatusNetTimeline

@synthesize statusNetTimelineMessages;

- (void) prepareStatusNetTimelineMessages {
	NSString *myUserName=[PreferencesHelper statusNetUserName];
	
	if(myUserName!=nil)
	{		
		self.statusNetTimelineMessages = [StatusNetStatus getStatusNetFriendsStatuses:myUserName];
	}
}

@end
