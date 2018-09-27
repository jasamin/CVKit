//
//  CVWeakTarget.m
//  CVKit
//
//  Created by Hanrun on 2018/9/27.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVWeakTarget.h"

@implementation CVWeakTarget
- (instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}

//消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [self.target methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
        
    }
    
}

@end
