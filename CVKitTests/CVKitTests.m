//
//  CVKitTests.m
//  CVKitTests
//
//  Created by Hanrun on 2018/8/1.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CVKitTests : XCTestCase

@end

@implementation CVKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    XCTAssert(YES,@"pass");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        for (NSInteger index = 0; index < 10000; index ++) {
            NSLog(@"%ld",index);
        }
    }];
}

@end
