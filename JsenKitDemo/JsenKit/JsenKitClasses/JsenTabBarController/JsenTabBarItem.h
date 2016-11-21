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

@property (nonatomic, strong) JsenTabBarItemAttribute *jsenAttribute;

- (void)configImageAndTitleEdgeInsets;

- (instancetype)initWithAttribute:(JsenTabBarItemAttribute *)attribute;

@end
