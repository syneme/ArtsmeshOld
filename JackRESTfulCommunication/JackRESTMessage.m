//
//  RestMessage.m
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import "JackRESTMessage.h"


@implementation JackRESTMessage

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@synthesize contents;

-(id) initContents:(NSString *) msg{
    if ((self = [super init])) {
        contents = msg;
    }
    
    return self;
}
-(id) init:(NSXMLNode *) node{
    if ((self = [super init])) {
        NSError * err = nil;
        
        contents = [node stringValue];
        
        [err release];
    }
    
    return self;
}

@end
