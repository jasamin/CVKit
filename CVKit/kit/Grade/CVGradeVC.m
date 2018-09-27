//
//  CVGradeVC.m
//  CVKit
//
//  Created by Hanrun on 2018/9/26.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVGradeVC.h"
#import "CVGradeView.h"




@interface CVGradeVC ()
{
    CVGradeView *_topView;
    NSInteger i;
}
@end

@implementation CVGradeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 100;
    CVGradeView *topView = [[CVGradeView alloc]initWithFrame:CGRectMake(0, 64,KSCREEN_WIDTH, KSCREEN_WIDTH-100)];
    [self.view addSubview:topView];
    _topView = topView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self biu];
}

- (void)biu {
    NSInteger j = i;
    
    j -= arc4random()%100;
    if (j>=0) {
        i=j;
        [_topView setNumTo:i];
    }else {
        [self biu];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
