//
//  RESTfulHelper.m
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/22/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "RESTfulRequestHelper.h"


@implementation RESTfulRequestHelper

// GET
+(NSString*) sendGETRequest:(NSString*)baseURLString
{	
	return [RESTfulRequestHelper sendGETRequest:baseURLString username:nil password:nil];
}

+(NSString*) sendGETRequest:(NSString*)baseURLString 
				   username:(NSString*)username 
				   password:(NSString*)password
{
	NSURL *url=[NSURL URLWithString:baseURLString];
	NSString *result=nil;
	
	ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
	if(username!=nil)
		[request setUsername:username];
	
	if(password!=nil)
		[request setPassword:password];
	
	[request startSynchronous];
	NSError *error=[request error];
	if(!error){
		result=[request responseString];
	}
	
	return result;
}

// POST
+(NSString*) sendPOSTRequest:(NSString*)baseURLString 
			   postDataArray:(NSArray*)postDataArray
{	
	return [RESTfulRequestHelper sendPOSTRequest:baseURLString postDataArray:postDataArray username:nil password:nil];
}

+(NSString*) sendPOSTRequest:(NSString*)baseURLString 
		postDataArray:(NSArray*)postDataArray 
					username:(NSString*)username 
					password:(NSString*)password
{
	NSURL *url=[NSURL URLWithString:baseURLString];
	NSString *result=nil;
	
	ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
	
	if(username!=nil)
		[request setUsername:username];
	
	if(password!=nil)
		[request setPassword:password];
	
	RESTfulPostData *postKeyValue;
	for(postKeyValue in postDataArray)
	{
		[request addPostValue:postKeyValue.value forKey:postKeyValue.key];
	}
	
	[request startSynchronous];
	
	NSError *error=[request error];
	if(!error){
		result=[request responseString];
	}
	
	return result;
}

+(NSString*) sendPOSTRequestWithXmlText:(NSString*)baseURLString 
					xmlText:(NSString*)xmlText 
{
	return [RESTfulRequestHelper sendPOSTRequestWithXmlText:baseURLString xmlText:xmlText username:nil password:nil];
}

+(NSString*) sendPOSTRequestWithXmlText:(NSString*)baseURLString 
					xmlText:(NSString*)xmlText 
					username:(NSString*)username 
					password:(NSString*)password
{
	NSURL *url=[NSURL URLWithString:baseURLString];
	NSString *result=nil;
	
	ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
	
	if(username!=nil)
		[request setUsername:username];
	
	if(password!=nil)
		[request setPassword:password];
	
	
	[request appendPostData:[xmlText dataUsingEncoding:NSUTF8StringEncoding]];
	[request addRequestHeader:@"Content-Type" value:@"application/xml"];
	[request setRequestMethod:@"POST"];
	
	[request startSynchronous];
	
	NSError *error=[request error];
	if(!error){
		result=[request responseString];
	}
	
	return result;
}

@end
