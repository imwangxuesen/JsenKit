//
//  JsenTabBarController.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBarController.h"
#import "JsenTabBarItem.h"

@interface JsenTabBarController ()<JsenTabBarDelegate>

@end

@implementation JsenTabBarController {
    NSArray *_attributes;
}

- (void)configWithControllers:(NSArray<UIViewController *> *)controllers tabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes {
    _attributes = attributes;
    self.customControllers = controllers;
    [self setViewControllers:self.customControllers animated:YES];
    self.customTabBar = [[JsenTabBar alloc] initWithFrame:self.tabBar.frame];
    [self.customTabBar configWithTabBarItemAttributes:_attributes];
    self.customTabBar.tabBarDelegate = self;
    if (_attributes.count != 0) {
        [self.customTabBar configSelectedItemWithIndex:0];
        self.selectedIndex = 0;
    }
    [self setValue:self.customTabBar forKey:@"tabBar"];
}

#pragma mark - JsenTabBarDelegate
- (void)jsenTabBarCenterItemClicked:(JsenTabBarItem *)item {
    if (self.jsenDelegate && [self.jsenDelegate respondsToSelector:@selector(jsenTabBarCenterItemClickedAction:)]) {
        [self.jsenDelegate jsenTabBarCenterItemClickedAction:item];
    }
}

- (void)jsenTabBarUnCenterItemClicked:(JsenTabBarItem *)item {
    self.selectedIndex = item.tag;
    if (self.jsenDelegate && [self.jsenDelegate respondsToSelector:@selector(jsenTabBarUnCenterItemClickedAction:)]) {
        [self.jsenDelegate jsenTabBarUnCenterItemClickedAction:item];
    }
}

#pragma mark - getter
- (void)setPlusButtonWidth:(CGFloat)plusButtonWidth {
    _plusButtonWidth = plusButtonWidth;
    self.customTabBar.plusButtonWidth = plusButtonWidth;
}

- (void)setPlusButtonExceedTabBarHeight:(CGFloat)plusButtonExceedTabBarHeight {
    _plusButtonExceedTabBarHeight = plusButtonExceedTabBarHeight;
    self.customTabBar.plusButtonExceedTabBarHeight = plusButtonExceedTabBarHeight;
}


@end
