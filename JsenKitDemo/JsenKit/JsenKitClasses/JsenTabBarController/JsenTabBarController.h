//
//  JsenTabBarController.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsenTabBar.h"

@protocol JsenTabBarControllerDelegate <NSObject>
@optional
/**
 if item is center one and attribute type is xxxBulgeType and was clicked, this method will be call.
 
 @param item JsenTabBarItem that was clicked
 */
- (void)jsenTabBarCenterItemClickedAction:(JsenTabBarItem *)item;

/**
 if item attribute type is not xxxBulgeType was clicked, this method will be call.
 
 @param item JsenTabBarItem that was clicked
 */
- (void)jsenTabBarUnCenterItemClickedAction:(JsenTabBarItem *)item;

@end


@interface JsenTabBarController : UITabBarController

/**
 is same as system viewControllers,it just changed it's name. 😄
 */
@property (nonatomic, strong) NSArray<UIViewController*> *customControllers;

@property (nonatomic, assign) CGFloat plusButtonWidth;

@property (nonatomic, assign) CGFloat plusButtonExceedTabBarHeight;

/**
 custom TabBar , it init when you call 'configWithControllers: tabBarItemAttributes:'
 if you wanna get more infomation for JsenTabBar ,you can read JsenTabBar.h code.
 */
@property (nonatomic, strong) JsenTabBar *customTabBar;

/**
 JsenTabBarControllerDelegate delegate
 */
@property (nonatomic, weak) id<JsenTabBarControllerDelegate> jsenDelegate;

/**
 config controllers and tabBar, you should call init first，and then call this method
 
 eg:
 JsenTabBarController *tab = [[JsenTabBarController alloc] init];
 [tab configWithControllers:@[vc1,vc2,vc3,vc4] tabBarItemAttributes:@[attribute,attribute2,attributePlus,attribute3,attribute4]];
 
 
 @param controllers UIViewController
 @param attributes JsenTabBarItemAttribute
 */
- (void)configWithControllers:(NSArray<UIViewController *> *)controllers tabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes;

@end
