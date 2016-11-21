//
//  JsenTabBarItemAttribute.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 TabBarItem 的样式

 - JsenTabBarItemAttributeCenterPlusType: 中间凸出加号样式
 - JsenTabBarItemAttributeCenterPlusUnBulgeType: 中间不凸出加号样式
 - JsenTabBarItemAttributeSystemType: 系统样式
 - JsenTabBarItemAttributeShakeAnimationType: 抖动动画样式
 - JsenTabBarItemAttributeZoomAnimationType: 缩放动画样式
 */
typedef NS_ENUM(NSInteger, JsenTabBarItemAttributeType) {
    
    JsenTabBarItemAttributeCenterPlusBulgeType = 0,
    JsenTabBarItemAttributeCenterPlusUnBulgeType,
    JsenTabBarItemAttributeSystemType,
    JsenTabBarItemAttributeShakeAnimationType,
    JsenTabBarItemAttributeZoomAnimationType
    
};

@interface JsenTabBarItemAttribute : NSObject

@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *selectedTitle;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, assign) JsenTabBarItemAttributeType type;
@property (nonatomic, strong) UIImage *normalBackgroundImage;
@property (nonatomic, strong) UIImage *selectedBackgroundImage;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIFont *normalTitleFont;
@property (nonatomic, strong) UIFont *selectedTitleFont;

+ (instancetype)configItemAttributeWithType:(JsenTabBarItemAttributeType)type;


@end
NS_ASSUME_NONNULL_END
