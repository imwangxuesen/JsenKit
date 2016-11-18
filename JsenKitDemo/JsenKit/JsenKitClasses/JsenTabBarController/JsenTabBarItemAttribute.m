//
//  JsenTabBarItemAttribute.m
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBarItemAttribute.h"

@implementation JsenTabBarItemAttribute

+ (instancetype)configItemAttributeWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage type:(JsenTabBarItemAttributeType)type {
    JsenTabBarItemAttribute * attribute = [[JsenTabBarItemAttribute alloc] initWithNormalImage:normalImage selectedImage:selectedImage type:type];
    return attribute;
}

- (instancetype)initWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage type:(JsenTabBarItemAttributeType)type {
    self = [super init];
    if (self) {
        _normalImage = normalImage;
        _selectedImage = selectedImage;
        _type = type;
    }
    return self;
}

@end
