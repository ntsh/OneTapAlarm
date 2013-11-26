//
//  NGClockView.m
//  OneTapAlarm
//
//  Created by NG on 10/11/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import "NGClockView.h"

@interface NGClockView ()
@property UIView *golaParent;
@property UIImageView *golaView;
@property float theta;
@end

@implementation NGClockView

- (id)initWithFrame:(CGRect)frame andRadius:(int)radius delegate:(id)aDelegate {
    self = [super initWithFrame:frame];
    delegate = aDelegate;
    [self setRadius:radius];

    if (self) {
        [self addClock];

        NGTime *zeroTime = [NGTime alloc];
        [zeroTime setTime:0 :0];
        [self setTime:zeroTime];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    NSLog(@"View: %f,%f",touchLocation.x, touchLocation.y);
    [self handleTouch:touchLocation];
    return;
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouch:touchLocation];
}

- (void)handleTouch:(CGPoint) touchLocation {
    NGTime *time = [self getTimeFromCoordinates:touchLocation];
    [self setTime:time];
    [self animateClockSetTime];
    [delegate handleTouchClock:self];
    return;
}

- (NGTime *) getTimeFromCoordinates:(CGPoint) point {
    int R = [self radius];
    float touchx = point.x;
    float touchy = point.y;
    self.theta = atan2(touchx - R, R - touchy);
    float theta = self.theta;
    float hour_hand = 6 / M_PI * theta ;
    if (hour_hand < 1) {
        hour_hand = hour_hand + 12;
    }
    int time_hour = (int) hour_hand;
    float time_min = 0.6 * ((hour_hand * 100) - (time_hour * 100));
    float fraction = time_min /5;
    int integertime = time_min/5;
    float part = fraction-integertime;
    int modvalue = part*5;
    //Round off time minute if minute > 2
    if(modvalue > 2) {
        time_min = time_min+(5-modvalue);
    } else {
        time_min=time_min-modvalue;
    }
    if ((int)time_min == 60) {
        time_min = 0;
        time_hour = time_hour + 1;
    }
    if (time_hour == 13) time_hour = 1;
    NGTime *time = [NGTime alloc];
    [time setTime:time_hour :time_min];
    return time;
}

- (void) addClock {
    CGRect imageRect = CGRectMake(0, 0, 2 * self.radius, 2 * self.radius);
    UIImage *imgClock = [UIImage imageNamed:@"Clock"];
    UIImageView *clockView = [[UIImageView alloc] initWithFrame:imageRect];
    [clockView setImage:imgClock];
    [clockView setBounds:imageRect];
    clockView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:clockView];

    [self addGola];
    return;
}

- (void) addGola {
    self.golaParent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * self.radius, 2* self.radius)];
    self.golaView = [[UIImageView alloc] initWithFrame:CGRectMake( 4, 4, 25, 25)];
    self.golaView.image = [UIImage imageNamed:@"gola"];
    self.golaView.contentMode = UIViewContentModeScaleAspectFit;
    //golaView.center = CGPointMake(clockCenterX,clockCenterY - (R-24));
    self.golaView.center = CGPointMake(self.radius,24);
    [self.golaParent addSubview:self.golaView];
    [self addSubview: self.golaParent];
}

- (void) animateClockSetTime {
    [[self.golaView layer] setAnchorPoint:CGPointMake(0.5, 0.5)];

    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         self.golaParent.transform = CGAffineTransformMakeRotation(self.theta);
                         //clockView.transform = CGAffineTransformMakeRotation(theta);
                     }
                     completion:^(BOOL finished) {
                     }];

}

@end