//
//  RestMessage.h
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JackRESTMessage : NSObject

@property(nonatomic, copy) NSString *contents;

-(id) init:(NSXMLNode *) node;

@end
