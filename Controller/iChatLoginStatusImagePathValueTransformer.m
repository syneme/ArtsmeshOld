//
//  iChatLoginStatusImagePathValueTransformer.m
//  Artsmesh
//
//  Created by WANG Hailei on 8/18/10.
//  Copyright 2010 Farefore Co. All rights reserved.
//

#import "iChatLoginStatusImagePathValueTransformer.h"


@implementation iChatLoginStatusImagePathValueTransformer


+ (Class) transformedValueClass {
	return [NSString self];
}

+ (BOOL) allowsReverseTransformation {
	return NO;
}

- (id) transformedValue:(id)value {
	
	if (value == nil) {
		return nil;
	}
	
	if ([value boolValue]==YES) {
		return [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/iChatOnline.tiff"];
	}
	else
	{
		return nil;
	}
}



@end
