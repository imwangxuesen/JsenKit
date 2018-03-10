//
//  UIColor+JsenKit.h
//  JsenKit
//
//  Created by WangXuesen on 2017/1/3.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JsenKit)

/**
 Hex Color

 @param hexValue  eg：0xFFFFFF
 @param alphaValue alpha
 @return UIColor
 */
+ (UIColor*)js_ColorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

/**
 Hex Color

 @param hexString 16进制字符串
 @param alpha 透明度
 @return UIColor
 */
+ (instancetype)js_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
