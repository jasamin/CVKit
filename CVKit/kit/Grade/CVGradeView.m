//
//  CVGradeView.m
//  CVKit
//
//  Created by Hanrun on 2018/9/26.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVGradeView.h"
#import <objc/runtime.h>
@interface CVGradeView()<CAAnimationDelegate>
{
    CGRect viewFrame;
    NSTimer *timer;
    NSInteger nowCount;
    NSInteger toCount;
    UILabel *_tLb;
    UIColor *nowColor;
    CALayer *fanshapedLayer;
}
@end

@implementation CVGradeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        viewFrame = frame;
        nowCount = 100;
        nowColor = [UIColor colorWithHexString:@"a2e79b"];
        float hugeRadius = 75;//75/375.0*KSCREEN_WIDTH;//(KSCREEN_WIDTH-150)*.5;
        float bigRadius = 58;//58/375.0*KSCREEN_WIDTH;//(KSCREEN_WIDTH-200)*.5;
        float smallRadius = 40;//40/375.0*KSCREEN_WIDTH;//(KSCREEN_WIDTH-250)*.5;
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [image setImage:[UIImage imageNamed:@"main_bg_top.png"]];
        [self addSubview:image];
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *gradeT = [[UILabel alloc]init];
        gradeT.text = @"90";
        gradeT.textColor = [UIColor whiteColor];
        gradeT.font = [UIFont systemFontOfSize:32];
        gradeT.frame = CGRectMake(0, 0, frame.size.width, 80);
        gradeT.textAlignment = NSTextAlignmentCenter;
        [self addSubview:gradeT];
        _gradeLab = gradeT;
        [gradeT sizeToFit];
        //gradeTLab.centerX = frame.size.width*0.5;
        //gradeTLab.centerY = frame.size.height*0.4;
        
        
        UILabel *gradeLab = [[UILabel alloc]init];
        gradeLab.text = @"分";
        gradeLab.textColor = [UIColor whiteColor];
        gradeLab.font = [UIFont systemFontOfSize:15];
        gradeLab.frame = CGRectMake(KSCREEN_WIDTH*0.5+gradeT.frame.size.width*0.5, 100, 15, 30);
        gradeLab.textAlignment = NSTextAlignmentCenter;
        gradeLab.centerY = viewFrame.size.height*0.5;
        [self addSubview:gradeLab];
        _tLb=gradeLab;
        
        
        
        
        CGRect rectFrame = self.bounds;
        CGPoint center = CGPointMake(viewFrame.size.width*0.5, viewFrame.size.height*0.5);
        gradeT.center = center;
        
        //超大
        CAShapeLayer *layerHuge = [CAShapeLayer layer];
        layerHuge.frame = rectFrame;
        layerHuge.fillColor = [UIColor clearColor].CGColor;
        layerHuge.strokeColor = [UIColor whiteColor].CGColor;
        layerHuge.lineWidth = 1.5;
        layerHuge.opacity = 0.2;
        layerHuge.shadowColor = [UIColor blackColor].CGColor;
        layerHuge.shadowOffset = CGSizeMake(0, 2);
        layerHuge.shadowOpacity = 0.55;
        
        
        UIBezierPath *circleHuge = [UIBezierPath bezierPathWithArcCenter:center radius:hugeRadius startAngle:-M_PI_2 endAngle:M_PI_2*4 clockwise:YES];
        layerHuge.path = circleHuge.CGPath;
        [self.layer addSublayer:layerHuge];
        
        //大
        CAShapeLayer *layerbig = [CAShapeLayer layer];
        layerbig.frame = rectFrame;
        layerbig.fillColor = [UIColor clearColor].CGColor;
        layerbig.strokeColor = [UIColor whiteColor].CGColor;
        layerbig.lineWidth = 1.5;
        layerbig.opacity = 0.6;
        layerbig.shadowColor = [UIColor blackColor].CGColor;
        layerbig.shadowOffset = CGSizeMake(0, 2);
        layerbig.shadowOpacity = 0.55;
        
        
        UIBezierPath *circleBig = [UIBezierPath bezierPathWithArcCenter:center radius:bigRadius startAngle:-M_PI_2 endAngle:M_PI_2*4 clockwise:YES];
        layerbig.path = circleBig.CGPath;
        [self.layer addSublayer:layerbig];

        CAShapeLayer *layerSmall = [CAShapeLayer layer];
        layerSmall.frame = rectFrame;
        layerSmall.fillColor = [UIColor clearColor].CGColor;
        layerSmall.strokeColor = [UIColor whiteColor].CGColor;
        layerSmall.opacity = 0.8;
        layerSmall.lineWidth = 4;

        UIBezierPath *circleSmall = [UIBezierPath bezierPathWithArcCenter:center radius:smallRadius startAngle:-M_PI_2 endAngle:M_PI_2*4 clockwise:YES];
        layerSmall.path = circleSmall.CGPath;
        [self.layer addSublayer:layerSmall];

        
