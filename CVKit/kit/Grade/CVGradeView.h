//
//  CVGradeView.h
//  CVKit
//
//  Created by Hanrun on 2018/9/26.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+YYAdd.h"
#import "CVHeader.h"

@interface CVGradeView : UIView
@property(nonatomic,strong) UILabel *gradeLab;
- (void)setNumTo:(NSInteger)to;
@end
