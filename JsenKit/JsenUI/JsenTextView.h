//
//  JsenTextView
//  JsenKit
//
//  Created by WangXuesen on 2017/9/25.
//  Copyright © 2017年 Xuesen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JsenTextView : UITextView

@property(nonatomic,copy) IBInspectable NSString *placeholder;
@property(nonatomic,strong) IBInspectable UIColor *placeholderColor;
/**
 最多字符个数
 */
@property(nonatomic,assign) IBInspectable NSInteger characterMaximum;

/**
 最少字符个数
 */
@property(nonatomic,assign) IBInspectable NSInteger characterMinimum;

- (instancetype)initWithPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor;

@end
