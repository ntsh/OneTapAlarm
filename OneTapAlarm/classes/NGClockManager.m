//
//  NGClockManager.m
//  OneTapAlarm
//
//  Created by NG on 01/01/16.
//  Copyright (c) 2016 Neetesh Gupta. All rights reserved.
//

#import "NGClockManager.h"

@implementation NGClockManager

+ (NSMutableArray *)getAllClocks {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    dataArray = [NSKeyedUnarchiver
                 unarchiveObjectWithFile: [self dataFilePath]];
    return dataArray;
}

+ (NGClock *)getClockWithClockId:(int)clockId {
    NSArray *clocks = [self getAllClocks];
    for (NGClock *clock in clocks) {
        if (clock.clockId == clockId) {
            return clock;
        }
    }
    return nil;
}

+ (void)saveClock:(NGClock *)clock {
    NSMutableArray *userArray = [self getAllClocks];
    if (userArray == nil) {
        userArray = [[NSMutableArray alloc] init];
    }
    [userArray addObject:clock];
    [NSKeyedArchiver archiveRootObject:userArray toFile:[self dataFilePath]];

}

+ (NSString*)dataFilePath {
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;

    filemgr = [NSFileManager defaultManager];
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    return [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"clocks.archive"]];
}

@end
