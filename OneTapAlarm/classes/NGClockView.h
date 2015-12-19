//
//  NGClockView.h
//  OneTapAlarm
//
//  Created by NG on 10/11/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGTime.h"
#import <QuartzCore/QuartzCore.h>

IB_DESIGNABLE
@interface NGClockView : UIView

@property IBInspectable int radius;
@property IBInspectable id delegate;
@property NGTime *time;
@property IBInspectable UIColor *textColor;

- (void)setRadius:(int)radius delegate:(id)aDelegate;
- (void)updateTextColor:(UIColor *)textColor;
- (void)setNewTime:(NGTime *)time;

@end

@protocol handleTouchDelegate <NSObject>

-(void) handleTouchClock:self;

@end