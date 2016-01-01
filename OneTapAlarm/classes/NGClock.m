//
//  NGClock.m
//  OneTapAlarm
//
//  Created by NG on 01/01/16.
//  Copyright (c) 2016 Neetesh Gupta. All rights reserved.
//

#import "NGClock.h"

@implementation NGClock

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.clockId = [decoder decodeIntForKey:@"clockId"];
    self.alarmTime = [decoder decodeObjectForKey:@"alarmTime"];
    self.status = [decoder decodeIntForKey:@"status"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.clockId forKey:@"clockId"];
    [encoder encodeObject:self.alarmTime forKey:@"alarmTime"];
    [encoder encodeInt:self.status forKey:@"status"];
}

@end
