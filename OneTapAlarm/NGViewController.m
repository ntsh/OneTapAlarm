//
//  NGViewController.m
//  OneTapAlarm
//
//  Created by Neetesh Gupta on 29/12/12.
//  Copyright (c) 2012 Neetesh Gupta. All rights reserved.
//

#import "NGViewController.h"

@interface NGViewController ()

@end

@implementation NGViewController
int R = 120;
int clockCenterX = 160;
int clockCenterY = 240;
UIImageView *golaView;
UIImageView *clockView;
UILabel *timeLabel;
UISwitch *alarmStatus;
UIColor *textColor;
UIView *golaParent;
NGClockView *clockV;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setAppAtOldAlarm];

}

-(void) loadView
{
    textColor = [UIColor colorWithRed:0.5255 green:0.255 blue:0.255 alpha:1.0];
    [self setBackground];
    [self addClock];
    [self addAlarmSwitch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void) handleTouch:(CGPoint)touchLocation
{
    NGTime *time = [NGTime alloc];
    [time setTime:5 :10];
    NSLog(@"%@",[time getTime]);
    timeLabel.text = [NSString stringWithFormat:@"%@",[time getTime]];

    /*golaView.layer.anchorPoint = self.view.center;
    golaView.center  = CGPointMake(clockCenterX,clockCenterY - (R-24));;
    CATransform3D rotatedTransform = golaView.layer.transform;
    rotatedTransform = CATransform3DRotate(rotatedTransform, theta, 0.0f, 0.0f, 1.0f);
    golaView.layer.transform = rotatedTransform;*/
    //[self rotateView:golaView aroundPoint:self.view.center duration:2 degrees:theta];
   
}

- (void)rotateView:(UIView *)view
       aroundPoint:(CGPoint)rotationPoint
          duration:(NSTimeInterval)duration
           degrees:(CGFloat)degrees {
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation
                                           animationWithKeyPath:@"transform"];
    [rotationAnimation setDuration:duration];
    // Additional animation configurations here...
    
    // The anchor point is expressed in the unit coordinate
    // system ((0,0) to (1,1)) of the label. Therefore the
    // x and y difference must be divided by the width and
    // height of the view (divide x difference by width and
    // y difference by height).
    // CGPoint anchorPoint = CGPointMake((rotationPoint.x - CGRectGetMinX(view.frame))/CGRectGetWidth(view.bounds),
    //                                (rotationPoint.y - CGRectGetMinY(view.frame))/CGRectGetHeight(view.bounds));
    
    CGPoint anchorPoint = CGPointMake(160/CGRectGetWidth(view.bounds),320/CGRectGetHeight(view.bounds));
    [[view layer] setAnchorPoint:anchorPoint];
    //[[view layer] setPosition:rotationPoint]; // change the position here to keep the frame
    CATransform3D rotationTransform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    [rotationAnimation setToValue:
        [NSValue valueWithCATransform3D:rotationTransform]];
    
    // Add the animation to the views layer
    [[view layer] addAnimation:rotationAnimation
                        forKey:@"rotateAroundAnchorPoint"];
}

- (void)setBackground {
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
    contentView.backgroundColor = [UIColor whiteColor];
    self.view = contentView;
    self.view.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"background.png"]];
    return;
}

- (void)addClock {
    int screenHeight = self.view.bounds.size.height;
    clockCenterX = [UIScreen mainScreen].bounds.size.width/2;
    clockCenterY = screenHeight/2;
    NSLog(@"clockCenterY = %d, screenheight = %d, scr2 = %f",
          clockCenterY,screenHeight,self.view.bounds.size.height);

    //Adding clock image
    CGRect imageRect = CGRectMake(clockCenterX - R, clockCenterY - R, 2*R, 2*R);
    clockV = [[NGClockView alloc]initWithFrame:imageRect
                                                  andRadius:R
                                                   delegate:self];
    [clockV updateTextColor: textColor];
    [self.view addSubview:clockV];
    return;
}

