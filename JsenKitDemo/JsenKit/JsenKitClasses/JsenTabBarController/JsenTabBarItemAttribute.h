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

 - JsenTabBarItemAttributeCenterPlusType: plus button type and a little highter than tabbar. in tabBar center
 
 - JsenTabBarItemAttributeCenterPlusUnBulgeType: plus button type. in tabBar center
 
 - JsenTabBarItemAttributeSystemType: is same as system UITabBarItem type
 
 - JsenTabBarItemAttributeShakeAnimationType: is same as system UITabBarItem type,but cloud show shake animation when click.
 
 - JsenTabBarItemAttributeZoomAnimationType: is same as system UITabBarItem type,but cloud show zoom animation when click.
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
@property (nonatomic, strong) UIImage *normalBackgroundImage;
@property (nonatomic, strong) UIImage *selectedBackgroundImage;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIFont *normalTitleFont;
@property (nonatomic, strong) UIFont *selectedTitleFont;
@property (nonatomic, assign) JsenTabBarItemAttributeType type;

+ (instancetype)configItemAttributeWithType:(JsenTabBarItemAttributeType)type;


@end
NS_ASSUME_NONNULL_END
