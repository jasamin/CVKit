//
//  CVPopAnimation.m
//  CVKit
//
//  Created by Hanrun on 2018/8/28.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVPopAnimation.h"

@implementation CVPopAnimation

//设置转场动画的时长
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 2.f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //from
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //to
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* toView = nil; UIView* fromView = nil;
    //UITransitionContextFromViewKey和UITransitionContextToViewKey定义在iOS8.0以后的SDK中，所以在iOS8.0以下SDK中将toViewController和fromViewController的view设置给toView和fromView
    //iOS8.0 之前和之后view的层次结构发生变化，所以iOS8.0以后UITransitionContextFromViewKey获得view并不是fromViewController的view
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    //将toView加到fromView的下面，非常重要！！！
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    fromView.frame = CGRectMake(0, 0, width, height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
         fromView.frame = CGRectMake(-width, 0, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}
@end

