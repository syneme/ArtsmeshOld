//
//  StatusNetTimeline.h
//  Artsmesh
//
//  Created by WANG Hailei on 8/12/10.
//  Copyright 2010 Farefore Co. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferencesHelper.h"
#import "StatusNetStatus.h"

@interface StatusNetTimeline : NSObject

@property (retain) NSArray * statusNetTimelineMessages;

- (void) prepareStatusNetTimelineMessages;

@end
