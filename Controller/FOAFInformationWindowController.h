//
//  FOAFInformationWindowController.h
//  Artsmesh
//
//  Created by Sky Jia on 8/17/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

#import "ArtsmeshUser.h"

@class ArtsmeshUser;
@class WebView;

@interface FOAFInformationWindowController: NSWindowController{
    WebView * webView;
    bool loadingBlankPage;
}

@property (assign) IBOutlet WebView * webView;

- (void) showWindowWithFriendName:(NSString *)name;


@end
