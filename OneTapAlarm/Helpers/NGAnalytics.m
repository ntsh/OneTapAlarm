//
//  NGAnalytics.m
//  OneTapAlarm
//
//  Created by NG on 14/05/17.
//  Copyright © 2017 Neetesh Gupta. All rights reserved.
//

#import "NGAnalytics.h"
#import "Flurry.h"

@implementation NGAnalytics

+ (void)initializeAnalytics {
    // Read config file
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flurry-config" ofType:@"plist"]];
    NSString *apiKey = [dictionary objectForKey:@"api-key"];

    // Start tracking
    [Flurry startSession:apiKey
      withSessionBuilder:[[[FlurrySessionBuilder new]
                           withCrashReporting:YES]
                          withLogLevel:FlurryLogLevelDebug]];

}

+ (void)trackAlarmTriggered {
    [Flurry logEvent:@"Alarm_Triggered"];
}

+ (void)trackAlarmStopped {
    [Flurry logEvent:@"Alarm_Stopped"];
}

@end
