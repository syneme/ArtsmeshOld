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
        // Initialization code here.
    }
    
    return self;
}

-(void) awakeFromNib{
    //NSString *path = [[NSBundle mainBundle]  pathForImageResource: @"MainBackgroundPattern"];
    //NSImage *pattern = [[NSImage alloc] initByReferencingFile: path];
    //mBackgroundColor = [[NSColor colorWithPatternImage: [pattern autorelease]] retain];
    mBackgroundColor = [NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:1.0];
}

- (void)dealloc
{
    [mBackgroundColor release];
    
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    
    [mBackgroundColor set];
    [NSBezierPath fillRect:dirtyRect];
    
}

@end
