//
//  UINavigationController+JsenKit.m
//  UFang
//
//  Created by WangXuesen on 2017/9/29.
//  Copyright © 2017年 Xuesen Wang. All rights reserved.
//

#import "UINavigationController+JsenKit.h"
#import <objc/runtime.h>

static NSString *const jsDelegate = @"jsDelegate";
@implementation UINavigationController (JsenKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(navigationBar:shouldPopItem:);
        SEL swizzledSelector = @selector(js_navigationBar:shouldPopItem:);

        SEL originalSelector2 = @selector(viewDidLoad);
        SEL swizzledSelector2 = @selector(js_viewDidLoad);
        
        [UINavigationController swizzClass:class originalSelector:originalSelector swizzledSelector:swizzledSelector];
        [UINavigationController swizzClass:class originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];

    });
}

+ (void)swizzClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)js_viewDidLoad {
    [self js_viewDidLoad];
    
    objc_setAssociatedObject(self, [jsDelegate UTF8String], self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    NSLog(@"%@",self.interactivePopGestureRecognizer.delegate);
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (BOOL)js_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    UIViewController *vc = self.topViewController;
    
    if (item != vc.navigationItem) {
        return YES;
    }
    
    if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
        if ([(id<UINavigationControllerShouldPop>)vc navigationControllerShouldPop:self]) {
            return [self js_navigationBar:navigationBar shouldPopItem:item];
        }else {
            return NO;
        }
    }else {
        return [self js_navigationBar:navigationBar shouldPopItem:item];
    }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        UIViewController *vc = [self topViewController];
        if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
            if (![(id<UINavigationControllerShouldPop>)vc navigationControllerShouldStartInteractivePopGestureRecognizer:self]) {
                return NO;
            }
        }
        
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [jsDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [jsDelegate UTF8String]);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [jsDelegate UTF8String]);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return YES;
}




@end
