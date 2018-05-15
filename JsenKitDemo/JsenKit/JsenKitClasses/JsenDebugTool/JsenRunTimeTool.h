//
//  JsenRunTimeTool.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsenRunTimeTool : NSObject

/**
 log
 打印某一个类中的所有方法和属性

 @param className 类名
 */
+ (void)js_printPrivateMethodAndAttributeWithClass:(Class)className;


/**
 swizzle two method
 交换两个方法

 @param class target class / 目标类
 @param originalSelector 原方法选择器
 @param swizzledSelector 新方法选择器
 */
+ (void)js_swizzleMethodWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
