//
//  CVWeakTarget.h
//  CVKit
//
//  Created by Hanrun on 2018/9/27.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CVWeakTarget : NSProxy
@property (weak,nonatomic,readonly)id target;
+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;
@end
