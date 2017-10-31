//
//  UIScrollView+UF.m
//  UFang
//
//  Created by WangXuesen on 2017/9/21.
//  Copyright © 2017年 Xuesen Wang. All rights reserved.
//

#import "UIScrollView+UF.h"
#import <objc/runtime.h>

@implementation UIScrollView (UF)

+ (void)load {
    [self uf_swizzleMethodWithClass:[UIScrollView class] originalSelector:@selector(initWithFrame:) swizzledSelector:@selector(initBFWithFrame:) ];
}

- (instancetype)initBFWithFrame:(CGRect)frame {
    self = [self initBFWithFrame:frame];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    return self;
    
}


+ (void)uf_swizzleMethodWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector  {    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
