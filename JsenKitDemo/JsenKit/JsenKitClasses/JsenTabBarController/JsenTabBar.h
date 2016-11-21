//
//  JsenTabBar.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsenTabBarItemAttribute.h"


@interface JsenTabBar : UITabBar


@property (nonatomic, strong) NSArray<JsenTabBarItemAttribute*> *tabBarItemAttributes;

@property (nonatomic, assign) CGFloat plusButtonWidth;

@property (nonatomic, assign) CGFloat plusButtonExceedTabBarHeight;


- (void)configWithTabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes;


@end
