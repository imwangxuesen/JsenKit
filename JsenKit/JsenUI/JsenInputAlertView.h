//
//  JsenInputAlertView.h
//  gaea
//
//  Created by WangXuesen on 2018/5/14.
//  Copyright © 2018年 ucredit. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 确认返回block 定义

 @param content 输入内容
 */
typedef void (^JsenInputAlertViewConfirmBlock)(NSString *content);

@interface JsenInputAlertView : UIView

/**
 确认返回block
 */
@property(nonatomic,copy) JsenInputAlertViewConfirmBlock confirmBlock;

- (instancetype)init NS_UNAVAILABLE;

/**
 展示

 @param animated 是否动画
 */
- (void)showWithContentTitle:(NSString *)contentTitle animated:(BOOL)animated;
@end
