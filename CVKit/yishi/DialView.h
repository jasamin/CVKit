//
//  DialView.h
//  Intelligence
//
//  Created by Hanrun on 2018/9/3.
//  Copyright © 2018年 hanrun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DialViewType) {
    GasView = 1,
    Probe
};

@interface DialView : UIView
- (instancetype)initWithFrame:(CGRect)frame dataType:(DialViewType)type;
- (void)setDataTitle:(NSString *)titleString typeLab:(NSString *)typeString;
@end
