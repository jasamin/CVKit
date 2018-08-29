//
//  CVPushAnimation.h
//  CVKit
//
//  Created by Hanrun on 2018/8/28.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CVPushAnimation : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithSubFrame:(CGRect)frame;
@end
