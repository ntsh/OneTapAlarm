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
@synthesize timeLabel;
int R = 100;
UIImageView *imgView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CALayer *orbit1 = [CALayer layer];
    orbit1.bounds = CGRectMake(0, 0, 2*R, 2*R);
    orbit1.position = self.view.center;
    orbit1.cornerRadius = R;
    orbit1.borderColor = [UIColor redColor].CGColor;
    orbit1.borderWidth = 8;
    [self.view.layer addSublayer:orbit1];
    NSLog(@"Center at %f,%f",self.view.center.x,self.view.center.y);
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake( - 5 , - 5, - 5, -5)];
    imgView.image = [UIImage imageNamed:@"sun.png"];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.center = CGPointMake(160,150);
    [self.view addSubview: imgView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    [self handleTouch:touchLocation];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    [self handleTouch:touchLocation];
}

-(void) handleTouch:(CGPoint)touchLocation
{
    NSLog(@"touched at %f,%f",touchLocation.x,touchLocation.y);
    float touchx = touchLocation.x;
    float touchy = touchLocation.y;
    float theta = atan2(touchx - 160, 250 - touchy);
    float hour_hand = 6 / M_PI * theta ;
    if (hour_hand < 1)
    {
        hour_hand = hour_hand + 12;
    }
    int time_hour = (int) hour_hand;
    float time_min = 0.6 * ((hour_hand * 100) - (time_hour * 100));
    timeLabel.text = [NSString stringWithFormat:@"%d:%02d",time_hour,(int)time_min];
    
    int circumPointX = 160 + R * sin(theta);
    int circumPointY = 250 - R * cos(theta);
    imgView.center = CGPointMake(circumPointX, circumPointY);
}
@end
