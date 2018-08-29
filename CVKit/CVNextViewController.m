//
//  CVNextViewController.m
//  CVKit
//
//  Created by Hanrun on 2018/8/28.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVNextViewController.h"
#import "CVPopAnimation.h"

@interface CVNextViewController ()<UINavigationControllerDelegate>

@end

@implementation CVNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.delegate = self;
}

-(id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [[CVPopAnimation alloc]init];
    }
    return nil;
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
