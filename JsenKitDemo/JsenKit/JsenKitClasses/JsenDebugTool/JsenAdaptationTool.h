//
//  JsenAdaptationTool.h
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define JSAdaptationLength(length) [UFAdaptationManager uf_adaptationLength:length]
#define JSAdaptationSize(size) [UFAdaptationManager uf_adaptationSize:size]
#define JSAdaptationTitleFont(font) [UFAdaptationManager uf_adaptationTitleFont:font]

@interface JsenAdaptationTool : NSObject


/**
 适配长度

 @param length 375宽的设计图亮出来的length
 @return 各个屏幕对应的length
 */
+ (CGFloat)js_adaptationLength:(CGFloat)length;


/**
 适配size

 @param size 375宽的设计图亮出来的size
 @return 各个屏幕对应的size
 */
+ (CGSize)js_adaptationSize:(CGSize)size;


/**
 适配字体

 @param font 375宽的设计图亮出来的字体大小
 @return 各个屏幕对应的长度
 */
+ (CGFloat)js_adaptationTitleFont:(CGFloat)font;


@end
