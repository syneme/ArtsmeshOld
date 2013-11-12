//
//  MainSplitView.m
//  Artsmesh
//
//  Created by Sky Jia on 7/17/11.
//  Copyright 2011 HUST. All rights reserved.
//

#import "MainSplitView.h"


@implementation MainSplitView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) drawDividerInRect:(NSRect)rect{
    NSColor * color = [NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:1.0];
    [color set];
    
    NSRectFill(rect);
}

@end
