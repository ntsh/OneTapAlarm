//
//  NGClockView.m
//  OneTapAlarm
//
//  Created by NG on 10/11/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import "NGClockView.h"

@implementation NGClockView

- (id)initWithFrame:(CGRect)frame andRadius:(int)radius
{
    UIImageView *clockView;
    self = [super initWithFrame:frame];
    if (self) {
        CGRect imageRect = CGRectMake(0, 0, 2*radius, 2*radius);
        UIImage *imgClock = [UIImage imageNamed:@"Clock"];
        clockView = [[UIImageView alloc] initWithFrame:imageRect];
        [clockView setImage:imgClock];
        [clockView setBounds:imageRect];
        clockView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:clockView];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    NSLog(@"View: %f,%f",touchLocation.x, touchLocation.y);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
