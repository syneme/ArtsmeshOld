//
//  OSCGroupTaskHelper.h
//  Artsmesh
//
//  Created by Sky Jia on 8/26/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferencesHelper.h"

#define kOSCGroupClientApplicationName @"OSCGroupClientGUI"

@interface OSCGroupTaskHelper : NSObject {

}

+(void) launchOSCGroupClientApplication;
+(void) quitOSCGroupClientApplication;

@end
