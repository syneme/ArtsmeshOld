//
//  RestUser.m
//  Artsmesh
//
//  Created by hui on 10-8-8.
//  Copyright (c) 2010年 __MyCompanyName__. All rights reserved.
//

#import "ArtsmeshUser.h"


@implementation ArtsmeshUser

static NSString *xslTemplate = nil;

+ (void)initialize {
    if (xslTemplate == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foaf" ofType:@"xslt"];
        NSError *error;
        xslTemplate = [NSString stringWithContentsOfFile:path
                                                encoding:NSUTF8StringEncoding
                                                   error:&error];
    }
}

- (id)init {
    if ((self = [super init])) {
    }

    return self;
}

- (void)dealloc {

    [super dealloc];
}

@synthesize name;
@synthesize status;
@synthesize accountProfilePage;
@synthesize hasLogon;
@synthesize hasiChatLogon;
@synthesize message;

- (id)init:(NSXMLNode *)node {
    if ((self = [super init])) {
        NSError *err = nil;
        NSXMLNode *element = nil;

        if ([[node name] isEqualToString:@"message"]) {
            message = [[[JackRESTMessage alloc] init:node] autorelease];
        }
        else {
            element = [[node nodesForXPath:@"Name" error:&err] objectAtIndex:0];
            name = [element stringValue];
            element = [[node nodesForXPath:@"Status" error:&err] objectAtIndex:0];
            status = [[element stringValue] integerValue];
        }

        [element release];
        [err release];
    }

    return self;
}

- (id)initUserName:(NSString *)userName {
    if ((self = [super init])) {
        name = userName;
    }

    return self;
}

- (NSString *)toXmlString {
    return [[NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8' ?><user><Name>%@</Name><Status>%i</Status></user>", name, (int) status] autorelease];
}

+ (NSString *)getCreateUserUrl {
    return [[NSString stringWithFormat:@"%@/users.xml", [JackRESTRoom getHostUrl]] autorelease];
}

+ (NSString *)getRemoveUserUrl:(NSString *)userName {
    return [[NSString stringWithFormat:@"%@/users/%@.delete.xml", [JackRESTRoom getHostUrl], userName] autorelease];
}

+ (NSString *)getFriendsUrl:(NSString *)userName {
    return [[NSString stringWithFormat:@"%@/%@/foaf", [StatusNetUser getHostUrl], userName] autorelease];
}

+ (NSString *)getAllLogonUrl {
    return [[NSString stringWithFormat:@"%@/users/all.xml", [JackRESTRoom getHostUrl]] autorelease];
}

+ (id)login:(NSString *)userName {
    NSString *data = [HttpRequestHelper sendPOSTRequestWithXmlText:[ArtsmeshUser getCreateUserUrl]
                                                           xmlText:[[[ArtsmeshUser alloc] initUserName:userName] toXmlString]];
    if (data == nil) {
        ArtsmeshUser *userEmptyInfo = [[ArtsmeshUser alloc] init];
        [data release];
        return [userEmptyInfo autorelease];
    }

    NSError *err = nil;
    NSXMLDocument *xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data
                                                                  options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA)
                                                                    error:&err];
    [data release];
    if (err != nil) {
        ArtsmeshUser *userEmptyInfo = [[ArtsmeshUser alloc] init];
        [err release];
        [xmlDocument release];
        return [userEmptyInfo autorelease];
    }

    ArtsmeshUser *userInfo = [[ArtsmeshUser alloc] init:[xmlDocument rootElement]];
    [err release];
    [xmlDocument release];
    return [userInfo autorelease];
}

+ (JackRESTMessage *)logout:(NSString *)userName {
    NSString *data = [HttpRequestHelper sendGETRequest:[ArtsmeshUser getRemoveUserUrl:userName]];
    if (data == nil) {
        JackRESTMessage *messageEmptyInfo = [[JackRESTMessage alloc] init];
        [data release];
        return [messageEmptyInfo autorelease];
    }

    NSError *err = nil;
    NSXMLDocument *xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data
                                                                  options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA)
                                                                    error:&err];
    [data release];
    if (err != nil) {
        JackRESTMessage *messageEmptyInfo = [[JackRESTMessage alloc] init];
        [err release];
        [xmlDocument release];
        return [messageEmptyInfo autorelease];
    }

    JackRESTMessage *messageInfo = [[JackRESTMessage alloc] init:[xmlDocument rootElement]];
    [err release];
    [xmlDocument release];
    return [messageInfo autorelease];
}

