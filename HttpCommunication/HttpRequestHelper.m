//
//  RESTfulHelper.m
//  TerminalTaskCaller
//
//  Created by Sky Jia on 7/22/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "HttpRequestHelper.h"


@implementation HttpRequestHelper

#pragma mark -
#pragma mark GET

+(NSString*) sendGETRequest:(NSString*)baseURLString
{	
	return [HttpRequestHelper sendGETRequest:baseURLString username:nil password:nil];
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

#pragma mark -
#pragma mark POST

+(NSString*) sendPOSTRequest:(NSString*)baseURLString 
	       postDataArray:(NSArray*)postDataArray
{	
	return [HttpRequestHelper sendPOSTRequest:baseURLString postDataArray:postDataArray username:nil password:nil];
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
	
	HttpPostData *postKeyValue;
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
	return [HttpRequestHelper sendPOSTRequestWithXmlText:baseURLString xmlText:xmlText username:nil password:nil];
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
