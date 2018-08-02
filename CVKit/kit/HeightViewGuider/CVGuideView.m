//
//  CVGuideView.m
//  CVKit
//
//  Created by Hanrun on 2018/8/1.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVGuideView.h"

#define fontSize 18

@interface CVGuideView ()
{
    
}
@property(strong,nonatomic)CAShapeLayer *masklayer;
@property(nonatomic)CGRect subViewFram;
@property(copy,nonatomic) NSString *message;
@property(strong, nonatomic) UIView *maskView;
@property(strong, nonatomic) UILabel *messagelab;

@end

@implementation CVGuideView

- (instancetype)initWithSubviewFram:(CGRect)subFram withMessgae:(NSString *)message
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self show];
        subFram = CGRectMake(subFram.origin.x - 3, subFram.origin.y - 3, subFram.size.width + 6, subFram.size.height + 6);
        self.subViewFram = subFram;
        self.message = message;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.maskView];
        [self.maskView.layer addSublayer:self.masklayer];
        [self addSubview:self.messagelab];
        
        [self showMaskViewHeightlight];
        //[self showCornerMaskLayer];
        
    }
    return self;
}

- (void)setTheMessageLabFram:(CGRect)fram {
    float bottom = self.subViewFram.size.height + self.subViewFram.origin.y;
    float bottomEdge = self.bounds.size.height - bottom;
    float messageHeight = [self heightForText:self.message width:self.bounds.size.width-50 size:fontSize]+50;
    if (bottomEdge > messageHeight) {
        self.messagelab.frame = CGRectMake(25, bottom+20, self.bounds.size.width-50, messageHeight-50);
    }else {
         self.messagelab.frame = CGRectMake(25, self.subViewFram.origin.y-messageHeight, self.bounds.size.width-50, messageHeight-50);
    }
    
    //textalign
    float left = self.subViewFram.origin.x;
    float right = left+self.subViewFram.size.width;
    if (left<self.bounds.size.width*0.25) {
        self.messagelab.textAlignment = NSTextAlignmentLeft;
    }
    if (right>self.bounds.size.width*0.75) {
        self.messagelab.textAlignment = NSTextAlignmentRight;
    }
}

- (CGFloat)heightForText:(NSString *)text width:(CGFloat)width size:(float)s {
    //设置计算文本时字体的大小,以什么标准来计算
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:s]};
    return [text boundingRectWithSize:CGSizeMake(width, 1000) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:attrbute context:nil].size.height;
}

- (void)showMaskViewHeightlight {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.subViewFram cornerRadius:5];
    UIBezierPath *thisPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [thisPath appendPath:path];
    
    self.masklayer.path = thisPath.CGPath;
    self.masklayer.fillRule = kCAFillRuleEvenOdd;
    self.layer.mask = self.masklayer;
   
}

- (void)showCornerMaskLayer {

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.subViewFram.size.width*0.5+self.subViewFram.origin.x, self.subViewFram.size.height*0.5+self.subViewFram.origin.y) radius:self.subViewFram.size.width*0.5+6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    UIBezierPath *thisPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [thisPath appendPath:path];
    
    self.masklayer.path = thisPath.CGPath;
    self.masklayer.fillRule = kCAFillRuleEvenOdd;
    self.layer.mask = self.masklayer;

}

- (CAShapeLayer *)masklayer {
    if (!_masklayer) {
        _masklayer = [[CAShapeLayer alloc]init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.7f;
    }
    return _masklayer;
}

- (UIView *)maskView
{
    if (!_maskView)
    {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _maskView;
}

- (UILabel *)messagelab {
    if (!_messagelab) {
        _messagelab = [UILabel new];
        _messagelab.numberOfLines = 0;
        _messagelab.textColor = [UIColor whiteColor];
        _messagelab.text = self.message;
        _messagelab.textAlignment = NSTextAlignmentCenter;
        _messagelab.font = [UIFont systemFontOfSize:fontSize];
        [self setTheMessageLabFram:CGRectZero];
    }
    return _messagelab;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [UIView animateWithDuration:.3f animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if ([self.delegate respondsToSelector:@selector(guideViewDidDismiss)]) {
            [self.delegate guideViewDidDismiss];
            return;
        }
        if (self.guideViewHasDismiss) {
            self.guideViewHasDismiss(@1);
        }
    }];
    
}

- (void)show
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    //self.alpha = 0;
    
    //[UIView animateWithDuration:.3f animations:^{
        
        //self.alpha = 1;
    //}];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
