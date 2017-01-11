//
//  UIColor+JsenKit.m
//  JsenKit
//
//  Created by WangXuesen on 2017/1/3.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "UIColor+JsenKit.h"

@implementation UIColor (JsenKit)
+ (UIColor*)js_ColorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}
@end
