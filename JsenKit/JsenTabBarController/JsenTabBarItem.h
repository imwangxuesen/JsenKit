//
//  JsenTabBarItem.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/21.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JsenTabBarItemAttribute;


@interface JsenTabBarItem : UIButton

/**
 JsenTabBarItemAttribute, this property record all infomation for item
 */
@property (nonatomic, strong) JsenTabBarItemAttribute *jsenAttribute;


/**
 item shwo animation,
 this method will automatically determine own type and execute the corresponding animation
 */
- (void)animation;

/**
 change button titleLabel and iamgeView relative position to titleLabel in the picture below. like system UITabBarItem.
 */
- (void)configImageAndTitleEdgeInsets;

/**
 init based on the attribute

 @param attribute JsenTabBarItemAttribute
 @return JsenTabBarItem object
 */
- (instancetype)initWithAttribute:(JsenTabBarItemAttribute *)attribute;

@end
