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
    }
    
    return self;
}

- (void)dealloc {
    [self.contents release];
    [super dealloc];
}

-(id) init:(NSXMLNode *) node{
    if ((self = [super init])) {
        self.contents = [node stringValue];
    }
    return self;
}

@end
