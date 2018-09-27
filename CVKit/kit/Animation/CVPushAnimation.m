//
//  CVPushAnimation.m
//  CVKit
//
//  Created by Hanrun on 2018/8/28.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVPushAnimation.h"
#import <UIView+YYAdd.h>

@interface CVPushAnimation ()
{
    CGRect surperViewFrame;
}
@end

@implementation CVPushAnimation

- (instancetype)initWithSubFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        surperViewFrame = frame;
    }
    return self;
}

//转场动画时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

// 定义转场动画的行为
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //to
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* toView = nil; UIView* fromView = nil;

    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    //这个非常重要，将toView加入到containerView中
    [[transitionContext containerView] addSubview:toView];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    toView.frame = surperViewFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}

//设置转场进度, 取值范围 [0..1] - (void)updateInteractiveTransition:(CGFloat)percentComplete;
//完成转场，呈现to - (void)finishInteractiveTransition;
//取消转场，呈现from - (void)cancelInteractiveTransition;

@end
