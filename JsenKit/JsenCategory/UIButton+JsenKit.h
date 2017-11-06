//
//  UIButton+JsenKit.h
//  JsenKit
//
//  Created by WangXuesen on 2017/11/3.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JsenButtonImageViewPosition) {
    JsenButtonImageViewPositionUp = 0,
    JsenButtonImageViewPositionDown,
    JsenButtonImageViewPositionLeft,
    JsenButtonImageViewPositionRight
};

@interface UIButton (JsenKit)

/**
 标题添加下划线

 @param range 下划线范围
 @param underlineColor 下划线颜色
 */
- (void)addUnderlineToTitleWithRange:(NSRange)range underlineColor:(UIColor *)underlineColor;


/**
 用颜色生成图片并设置按钮

 @param color 图片颜色
 */
- (void)configBackgroundImageWithColor:(UIColor *)color;

/**
 更改图片和标题的相对位置

 @param position 图片相对标题的位置
 */
- (void)configImageAndTitleRelativePosition:(JsenButtonImageViewPosition)position;

@end
