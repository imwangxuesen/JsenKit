//
//  JsenAlertConfigManager.m
//  JsenKit
//
//  Created by WangXuesen on 2016/12/28.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenAlertConfigManager.h"
#import "UIColor+JsenKit.h"
#import "UIImage+JsenKit.h"


static JsenAlertConfigManager *manager = nil;
@implementation JsenAlertConfigManager

+ (JsenAlertConfigManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JsenAlertConfigManager alloc] init];
    });
    return manager;
}


#pragma mark - getter 

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:16];
    }
    return _titleFont;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}

- (UIFont *)detailMessageFont {
    if (_detailMessageFont) {
        _detailMessageFont = [UIFont systemFontOfSize:13];
    }
    return _detailMessageFont;
}

- (UIColor *)detailMessageColor {
    if (!_detailMessageColor) {
        _detailMessageColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    }
    return _detailMessageColor;
}

- (UIFont *)firstButtonTitleNormalFont {
    if (!_firstButtonTitleNormalFont) {
        _firstButtonTitleNormalFont = [UIFont systemFontOfSize:13];
    }
    return _firstButtonTitleNormalFont;
}

- (UIColor *)firstButtonTitleNormalColor {
    if (!_firstButtonTitleNormalColor) {
        _firstButtonTitleNormalColor = [UIColor lightGrayColor];
    }
    return _firstButtonTitleNormalColor;
}

- (UIImage *)firstButtonBackgroundImage {
    if (!_firstButtonBackgroundImage) {
        _firstButtonBackgroundImage = [UIImage js_imageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, 100, 100)];
    }
    return _firstButtonBackgroundImage;
}

- (UIFont *)secondButtonTitleNormalFont {
    if (!_secondButtonTitleNormalFont) {
        _secondButtonTitleNormalFont = [UIFont systemFontOfSize:13];
    }
    return _secondButtonTitleNormalFont;
}

- (UIColor *)secondButtonTitleNormalColor {
    if (!_secondButtonTitleNormalColor) {
        _secondButtonTitleNormalColor = [UIColor orangeColor];
    }
    return _secondButtonTitleNormalColor;
}

- (UIImage *)secondButtonBackgroundImage {
    if (!_secondButtonBackgroundImage) {
        _secondButtonBackgroundImage = [UIImage js_imageWithColor:[UIColor whiteColor] rect:CGRectMake(0, 0, 100, 100)];
    }
    return _secondButtonBackgroundImage;
}

- (NSString *)defualtButtonTitle {
    if (!_defualtButtonTitle) {
        _defualtButtonTitle = @"我知道了";
    }
    return _defualtButtonTitle;
}

- (UIColor *)alertViewBackgroundColor {
    if (!_alertViewBackgroundColor) {
        _alertViewBackgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    }
    return _alertViewBackgroundColor;
}

- (UIImage *)buttonBackgroundImageForHighlight {
    if (!_buttonBackgroundImageForHighlight) {
        _buttonBackgroundImageForHighlight = [UIImage js_imageWithColor:[UIColor js_ColorWithHex:0xf6f6f6 alpha:1.0] rect:CGRectMake(0, 0, 100, 100)];
    }
    return _buttonBackgroundImageForHighlight;
}

@end
