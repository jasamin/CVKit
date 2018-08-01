//
//  CVGuideView.h
//  CVKit
//
//  Created by Hanrun on 2018/8/1.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CVGuideViewDelegate <NSObject>
@optional
- (void)guideViewDidDismiss;
@end

@interface CVGuideView : UIView
@property (weak,nonatomic) id<CVGuideViewDelegate>delegate;
@property (copy,nonatomic) void(^guideViewHasDismiss)(id objc);
- (instancetype)initWithSubviewFram:(CGRect)subFram withMessgae:(NSString *)message;
@end
