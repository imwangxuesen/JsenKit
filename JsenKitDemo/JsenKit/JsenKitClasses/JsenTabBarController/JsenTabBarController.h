//
//  JsenTabBarController.h
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsenTabBarItemAttribute.h"

@interface JsenTabBarController : UITabBarController

@property (nonatomic, strong) NSArray<UIViewController*> *customControllers;

@property (nonatomic, strong) NSArray<JsenTabBarItemAttribute*> *tabBarItemAttributes;

@property (nonatomic, assign) CGFloat plusButtonWidth;

@property (nonatomic, assign) CGFloat plusButtonExceedTabBarHeight;

- (void)configWithControllers:(NSArray<UIViewController *> *)controllers tabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes;


@end
