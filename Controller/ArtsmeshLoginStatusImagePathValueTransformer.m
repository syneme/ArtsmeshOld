//
//  IMStatusImagePathValueTransformer.m
//  Artsmesh
//
//  Created by Sky Jia on 8/17/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "ArtsmeshLoginStatusImagePathValueTransformer.h"


@implementation ArtsmeshLoginStatusImagePathValueTransformer


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
		return [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/status-available-flat-etched.tif"];
	}
	else
	{
		return [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/status-invisible-flat-etched.tif"];
	}
}


@end
