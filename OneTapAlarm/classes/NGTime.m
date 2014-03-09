//
//  NGTime.m
//  OneTapAlarm
//
//  Created by NG on 09/11/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import "NGTime.h"

@implementation NGTime

- (id) initWithTime:(NSDate *)time {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *timeComponent = [calendar components: (NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                                                  fromDate: time];
    [self setTime:[timeComponent hour] :[timeComponent minute] :[timeComponent second]];
    return self;
}

- (id) initWithCurrentTime {
    NSDate *now = [NSDate date];
    return [self initWithTime:now];
}


- (void)setTime:(int)hr :(int)min {
    [self setHour:hr];
    [self setMinute:min];
}

- (void)setTime:(int)hr :(int)min :(int)sec{
    [self setHour:hr];
    [self setMinute:min];
    [self setSecond:sec];
}

- (NSString*) getTime {
    NSString *timeFormatted = [NSString stringWithFormat:@"%d:%02d",self.hour,self.minute];
    return timeFormatted;
}

- (int)getSecondsFrom12 {
    return 60 * 60 * [self hour] + 60 * [self minute] + [self second];
}

- (float)getHourHandAngle {
    int timeHour = [self hour];
    int timeMinute = [self minute];
    if(timeHour >= 12) {
        timeHour = timeHour - 12;
        [self setHour:timeHour];
    }
    float theta = ((float)timeHour + ((float)timeMinute)/60) * M_PI / 6;
    if(timeHour == 0)
        [self setHour:12];
    return theta;
}

@end
