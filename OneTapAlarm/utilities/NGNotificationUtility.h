//
//  NGNotificationUtility.h
//  OneTapAlarm
//
//  Created by NG on 08/05/17.
//  Copyright © 2017 Neetesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGNotificationUtility : NSObject

+ (BOOL)hasNotificationPermission;
+ (void)requestNotificationPermission;

@end
