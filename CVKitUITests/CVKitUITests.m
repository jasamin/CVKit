//
//  CVKitUITests.m
//  CVKitUITests
//
//  Created by Hanrun on 2018/8/1.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CVKitUITests : XCTestCase

@end

@implementation CVKitUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    

    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *element = [[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"CVGradeVC"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    
    XCUIElement *backButton = app.navigationBars[@"CVGradeVC"].buttons[@"Back"];
    [backButton tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [element tap];
    [backButton tap];


}



@end