- (void)addAlarmSwitch {
    alarmStatus = [[UISwitch alloc] initWithFrame:CGRectMake
                   (clockCenterX - 25, clockCenterY + R +50, 60, 40)];
    [alarmStatus setOnTintColor:textColor];
    [alarmStatus setAlpha:0.0];
    [alarmStatus addTarget:self action:@selector(toggleAlarm:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:alarmStatus];
    return;
}

- (void)handleTouchClock:(NGClockView *)clockView {
    [UIView animateWithDuration:1.0f
                          delay:0.5f
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         [alarmStatus setAlpha:1.0f];
                             //clockView.transform = CGAffineTransformMakeRotation(theta);
                     }
                     completion:^(BOOL finished)
                    {
                        [alarmStatus setOn:YES animated:YES];
                    }];
    NGTime *time = [clockView time];
    NSLog(@"Setting Alarm for time: %@",[time getTime]);
    [self setAlarmAtTime:time];
}

- (void)setAlarmAtTime:(NGTime*)alarmTime {
    NGTime *now = [[NGTime alloc]initWithCurrentTime];
    int nowSeconds = [now getSecondsFrom12];
    int alarmSeconds = [alarmTime getSecondsFrom12];
    int secondsRemain = alarmSeconds - nowSeconds;
    if (secondsRemain < 0) {
        secondsRemain += 60 * 60 * 12;
    }
        //secondsRemain = 10;
    NSDate *testDate = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsRemain];
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.fireDate = testDate;
    notification.alertBody = @"Time to wake up!!";
    notification.soundName = @"alarm_long.mp3";
        //notification.alertAction = @"Cancel Alarm";

    [self clearAnyPendingAlarms];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    NSLog(@"Set alarm after time: %d", secondsRemain);
    NSString *toastText = [NSString stringWithFormat:@"Alarm set for %@",[alarmTime getTime]];
    NSDictionary *options = @{kCRToastTextKey : toastText,
                              kCRToastFontKey : [UIFont fontWithName:@"HelveticaNeue-Light" size:24],
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : textColor,
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionLeft),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionRight),
                              kCRToastNotificationTypeKey: @(CRToastTypeNavigationBar),
                              };
    [CRToastManager dismissNotification:YES];
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                                NSLog(@"Completed");
                                        }];
}

- (void)clearAnyPendingAlarms {
    NSLog(@"Removing all Alarms");
    UIApplication* app = [UIApplication sharedApplication];
    NSArray* oldNotifications = [app scheduledLocalNotifications];
    // Clear out the old notification before scheduling a new one.

    if ([oldNotifications count] > 0) {
        NSLog(@"Fire Time:%@",[[[oldNotifications objectAtIndex:0] fireDate] description]);
        [app cancelAllLocalNotifications];
    }
}

- (void)toggleAlarm:(id)sender {
    BOOL state = [sender isOn];
    if (state) {
        [self setAlarmAtTime:[clockV time]];
    } else {
        [self clearAnyPendingAlarms];
    }
    return;
}

- (void)setAppAtOldAlarm {
    if ([self setTimeToAlarm]) {
        [alarmStatus setAlpha:1.0f];
        [alarmStatus setOn:YES animated:YES];
    }
}

- (BOOL)setTimeToAlarm {
    UIApplication* app = [UIApplication sharedApplication];
    NSArray* oldNotifications = [app scheduledLocalNotifications];
    if ([oldNotifications count] > 0) {
        NSDate *alarmDate = [[oldNotifications objectAtIndex:0] fireDate];
        NGTime *alarmTime = [[NGTime alloc] initWithTime:alarmDate];
        [clockV setNewTime:alarmTime];
        NSLog(@"setting clock time to alarm time %@", [alarmTime getTime]);
        return TRUE;
    }
    return FALSE;
}

@end
