//
//  NGTimeTests.m
//  OneTapAlarm
//
//  Created by NG on 06/05/17.
//  Copyright © 2017 Neetesh Gupta. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NGTime.h"

@interface NGTimeTests : XCTestCase

@end

@implementation NGTimeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //NSString *formattedString = [WCTimeIntervalFormatter getApproximateTime:10];
    //XCTAssert([formattedString isEqualToString:@"10 seconds"]);
    NSDate *timeZero = [NSDate dateWithTimeIntervalSince1970:0];
    NGTime *time = [[NGTime alloc] initWithTime:timeZero];
    XCTAssert([[time getTime] isEqualToString:@"1:00"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
