//
//  ProcessInfo.h
//  Artsmesh
//
//  Created by Sky Jia on 8/9/10.
//  Copyright 2010 Farefore. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ProcessInfo : NSObject {

@private
    int numberOfProcesses;
    NSMutableArray *processList;
}

- (id) init;

- (void)obtainFreshProcessList;
- (BOOL)findProcessWithName:(NSString *)procNameToSearch;


@end
