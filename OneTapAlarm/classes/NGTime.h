//
//  NGTime.h
//  OneTapAlarm
//
//  Created by NG on 09/11/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGTime : NSObject <NSCoding>

@property int hour;
@property int minute;
@property int second;

- (id) initWithTime:(NSDate *)time;
- (id) initWithCurrentTime;
-(void)setTime:(int)hr :(int)min;
-(void)setTime:(int)hr :(int)min :(int)sec;
-(NSString*)getTime;
- (float)getHourHandAngle; //Return Angle in radians that the hour hand is tilted.
- (int)getSecondsFrom12; //Returns Number of seconds to this time from 12'O Clock.

@end
