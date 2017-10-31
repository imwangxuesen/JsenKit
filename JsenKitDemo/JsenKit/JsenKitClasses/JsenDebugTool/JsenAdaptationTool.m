//
//  JsenAdaptationTool.m
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenAdaptationTool.h"

static CGFloat const kDesignWidth = 375.0f;

@implementation JsenAdaptationTool

+ (CGFloat)js_adaptationLength:(CGFloat)length {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat truthWidth = screenWidth > screenHeight ? screenHeight : screenWidth;
    return length/kDesignWidth*truthWidth;
}

+ (CGSize)js_adaptationSize:(CGSize)size {
    CGFloat w = [self js_adaptationLength:size.width];
    CGFloat h = [self js_adaptationLength:size.height];
    return CGSizeMake(w, h);
}

+ (CGFloat)js_adaptationTitleFont:(CGFloat)font {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat truthWidth = screenWidth > screenHeight ? screenHeight : screenWidth;
    return font/kDesignWidth*truthWidth;
}
@end
