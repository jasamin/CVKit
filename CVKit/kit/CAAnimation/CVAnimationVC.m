//
//  CVAnimationVC.m
//  CVKit
//
//  Created by Hanrun on 2018/9/17.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVAnimationVC.h"

@interface CVAnimationVC ()

@end

@implementation CVAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self move];
    //[self moveTest];
    //[self keyframeAnimationPositon];
    [self groupAnimation];
    //[self goup];
}

- (void)groupAnimation {
    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(200,200)];
    move.duration = 2;
    move.removedOnCompletion = NO;
    move.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *coner = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    coner.duration = 2;
    coner.toValue = @50;
    coner.removedOnCompletion = NO;
    coner.fillMode = kCAFillModeForwards;

    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2;
    group.fillMode = kCAFillModeForwards;
    group.beginTime = CACurrentMediaTime();
    group.removedOnCompletion = NO;
    group.animations = @[move,coner];
    [redView.layer addAnimation:group forKey:@"group"];
    
}


- (void)goup {
    
    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(0, 200)]];
//    animation.duration = 2;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.keyTimes = @[@0,@0.25,@0.5,@0.75,@1];
//    animation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)].CGPath;
    
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(200,200)];
    move.duration = 2;
    move.removedOnCompletion = NO;
    move.fillMode = kCAFillModeForwards;
    
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation2.toValue = @50;
    animation2.duration = 2;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.duration = 2;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = @[move,animation2];
    [redView.layer addAnimation:group forKey:@"group"];
    
}

- (void)keyframeAnimationPositon {
    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(0, 200)]];//多个值
//    animation.duration = 2;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    [redView.layer addAnimation:animation forKey:@"keyframe"];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(0, 200)]];
    animation.duration = 2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.keyTimes = @[@0,@0.25,@0.5,@0.75,@1];
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)].CGPath;
    [redView.layer addAnimation:animation forKey:@"keyframe"];
    
}

- (void)moveTest {
    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.removedOnCompletion = NO;
    move.duration = 2;
    move.fillMode = kCAFillModeForwards;
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    [redView.layer addAnimation:move forKey:nil];
}

- (void)move {
//    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:redView];
//    CABasicAnimation * animaiton = [CABasicAnimation animationWithKeyPath:@"position"];
//    animaiton.removedOnCompletion = NO;
//    animaiton.fillMode = kCAFillModeForwards;
//    animaiton.duration = 2;
//    animaiton.toValue = [NSValue valueWithCGPoint:CGPointMake(400, 400)];
//    [redView.layer addAnimation:animaiton forKey:nil];

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