//        // 线的路径
//        UIBezierPath *hlinePath = [UIBezierPath bezierPath];
//        [hlinePath moveToPoint:CGPointMake(center.x-smallRadius, center.y)];
//        [hlinePath addLineToPoint:CGPointMake(center.x+smallRadius, center.y)];
//        CAShapeLayer *hlineLayer = [CAShapeLayer layer];
//        hlineLayer.lineWidth = 1;
//        hlineLayer.strokeColor = [UIColor whiteColor].CGColor;
//        hlineLayer.path = hlinePath.CGPath;
//        //hlineLayer.fillColor = nil; // 默认为blackColor
//        [self.layer addSublayer:hlineLayer];
//
//        // 线的路径
//        UIBezierPath *vlinePath = [UIBezierPath bezierPath];
//        [vlinePath moveToPoint:CGPointMake(center.x, center.y-smallRadius)];
//        [vlinePath addLineToPoint:CGPointMake(center.x, center.y+smallRadius)];
//        CAShapeLayer *vlineLayer = [CAShapeLayer layer];
//        vlineLayer.lineWidth = 1;
//        vlineLayer.strokeColor = [UIColor whiteColor].CGColor;
//        vlineLayer.path = vlinePath.CGPath;
//        //vlineLayer.fillColor = nil; // 默认为blackColor
//        [self.layer addSublayer:vlineLayer];

        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor clearColor].CGColor; //圆环底色
        layer.frame = rectFrame;
        
        CAShapeLayer *fanshaped = [CAShapeLayer layer];
        fanshaped.frame = rectFrame;
        fanshaped.backgroundColor = [UIColor clearColor].CGColor;
        fanshaped.fillColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
        fanshaped.opacity = 0.75;
        //fanshaped.lineWidth = bigRadius*.5;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:hugeRadius startAngle:0 endAngle:M_PI/2 clockwise:YES];
        [path addLineToPoint:center];
        fanshaped.path = path.CGPath;
        
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = rectFrame;
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor];
        gradientLayer.startPoint = CGPointMake(0.6, 0.8);
        gradientLayer.endPoint = CGPointMake(0.7, 0.55);
        gradientLayer.locations = @[@0,@1];
        [layer addSublayer:gradientLayer];
        [layer setMask:fanshaped];
        [self.layer addSublayer:layer];
        

        CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        pulse.duration = 0.85;
        pulse.repeatCount = 100000000;
        pulse.autoreverses = NO;
        pulse.removedOnCompletion = NO;
        pulse.fromValue = [NSNumber numberWithFloat:0];
        pulse.toValue = [NSNumber numberWithFloat:M_PI*2];
        //[fanshaped addAnimation:pulse forKey:@"fanshaped"];
        [layer addAnimation:pulse forKey:@"fanshaped"];
        fanshapedLayer = layer;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

}

- (void)setLabText:(NSInteger)grade {
    _gradeLab.text = [NSString stringWithFormat:@"%ld",grade];
    [_gradeLab sizeToFit];
    _gradeLab.centerX = viewFrame.size.width*0.5;
    _gradeLab.centerY = viewFrame.size.height*0.5;
    _tLb.centerY = _gradeLab.centerY;
    _tLb.left = _gradeLab.right;
    
//    self.backgroundColor = [UIColor clearColor];
//    if (grade<50) {
//        CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//        anim1.duration = 5;
//        anim1.fromValue =  (__bridge id _Nullable)([UIColor greenColor].CGColor);
//        anim1.toValue =  (__bridge id _Nullable)([UIColor redColor].CGColor);
//        //填充效果：动画结束后，动画将保持最后的表现状态
//        anim1.fillMode = kCAFillModeForwards;
//        anim1.removedOnCompletion = NO;
//        anim1.beginTime = 0.0f;
//        [self.layer addAnimation:anim1 forKey:@"backgroundColor"];
//    }else if (grade<75){
//        self.backgroundColor = [UIColor orangeColor];
//    }else {
//        self.backgroundColor = [UIColor greenColor];
//    }

}

