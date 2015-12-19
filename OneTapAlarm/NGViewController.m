//
//  NGViewController.m
//  OneTapAlarm
//
//  Created by Neetesh Gupta on 29/12/12.
//  Copyright (c) 2012 Neetesh Gupta. All rights reserved.
//

#import "NGViewController.h"

@interface NGViewController ()
@property (strong, nonatomic) IBOutlet NGClockView *clockV;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UISwitch *alarmStatus;
- (IBAction)toggleAlarm:(id)sender;

@end

@implementation NGViewController
int R = 120;
int clockCenterX = 160;
int clockCenterY = 240;
UIImageView *golaView;
UIImageView *clockView;
UILabel *timeLabel;
UIColor *textColor;
UIView *golaParent;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setAppAtOldAlarm];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    textColor = [UIColor colorWithRed:0.5255 green:0.255 blue:0.255 alpha:1.0];
    [self setBackground];
    [self addClock];
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

- (void)setBackground {

    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"background.png"]];
    return;
}

- (void)addClock {
    //_clockV = [NGClockView new];
    [_clockV setRadius:R delegate:self];
    //[self.view addSubview:_clockV];
    return;
}

- (void)handleTouchClock:(NGClockView *)clockView {
    [UIView animateWithDuration:1.0f
                          delay:0.5f
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         [_alarmStatus setAlpha:1.0f];
                             //clockView.transform = CGAffineTransformMakeRotation(theta);
                     }
                     completion:^(BOOL finished)
                    {
                        [_alarmStatus setOn:YES animated:YES];
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
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
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
        [self setAlarmAtTime:[_clockV time]];
    } else {
        [CRToastManager dismissNotification:YES];
        [self clearAnyPendingAlarms];
    }
    return;
}

- (void)setAppAtOldAlarm {
    if ([self setTimeToAlarm]) {
        [_alarmStatus setAlpha:1.0f];
        [_alarmStatus setOn:YES animated:YES];
    }
}

- (BOOL)setTimeToAlarm {
    UIApplication* app = [UIApplication sharedApplication];
    NSArray* oldNotifications = [app scheduledLocalNotifications];
    if ([oldNotifications count] > 0) {
        NSDate *alarmDate = [[oldNotifications objectAtIndex:0] fireDate];
        NGTime *alarmTime = [[NGTime alloc] initWithTime:alarmDate];
        [_clockV setNewTime:alarmTime];
        NSLog(@"setting clock time to alarm time %@", [alarmTime getTime]);
        return TRUE;
    }
    return FALSE;
}

@end
