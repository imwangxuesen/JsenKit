//
//  JsenAlertConfigManager.h
//  JsenKit
//
//  Created by WangXuesen on 2016/12/28.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JsenAlert;

@interface JsenAlertConfigManager : NSObject

/**
 if set this attribute, alert view will use this to set title's font. 
 
 default : [UIFont systemFontOfSize:16]
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 if set this attribute, alert view will use this to set title's color.
 
 default : [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 if set this attribute, alert view will use this to set detailMessage font.
 
 default : [UIFont systemFontOfSize:13]
 */
@property (nonatomic, strong) UIFont *detailMessageFont;

/**
 if set this attribute, alert view will use this to set detailMessage color.
 
 default : [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0]
 */
@property (nonatomic, strong) UIColor *detailMessageColor;

/**
 alert up to two buttons, 'it's same as UIAlertView style'
 
 if set this attribute, alert view will use this to set first button title when normal state.
 
 default : [UIFont systemFontOfSize:13]
 */
@property (nonatomic, strong) UIFont *firstButtonTitleNormalFont;

/**
 alert up to two buttons, 'it's same as UIAlertView style'
 
 if set this attribute, alert view will use this to set first button title color when normal state.
 
 default : [UIColor lightGrayColor]
 */
@property (nonatomic, strong) UIColor *firstButtonTitleNormalColor;

/**
 alert up to two buttons, 'it's same as UIAlertView style'
 
 if set this attribute, alert view will use this to set first button title color when normal state.
 
 default : [UIImage js_imageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, 100, 100)]
 
 js_imageWithColor: "UIImage+JsenKit.h" category will show more infomation

 */
@property (nonatomic, strong) UIImage *firstButtonBackgroundImage;

/**
 alert up to two buttons, 'it's same as UIAlertView style'
 
 if set this attribute, alert view will use this to set second button title when normal state.
 
 default : [UIFont systemFontOfSize:13]
 */
@property (nonatomic, strong) UIFont *secondButtonTitleNormalFont;

/**
 alert up to two buttons, 'it's same as UIAlertView style'
 
 if set this attribute, alert view will use this to set second button title color when normal state.
 
 default : [UIColor orangeColor]
 */
@property (nonatomic, strong) UIColor *secondButtonTitleNormalColor;

/**
 alert up to two buttons, 'it's same as UIAlertView style'
 
 if set this attribute, alert view will use this to set second button title color when normal state.
 
 default : [UIImage js_imageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, 100, 100)]
 
 js_imageWithColor: "UIImage+JsenKit.h" category will show more infomation
 
 */
@property (nonatomic, strong) UIImage *secondButtonBackgroundImage;

/**
 if you don't set button title. alert will use this default title to show.
 default : @"我知道了"
 TODO: will add more language.
 */
@property (nonatomic, copy) NSString *defualtButtonTitle;

/**
 alert view background color
 */
@property (nonatomic, strong) UIColor *alertViewBackgroundColor;

/**
 this attribute will mark one alert which showing on keyWindow.
 */
@property (nonatomic, strong) JsenAlert *currentAlert;

/**
 single case from 'JsenAlertConfigManager'
 
 @return single case
 */
+ (JsenAlertConfigManager *)shared;


@end