- (void)setNumTo:(NSInteger)to {
    toCount = to;
    
    self.backgroundColor = [UIColor clearColor];
    
    UIColor *temColor = nowColor;
//    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    anim1.duration = (nowCount - toCount)*0.05;
//    anim1.fromValue =  (__bridge id _Nullable)(temColor.CGColor);
    if (to<10) {
        nowColor = [UIColor colorWithHexString:@"fb0006"];
    }else if (to<20) {
        nowColor = [UIColor colorWithHexString:@"fb2206"];
    }else if (to<30) {
        nowColor = [UIColor colorWithHexString:@"fc5b07"];
    }else if (to<40) {
        nowColor = [UIColor colorWithHexString:@"fd9307"];
    }else if (to<50) {
        nowColor = [UIColor colorWithHexString:@"ffcc00"];
    }else if (to<60) {
        nowColor = [UIColor colorWithHexString:@"ffff09"];
    }else if (to<70) {
        nowColor = [UIColor colorWithHexString:@"caff08"];
    }else if (to<80) {
        nowColor = [UIColor colorWithHexString:@"96ff06"];
    }else if (to<90){
       nowColor = [UIColor colorWithHexString:@"65ff05"];
    }else {
        nowColor = [UIColor colorWithHexString:@"a2e79b"];
    }
//    anim1.toValue =  (__bridge id _Nullable)(nowColor.CGColor);
//    //填充效果：动画结束后，动画将保持最后的表现状态
//    anim1.fillMode = kCAFillModeForwards;
//    anim1.removedOnCompletion = NO;
//    anim1.beginTime = 0.0f;
//    [self.layer addAnimation:anim1 forKey:@"backgroundColor"];
    
    if ([self.delegate respondsToSelector:@selector(layerBackgloundColorUpdateFrom:toColor:duration:)]) {
        [self.delegate layerBackgloundColorUpdateFrom:temColor toColor:nowColor duration:(nowCount - toCount)*0.05];
    }
    
    if (timer) {
        [timer invalidate];
    }

    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:[CVWeakTarget proxyWithTarget:self] selector:@selector(subNumTo:) userInfo:nil repeats:YES];

}

- (void)subNumTo:(NSInteger)to {
    if (toCount<nowCount) {
        nowCount-=1;
    }else {
        [timer invalidate];
    }
    [self setLabText:nowCount];
}

- (UIColor*)getColorByPercent:(NSInteger)percent {
    //var 百分之一 = (单色值范围) / 50;  单颜色的变化范围只在50%之内
    float one = (255+255) / 100;
    float r=0;
    float g=0;
    float b=0;
    if ( percent < 50 ) {
        // 比例小于50的时候红色是越来越多的,直到红色为255时(红+绿)变为黄色.
        r = one * percent;
        g=255;
        
    }
    if ( percent >= 50 ) {
        // 比例大于50的时候绿色是越来越少的,直到0 变为纯红
        g =  255 - ( (percent - 50 ) * one) ;
        r = 255;
        
    }
    r = (int)r;
    g = (int)g;
    b = (int)b;
    //console.log("#"+r.toString(16,2)+g.toString(16,2)+b.toString(16,2));    //return "#"+r.toString(16,2)+g.toString(16,2)+b.toString(16,2);    //console.log("rgb("+r+","+g+","+b+")" );
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    
}


- (void)dealloc {
    NSLog(@"dealloc");
    if (timer) {
        [timer invalidate];
    }
    [fanshapedLayer removeAnimationForKey:@"fanshaped"];
    [fanshapedLayer removeFromSuperlayer];
    fanshapedLayer = nil;
}

- (void)stopAnimation {
    [fanshapedLayer removeAnimationForKey:@"fanshaped"];
    [fanshapedLayer removeFromSuperlayer];
    fanshapedLayer = nil;
//    CABasicAnimation *op = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    op.duration = 0.5;
//    op.fromValue = @1;
//    op.toValue = @0;
//    op.delegate = self;
//    op.removedOnCompletion = NO;
//    [fanshapedLayer addAnimation:op forKey:@"opToRemove"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

@end
