//
//  NGViewController.h
//  OneTapAlarm
//
//  Created by Neetesh Gupta on 29/12/12.
//  Copyright (c) 2012 Neetesh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <math.h>
#import "NGClockView.h"
#import "CRToast.h"

@interface NGViewController : UIViewController

-(void) handleTouchClock:(NGClockView*)clockView;
-(void) didReceiveLocalNotification:(NSString *)notifText;
-(void) didTapOnLocalNotification:(NSString *)notifText;

@end
