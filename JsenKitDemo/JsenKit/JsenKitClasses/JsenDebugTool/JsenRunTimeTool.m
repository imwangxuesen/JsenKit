//
//  JsenRunTimeTool.m
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenRunTimeTool.h"
#import <objc/runtime.h>

@implementation JsenRunTimeTool

+ (void)printPrivateMethodAndAttributeWithClass:(Class)className {
    
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

@end
