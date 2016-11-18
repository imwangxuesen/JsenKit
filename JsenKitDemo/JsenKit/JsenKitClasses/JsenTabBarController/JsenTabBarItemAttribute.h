//
//  JsenTabBarItemAttribute.h
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 TabBarItem 的样式

 - JsenTabBarItemAttributeCenterPlusType: 中间凸出加号样式
 - JsenTabBarItemAttributeSystemType: 系统样式
 - JsenTabBarItemAttributeShakeAnimationType: 抖动动画样式
 - JsenTabBarItemAttributeZoomAnimationType: 缩放动画样式
 */
typedef NS_ENUM(NSInteger, JsenTabBarItemAttributeType) {
    
    JsenTabBarItemAttributeCenterPlusType = 0,
    JsenTabBarItemAttributeSystemType,
    JsenTabBarItemAttributeShakeAnimationType,
    JsenTabBarItemAttributeZoomAnimationType
    
};

@interface JsenTabBarItemAttribute : NSObject

@property (nonatomic, strong, readonly) UIImage *normalImage;
@property (nonatomic, strong, readonly) UIImage *selectedImage;
@property (nonatomic, assign, readonly) JsenTabBarItemAttributeType type;


+ (instancetype)configItemAttributeWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage type:(JsenTabBarItemAttributeType)type;


@end
NS_ASSUME_NONNULL_END
