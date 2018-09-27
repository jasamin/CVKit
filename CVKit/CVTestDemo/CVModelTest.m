//
//  CVModelTest.m
//  CVKitTests
//
//  Created by Hanrun on 2018/9/19.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CVModel.h"
@interface CVModelTest : XCTestCase

@end

@implementation CVModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    for(int j = 0;j < 10000;j++){
        CVModel *model = [[CVModel alloc]init];
        int i = [model randomNum];
        NSLog(@"%d",i);
        XCTAssert(i<99,@"please check i");
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
