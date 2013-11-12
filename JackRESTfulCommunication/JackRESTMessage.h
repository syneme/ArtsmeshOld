//
//  RestMessage.h
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JackRESTMessage : NSObject {
@private
    NSString * contents;
}

@property (retain) NSString * contents;

-(id) init:(NSXMLNode *) node;
-(id) initContents:(NSString *) msg;

@end
