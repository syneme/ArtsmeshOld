//
//  LeftPaneView.m
//  Artsmesh
//
//  Created by Sky Jia on 7/17/11.
//  Copyright 2011 HUST. All rights reserved.
//

#import "MainBackgroundView.h"


@implementation MainBackgroundView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void) awakeFromNib{
    mBackgroundColor=NSColor.whiteColor;
}

- (void)dealloc
{
    [mBackgroundColor release];
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [mBackgroundColor set];
    [NSBezierPath fillRect:dirtyRect];
    
}

@end
