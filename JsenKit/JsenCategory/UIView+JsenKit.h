//
//  UIView+JsenKit.h
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JsenKit)

/**
 移除所有的子view
 */
- (void)js_removeAllSubviews;

/**
 设置圆角
 
 @param radius 半径
 */
- (void)js_filletWithRadius:(CGFloat)radius;
@end
