//
//  CVViewController.m
//  CVKit
//
//  Created by Hanrun on 2018/10/30.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVViewController.h"

#define kWindow [UIApplication sharedApplication].keyWindow

@interface CVViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIView *v2;
@property (weak, nonatomic) IBOutlet UIView *v3;
@property (weak, nonatomic) IBOutlet UIView *v4;
@property (weak, nonatomic) IBOutlet UIView *v5;
@property (weak, nonatomic) IBOutlet UIView *b1;
@property (weak, nonatomic) IBOutlet UIView *b2;
@property (strong,nonatomic) UIView *tempView;
@end

@implementation CVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(move:)];
    [_v1 addGestureRecognizer:pan];
}

- (void)move:(UIPanGestureRecognizer *)pan {
    
    //CGPoint translation = [pan translationInView:self.view];
    //_tempView.center = translation;
    
   
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"FlyElephant---视图拖动开始");
        
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [pan locationInView:self.view];
        if (location.y < 0 || location.y > self.view.bounds.size.height) {
            return;
            
        }
        CGPoint translation = [pan translationInView:self.view];
        //NSLog(@"当前视图在View的位置:%@----平移位置:%@",NSStringFromCGPoint(location),NSStringFromCGPoint(translation));
        pan.view.center = CGPointMake(pan.view.center.x + translation.x,pan.view.center.y + translation.y);
        [pan setTranslation:CGPointZero inView:self.view];
        
    } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        //NSLog(@"FlyElephant---视图拖动结束");
        
    }
    _tempView = pan.view;
    CGRect rect = [_tempView convertRect:_tempView.frame toView:_b1];
    if (CGRectIntersectsRect(_b1.frame, rect)) {
        NSLog(@"true %ld",_tempView.tag);
    }else{
        //NSLog(@"false");
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    /*
     * 改变浮窗 frame
     * 改变右下视图 frame
     * 判断浮窗center 是否在右下视图之上
     **/
    //CGPoint center_ball = [kWindow convertPoint:_tempView.center toView:self.b1];
    
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
