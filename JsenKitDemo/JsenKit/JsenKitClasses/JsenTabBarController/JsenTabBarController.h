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

@property (nonatomic, strong) NSArray<UIViewController*> *controllers;

@property (nonatomic, strong) NSArray<JsenTabBarItemAttribute*> *tabBarAttributes;



@end
