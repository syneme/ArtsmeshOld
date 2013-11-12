//
//  VATextFieldCell.m
//  Artsmesh
//
//  Created by Sky Jia on 7/17/11.
//  Copyright 2011 HUST. All rights reserved.
//

#import "VATextFieldCell.h"


@implementation VATextFieldCell

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y = theRect.origin.y - .5 + (theRect.size.height - titleSize.height) / 2.0;
    return titleFrame;
}

-(void) drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    [[self attributedStringValue] drawInRect:titleRect];
}

- (void)dealloc
{
    [super dealloc];
}

@end
