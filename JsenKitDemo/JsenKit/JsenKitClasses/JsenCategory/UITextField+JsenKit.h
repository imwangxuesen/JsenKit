//
//  UITextField+JsenKit.h
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JsenKit)

/**
 设置textfield的占位字符串

 @param placeholder 占位字符串
 @param color 颜色
 @param fontSize 字体大小
 */
- (void)js_configInputTextField:(NSString *)placeholder color:(UIColor *)color fontSize:(int)fontSize;
@end
