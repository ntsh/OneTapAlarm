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

-(void)setTime:(int)hr :(int)min;
-(NSString*)getTime;

@end
