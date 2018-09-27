//
//  CVSlider.m
//  Intelligence
//
//  Created by Hanrun on 2018/8/30.
//  Copyright © 2018年 hanrun. All rights reserved.
//

#import "CVSlider.h"

@implementation CVSlider


- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 10 ;
    rect.size.width = rect.size.width +20;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
