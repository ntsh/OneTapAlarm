//
//  NGNotificationUtility.m
//  OneTapAlarm
//
//  Created by NG on 08/05/17.
//  Copyright © 2017 Neetesh Gupta. All rights reserved.
//

#import "NGNotificationUtility.h"

@implementation NGNotificationUtility

+ (BOOL)hasNotificationPermission {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]){ // iOS 8+
        UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];

        if (grantedSettings.types == UIUserNotificationTypeNone) {
            NSLog(@"No notif permission");
            return NO;
        }
        else {
            NSLog(@"Has notif permission");
            return YES;
        }
    }
    // don't need local notification permission for ios 7
    return YES;
}

+ (void)requestNotificationPermission {
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
                                                                                                              categories:nil]];
    }
}

@end
