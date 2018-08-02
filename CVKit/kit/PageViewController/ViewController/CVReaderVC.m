//
//  CVReaderVC.m
//  CVKit
//
//  Created by Hanrun on 2018/8/2.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVReaderVC.h"

@interface CVReaderVC ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property(nonatomic,strong) UIPageViewController *pageVC;
@end

@implementation CVReaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makePageVC];
}

- (void)makePageVC {
    if (!_pageVC) {
        _pageVC = [[UIPageViewController alloc]init];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
    }
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    //添加一页
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor greenColor];
    [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor blueColor];
    return vc;
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
