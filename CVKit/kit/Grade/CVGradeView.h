//
//  CVGradeView.h
//  CVKit
//
//  Created by Hanrun on 2018/9/26.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+YYAdd.h"
#import "CVWeakTarget.h"
#import "UIColor+YYAdd.h"
#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@protocol CVGradeViewDelegate <NSObject>
@optional
- (void)layerBackgloundColorUpdateFrom:(UIColor *)from toColor:(UIColor *)to duration:(float)duration;
@end

@interface CVGradeView : UIView
@property(nonatomic,strong) UILabel *gradeLab;
@property(nonatomic,weak) id delegate;
- (void)setNumTo:(NSInteger)to;
- (void)stopAnimation;
@end
