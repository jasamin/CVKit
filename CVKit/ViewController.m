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
#import "CVNextViewController.h"
#import "CVPushAnimation.h"
#import "CVPopAnimation.h"



@interface ViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
{
    CGRect rect;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
//
-(id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[CVPushAnimation alloc]initWithSubFrame:rect];
    }
    return nil;
}

- (IBAction)btnAction:(id)sender {
    //[self show:sender];//获取
    //[self showReaderPage];
     UIView *view = (UIView *)sender;
    rect = view.frame;
    CVNextViewController *vc = [[CVNextViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)zhuanchangdonghua {
    
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
