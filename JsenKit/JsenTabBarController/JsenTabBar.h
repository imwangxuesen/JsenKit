//
//  JsenTabBar.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JsenTabBarItemAttribute;
@class JsenTabBarItem;

@protocol JsenTabBarDelegate <NSObject>

/**
 if item is center one and attribute type is xxxBulgeType and was clicked, this method will be call.

 @param item JsenTabBarItem that was clicked
 */
- (void)jsenTabBarCenterItemClicked:(JsenTabBarItem *)item;

/**
 if item attribute type is not xxxBulgeType was clicked, this method will be call.

 @param item JsenTabBarItem that was clicked
 */
- (void)jsenTabBarUnCenterItemClicked:(JsenTabBarItem *)item;

@end

@interface JsenTabBar : UITabBar

/**
 current selected item , be careful, if you attributes has one's type is xxxBulgeType, then this type is not assigned.
 */
@property (nonatomic, strong) JsenTabBarItem *currentSelectedItem;

/**
 every custom item's attribute<JsenTabBarItemAttribute *>
 */
@property (nonatomic, strong) NSArray<JsenTabBarItemAttribute*> *tabBarItemAttributes;

/**
 custom plus button width, if nil or 0, we will use default value.
 
 be careful!
 
    * if you wanna change this value, you'd better use property is same as this in JsenTabBarController.
    * this property will only be used when building the plus button.
 */
@property (nonatomic, assign) CGFloat plusButtonWidth;

/**
 custom plus button mexceed tabBar Height,

 eg:
    if property not equl to nil or 0, plus button's y will be set to (-plusButtonExceedTabBarHeight) and height will add plusButtonExceedTabBarHeight.
 */
@property (nonatomic, assign) CGFloat plusButtonExceedTabBarHeight;

/**
 if you wanna get items clicked action, you must Set this property in the class／object where the message is received.
 */
@property (nonatomic, weak) id<JsenTabBarDelegate> tabBarDelegate;

/**
 config a selected item at initialization time
 
 be careful !
    
    * plus button can't be selected.
    * the existence of plusbutton does not need to be considered when calculating index
 
 @param index selected item index
        index start from zero.
 
 */
- (void)configSelectedItemWithIndex:(NSInteger)index;

/**
 transmit attributes to inited tabBar object to config custom items

 @param attributes objects of JsenTabBarItemAttribute class
 */
- (void)configWithTabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes;

@end
