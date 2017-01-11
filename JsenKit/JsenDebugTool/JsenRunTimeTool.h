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
+ (void)printPrivateMethodAndAttributeWithClass:(Class)className;

@end
