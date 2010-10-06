//
//  FOAFDataSourceController.h
//  Artsmesh
//
//  Created by Sky Jia on 8/15/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ArtsmeshUser.h"

@interface FOAFDataSourceController : NSObject {
	NSArray * artsmeshUserList;
}

@property (assign) NSArray * artsmeshUserList;  

- (void) loadFOAFInfomationWithFriendName:(NSString *)name;

@end
