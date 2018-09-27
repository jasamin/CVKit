//
//  DialView.m
//  Intelligence
//
//  Created by Hanrun on 2018/9/3.
//  Copyright © 2018年 hanrun. All rights reserved.
//

#import "DialView.h"
#import "UIView+YYAdd.h"
@interface DialView ()
{
    CGRect rectF;
    UILabel *label,*typeLab;
}
@end

@implementation DialView

- (void)setDataTitle:(NSString *)titleString typeLab:(NSString *)typeString{
    label.text = titleString;
    typeLab.text = typeString;
}

- (instancetype)initWithFrame:(CGRect)frame dataType:(DialViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        CGRect temperatureViewFrame;
        temperatureViewFrame.size.height = frame.size.width;
        temperatureViewFrame.size.width = frame.size.width;
        temperatureViewFrame.origin.x = 0;//(frame.size.width*0.45)/2;
        temperatureViewFrame.origin.y = 0;
        
        rectF = temperatureViewFrame;
        
        
        UILabel *dataLab = [[UILabel alloc]init];
        dataLab.text = @"999.99 LEL";
        dataLab.textColor = [UIColor whiteColor];
        dataLab.font = [UIFont systemFontOfSize:46];
        dataLab.frame = CGRectMake(0, 0, frame.size.width, 80);
        dataLab.textAlignment = NSTextAlignmentCenter;
        dataLab.centerX = frame.size.width*0.5;
        dataLab.centerY = frame.size.height*0.5;
        [self addSubview:dataLab];
        label = dataLab;
        
        UILabel *unitLab = [[UILabel alloc]init];
        unitLab.textColor = [UIColor whiteColor];
        unitLab.font = [UIFont systemFontOfSize:40];
        unitLab.frame = CGRectMake(0, 0, frame.size.width, 40);
        unitLab.textAlignment = NSTextAlignmentCenter;
        unitLab.centerX = frame.size.width*0.5;
        unitLab.top = dataLab.bottom;
        [self addSubview:unitLab];
        typeLab = unitLab;
        
        NSString *imageStr = type == GasView ? @"fierImage":@"tantouwendu";
        NSString *title = type == GasView ? @"  燃气" : @"  探头";
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageStr] forState:0];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [btn setUserInteractionEnabled:NO];
        [btn setFrame:CGRectMake(0, 0, frame.size.width, 30)];
        btn.bottom = dataLab.top - 5;
        [self addSubview:btn];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    
    CAShapeLayer *trackLayer = [CAShapeLayer layer];


    //trackLayer.lineDashPhase
    trackLayer.lineDashPattern = @[@2,@16];

    trackLayer.frame = self.bounds;
    //trackLayer.backgroundColor = [UIColor orangeColor].CGColor;
    //清空填充色
    trackLayer.fillColor = [UIColor clearColor].CGColor;
    //设置画笔颜色 即圆环背景色
    trackLayer.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6].CGColor;
    trackLayer.lineWidth = 8;
    //设置画笔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width*0.5,self.bounds.size.width*0.5) radius:trackLayer.frame.size.width/2.0 - 10 startAngle:-M_PI_2 endAngle:M_PI*2 clockwise:YES];

    //path 决定layer将被渲染成何种形状
    trackLayer.path = path.CGPath;
    [self.layer addSublayer:trackLayer];
}


@end
