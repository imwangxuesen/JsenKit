//
//  UINavigationControllerShouldPop.h
//  JsenKit
//
//  Created by WangXuesen on 2017/9/29.
//  Copyright © 2017年 Xuesen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol UINavigationControllerShouldPop <NSObject>

- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController;

- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController;

@end
