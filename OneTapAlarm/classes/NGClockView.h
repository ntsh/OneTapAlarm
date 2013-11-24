//
//  NGClockView.h
//  OneTapAlarm
//
//  Created by NG on 10/11/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NGClockView : UIView {
    id delegate;
}

- (id)initWithFrame:(CGRect)frame andRadius:(int)radius delegate:(id)aDelegate;

@end

@protocol handleTouchDelegate <NSObject>

-(void) handleTouchClock:self;

@end