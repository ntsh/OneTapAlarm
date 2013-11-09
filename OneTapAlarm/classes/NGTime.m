//
//  NGTime.m
//  OneTapAlarm
//
//  Created by NG on 09/11/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import "NGTime.h"

@implementation NGTime

- (void)setTime:(int)hr :(int)min {
    [self setHour:hr];
    [self setMinute:min];
}

- (NSString*) getTime {
    NSString *timeFormatted = [NSString stringWithFormat:@"%d:%d",self.hour,self.minute];
    return timeFormatted;
}

@end
