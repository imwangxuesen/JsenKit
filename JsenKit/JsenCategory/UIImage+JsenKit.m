
//
//  UIImage+JsenKit.m
//  JsenKit
//
//  Created by WangXuesen on 2017/1/6.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "UIImage+JsenKit.h"

@implementation UIImage (JsenKit)
+ (UIImage*)js_imageWithColor:(UIColor*)color rect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
