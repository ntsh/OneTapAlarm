//
//  NGAppDelegate.m
//  OneTapAlarm
//
//  Created by Neetesh Gupta on 29/12/12.
//  Copyright (c) 2012 Neetesh Gupta. All rights reserved.
//

#import "NGAppDelegate.h"
#import "NGTime.h"
#import "NGNotificationUtility.h"
#import "NGViewController.h"
#import "NGAnalytics.h"

@implementation NGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize Analytics
    [NGAnalytics initializeAnalytics];

    // Override point for customization after application launch.
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification) {
        [NGAnalytics trackAlarmTriggered];
    }

    // request notification permission
    [NGNotificationUtility requestNotificationPermission];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NSLog(@"Application entered background state.");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
    [application cancelAllLocalNotifications];
    NGViewController* rootVC = (NGViewController *)[self.window rootViewController];

    UIApplicationState state = [application applicationState];
    if(state == UIApplicationStateInactive || state == UIApplicationStateBackground){
        NSLog(@"App inactive or background - Notif tapped");
        [rootVC didTapOnLocalNotification:notif.alertBody];
    } else if(state == UIApplicationStateActive) {
        NSLog(@"App active - Local Notification received");
        // Notify the view controller about notification
        [rootVC didReceiveLocalNotification:notif.alertBody];
    }

    // Track alarm triggered event on Analytics
    [NGAnalytics trackAlarmTriggered];

    return;
}

@end
