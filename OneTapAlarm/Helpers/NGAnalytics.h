//
//  NGAnalytics.h
//  OneTapAlarm
//
//  Created by NG on 14/05/17.
//  Copyright © 2017 Neetesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGAnalytics : NSObject

+ (void)initializeAnalytics;

+ (void)trackAlarmTriggered;

+ (void)trackAlarmStopped;

@end
