//
//  RESTfulHelper.h
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/22/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RESTfulPostData.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface RESTfulRequestHelper : NSObject {

}

// GET
+(NSString*) sendGETRequest:(NSString*)baseURLString;

+(NSString*) sendGETRequest:(NSString*)baseURLString 
				   username:(NSString*)username 
				   password:(NSString*)password;

// POST
+(NSString*) sendPOSTRequest:(NSString*)postDataArray 
			   postDataArray:(NSArray*)postData;

+(NSString*) sendPOSTRequest:(NSString*)baseURLString 
			   postDataArray:(NSArray*)postDataArray 
					username:(NSString*)username 
					password:(NSString*)password;

+(NSString*) sendPOSTRequestWithXmlText:(NSString*)baseURLString 
					xmlText:(NSString*)xmlText;
+(NSString*) sendPOSTRequestWithXmlText:(NSString*)baseURLString 
					xmlText:(NSString*)textData 
					username:(NSString*)username 
					password:(NSString*)password;
@end
