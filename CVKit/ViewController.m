//
//  ViewController.m
//  CVKit
//
//  Created by Hanrun on 2018/8/1.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "ViewController.h"
#import "CVGuideView.h"
#import "CVReaderVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnAction:(id)sender {
    //[self show:sender];//获取
    [self showReaderPage];
}

- (void)showReaderPage {
    CVReaderVC *vc = [[CVReaderVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)show:(id)sender {
    UIView *view = (UIView *)sender;
    CVGuideView *gui = [[CVGuideView alloc]initWithSubviewFram:view.frame withMessgae:@"点击屏幕移除当前指引涂层"];
    [gui setGuideViewHasDismiss:^(id objc) {
        NSLog(@"已经移除");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
