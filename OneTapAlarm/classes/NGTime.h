//
//  NGTime.h
//  OneTapAlarm
//
//  Created by NG on 09/11/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGTime : NSObject

@property int hour;
@property int minute;

- (id) initWithTime:(NSDate *)time;
- (id) initWithCurrentTime;
-(void)setTime:(int)hr :(int)min;
-(NSString*)getTime;
- (float)getHourHandAngle; //Return Angle in radians that the hour hand is tilted.
- (int)getSecondsFrom12; //Returns Number of seconds to this time from 12'O Clock.

@end
