//
//  IPHostDataSourceController.h
//  Artsmesh
//
//  Created by Sky Jia on 8/20/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ArtsmeshConstDefinition.h"

@interface IPHostDataSourceController : NSObject {
	NSArray * myHostIPAddresseList;
	BOOL isIPv6;
}

@property (assign) NSArray *myHostIPAddresseList;
@property (assign) BOOL isIPv6;

-(void) getMyHostIPAddressList;

@end
