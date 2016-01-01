//
//  NGClockManager.h
//  OneTapAlarm
//
//  Created by NG on 01/01/16.
//  Copyright (c) 2016 Neetesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGClock.h"

@interface NGClockManager : NSObject

+ (NSMutableArray *)getAllClocks;
+ (void)saveClock:(NGClock *)clock;

@end
