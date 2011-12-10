//
//  FOAFInformationWindowController.m
//  Artsmesh
//
//  Created by Sky Jia on 8/17/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "FOAFInformationWindowController.h"


@implementation FOAFInformationWindowController


-(id) init{
	return [self initWithWindowNibName:@"FOAFInformationWindow"];
}

-(void) awakeFromNib{
    [self.webView setHidden:YES];
}

#pragma mark -

@synthesize webView;

- (void) showWindowWithFriendName:(NSString *)name
{
	[self.window setTitle:[NSString stringWithFormat:@"%@ & Friends", name]];
	[self showWindow:self];
    
    NSString * html = [ArtsmeshUser getFriendsHTML:name];
	 
    [self.webView setPolicyDelegate:self]; 
    [[self.webView mainFrame] loadHTMLString:html baseURL:nil];
    
    [self.webView setHidden:NO];
}

-(void) webView:sender decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener{
   
    if(loadingBlankPage)
    {
        [listener use];
        return;
    }
    
    if ([actionInformation objectForKey:WebActionElementKey]) {
        [listener ignore];
        [[NSWorkspace sharedWorkspace] openURL:[request URL]];
    } else {
        [listener use];
    }
}

-(void) dealloc{
    [webView release];
    
    [super dealloc];
}

@end
