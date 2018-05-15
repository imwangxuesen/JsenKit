//
//  JsenRunTimeTool.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenRunTimeTool.h"
#import <objc/runtime.h>

@implementation JsenRunTimeTool

+ (void)js_printPrivateMethodAndAttributeWithClass:(Class)className {
    
    unsigned  int count = 0;
    Ivar *members = class_copyIvarList([className class], &count);
    
    for (int i = 0; i < count; i++)
    {
        Ivar var = members[i];
        const char *memberAddress = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"address = %s ; type = %s",memberAddress,memberType);
    }
}


+ (void)js_swizzleMethodWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector  {    // the method might not exist in the class, but in its superclass
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
