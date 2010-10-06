//
//  FOAFInformationWindowController.h
//  Artsmesh
//
//  Created by Sky Jia on 8/17/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FOAFDataSourceController.h"

@interface FOAFInformationWindowController : NSWindowController{
}

+(FOAFInformationWindowController*) sharedInstance;

@property (assign) IBOutlet NSTableView * table;
@property (assign) IBOutlet FOAFDataSourceController * dataSourceController;

- (void) showWindowWithFriendName:(NSString *)name;


@end
