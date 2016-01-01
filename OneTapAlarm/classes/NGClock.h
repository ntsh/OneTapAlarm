//
//  NGClock.h
//  OneTapAlarm
//
//  Created by NG on 01/01/16.
//  Copyright (c) 2016 Neetesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGTime.h"

@interface NGClock : NSObject <NSCoding>

@property int clockId;
@property NGTime *alarmTime;
@property int status; // on : 1, off : 0

@end
