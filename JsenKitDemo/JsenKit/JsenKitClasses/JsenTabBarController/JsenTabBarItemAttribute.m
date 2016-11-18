//
//  JsenTabBarItemAttribute.m
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBarItemAttribute.h"

@implementation JsenTabBarItemAttribute

+ (instancetype)configItemAttributeWithType:(JsenTabBarItemAttributeType)type {
    JsenTabBarItemAttribute * attribute = [[JsenTabBarItemAttribute alloc] initWithType:type];
    return attribute;
}

- (instancetype)initWithType:(JsenTabBarItemAttributeType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

@end