+ (NSString *)getFriendsHTML:(NSString *)userName {
    NSString *data = [HttpRequestHelper sendGETRequest:[ArtsmeshUser getFriendsUrl:userName]];

    if (data == nil) {
        [data release];
        return nil;
    }

    NSError *err = nil;
    NSXMLDocument *xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data
                                                                  options:NSXMLDocumentTidyHTML
                                                                    error:&err];

    [xmlDocument autorelease];
    [data release];

    if (err != nil) {
        return nil;
    }


    NSXMLDocument *transformedData = (NSXMLDocument *) [xmlDocument
            objectByApplyingXSLTString:xslTemplate
                             arguments:nil  // no extra XSLT parameters needed
                                 error:&err];

    if (err != nil) {
        return nil;
    }

    return [transformedData XMLString];
}

+ (NSArray *)getFriends:(NSString *)userName {
    NSString *data = [HttpRequestHelper sendGETRequest:[ArtsmeshUser getFriendsUrl:userName]];
    NSMutableArray *friends = [[NSMutableArray alloc] init];
    if (data == nil) {
        [data release];
        return (NSArray *) [friends autorelease];
    }

    NSError *err = nil;
    NSXMLDocument *xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data
                                                                  options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA)
                                                                    error:&err];
    [data release];
    if (err != nil) {
        [err release];
        [xmlDocument release];
        return (NSArray *) [friends autorelease];
    }

    NSXMLNode *node = nil;
    NSXMLNode *element = nil;
    NSArray *elements = nil;
    NSArray *nodes = [[xmlDocument rootElement] nodesForXPath:@"Agent" error:&err];
    if (err != nil) {
        [err release];
        [element release];
        [elements release];
        [node release];
        [nodes release];
        [xmlDocument release];
        return (NSArray *) [friends autorelease];
    }

    for (node in nodes) {
        elements = [node nodesForXPath:@"name" error:&err];
        if ([elements count] == 1) {
        }
        else {
            ArtsmeshUser *user = [[ArtsmeshUser alloc] init];
            element = [[node nodesForXPath:@"account/OnlineAccount/accountName" error:&err] objectAtIndex:0];
            user.name = [element stringValue];
            NSXMLElement *elementNode = [[node nodesForXPath:@"account/OnlineAccount/accountProfilePage" error:&err] objectAtIndex:0];
            user.accountProfilePage = [[elementNode attributeForName:@"rdf:resource"] stringValue];
            [elementNode release];
            [friends addObject:[user autorelease]];
        }
    }

    [err release];
    [element release];
    [elements release];
    [node release];
    [nodes release];
    [xmlDocument release];
    return (NSArray *) [friends autorelease];
}

+ (NSArray *)getFriendsWithStatus:(NSString *)userName {
    NSArray *friends = [ArtsmeshUser getFriends:userName];
    NSDictionary *allUsers = [ArtsmeshUser allLogon];
    for (ArtsmeshUser *user in friends) {
        user.hasLogon = [[allUsers allKeys] containsObject:user.name];
        iChatBuddy *buddy = [ChatTaskHelper getBuddyWithArtsmeshUserName:user.name];
        user.hasiChatLogon = (buddy.status == iChatAccountStatusAvailable);
    }
    [allUsers release];
    return [friends autorelease];
}

//+(BOOL) hasLogon:(NSString *) userName{
//	NSString * data = [HttpRequestHelper sendGETRequest:[ArtsmeshUser getHasLogonUrl:userName]];
//    if(data == nil){
//        [data release];
//        return NO;
//    }
//
//    NSError * err = nil;
//	NSXMLDocument * xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data
//                                                                   options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA)
//                                                                     error:&err];
//    [data release];
//    if(err != nil){
//		return NO;
//	}
//
//	BOOL has = YES;
//    ArtsmeshUser * userInfo = [[ArtsmeshUser alloc] init:[xmlDocument rootElement]];
//	if ([userInfo.message.contents isEqualToString:@"empty"]) {
//		has = NO;
//	}
//
//    [err release];
//    [xmlDocument release];
//    [userInfo release];
//	return has;
//}
+ (NSDictionary *)allLogon {
    NSString *data = [HttpRequestHelper sendGETRequest:[ArtsmeshUser getAllLogonUrl]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (data == nil) {
        [data release];
        return (NSDictionary *) [dic autorelease];
    }

    NSError *err = nil;
    NSXMLDocument *xmlDocument = [[NSXMLDocument alloc] initWithXMLString:data
                                                                  options:(NSXMLNodePreserveWhitespace | NSXMLNodePreserveCDATA)
                                                                    error:&err];
    [data release];
    if (err != nil) {
        [err release];
        [xmlDocument release];
        return (NSDictionary *) [dic autorelease];
    }
    NSXMLNode *node = nil;
    NSArray *nodes = [[xmlDocument rootElement] nodesForXPath:@"user" error:&err];
    for (node in nodes) {
        ArtsmeshUser *userInfo = [[ArtsmeshUser alloc] init:node];
        [dic setObject:[userInfo autorelease] forKey:userInfo.name];
    }
    [err release];
    [node release];
    [xmlDocument release];
    return (NSDictionary *) [dic autorelease];
}

@end
