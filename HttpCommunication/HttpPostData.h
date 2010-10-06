//
//  RESTfulPostData.h
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/22/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HttpPostData : NSObject {
	NSString *key;
	NSString *value;
}

@property (assign) NSString *key;
@property (assign) NSString *value;

@end
