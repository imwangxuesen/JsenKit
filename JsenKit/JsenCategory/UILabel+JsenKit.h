//
//  UILabel+JsenKit.h
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JsenKit)

/**
 改变行间距
 
 @param label 目标label
 @param space 行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 改变字间距
 
 @param label 目标label
 @param space 字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 改变字间距，行间距
 
 @param label 目标label
 @param lineSpace 行间距
 @param wordSpace 字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
@end
