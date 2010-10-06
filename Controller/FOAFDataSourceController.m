//
//  FOAFDataSourceController.m
//  Artsmesh
//
//  Created by Sky Jia on 8/15/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import "FOAFDataSourceController.h"


@implementation FOAFDataSourceController

@synthesize artsmeshUserList;

- (NSInteger) numberOfRowsInTableView: (NSTableView *)tableView
{
	if (artsmeshUserList==nil) {
		return 0;
	}
	else {
		return [artsmeshUserList count];
	}
}

- (id)tableView:(NSTableView *)aTableView 
objectValueForTableColumn:(NSTableColumn *)aTableColumn 
			row:(NSInteger)rowIndex
{
	NSString * identifier=[aTableColumn identifier];
	
	ArtsmeshUser * user=[artsmeshUserList objectAtIndex:rowIndex];
	return [user valueForKey:identifier];
}

- (void) loadFOAFInfomationWithFriendName:(NSString *)name
{
	self.artsmeshUserList=[ArtsmeshUser getFriends:name];
}

@end
