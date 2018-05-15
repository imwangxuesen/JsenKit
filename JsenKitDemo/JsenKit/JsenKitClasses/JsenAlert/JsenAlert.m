//
//  JsenAlert.m
//  JsenKit
//
//  Created by WangXuesen on 2016/12/28.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenAlert.h"
#import <UIKit/UIKit.h>
#import "UIImage+JsenKit.h"

#define JsenAlertView_W  272.0
#define JsenAlertViewTitleLabel_H 46.0
#define JsenAlertViewDetailMessageLabel_H_WithTitleLabel 51.0
#define JsenAlertViewDetailMessageLabel_H_WithoutTitleLabel 61.0
#define JsenAlertViewActionButton_H 45.0

#define JsenAlertKeyWindow [[[UIApplication sharedApplication] delegate] window]
#define JsenAlertConfigManagerDefine [JsenAlertConfigManager shared]

@interface JsenAlert()

@property (nonatomic, strong) UIView *effectView;
@property (nonatomic, strong) UIView *alertViewBackgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailMessageLabel;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailMessage;
@property (nonatomic, strong) NSArray *actionTitles;
@property (nonatomic, strong) JsenAlertAction action;

@property (nonatomic, assign) BOOL hadTitle;
@property (nonatomic, assign) BOOL hadDetailMessage;

@property (nonatomic, strong) UIWindow *currentWindow;

@end

@implementation JsenAlert


+ (JsenAlert *)alertWithActionTitles:(NSArray *)actionTitles
                        title:(NSString *)title
                detailMessage:(NSString *)detailMessage
                       action:(JsenAlertAction)action {
    
    JsenAlert *alert = [[JsenAlert alloc] initWithActionTitles:actionTitles title:title detailMessage:detailMessage action:action];
    [alert show];
    return alert;
}

+ (JsenAlert *)alertWithActionTitles:(NSArray *)actionTitles
                               title:(NSString *)title
                       detailMessage:(NSString *)detailMessage
                              action:(JsenAlertAction)action
                           animation:(JsenAlertAnimationStyle)animationStyle {
    JsenAlert *alert = [[JsenAlert alloc] initWithActionTitles:actionTitles title:title detailMessage:detailMessage action:action];
    [alert show:animationStyle];
    return alert;
}


#pragma mark - private method 


- (instancetype)initWithActionTitles:(NSArray *)actionTitles
                               title:(NSString *)title
                       detailMessage:(NSString *)detailMessage
                              action:(JsenAlertAction)action
{
    self = [super init];
    if (self) {
        self.actionTitles = actionTitles;
        self.title = title;
        self.detailMessage = detailMessage;
        self.action = action;
        [self addAlertViewBackgroundView];
        [self addTitleAndDetailLabel];
        [self addButtons];
    }
    return self;
}

- (void)hiden {
    [self hiden:JsenAlertAnimationStyleNone];
}

- (void)hiden:(JsenAlertAnimationStyle)animationStyle {
    [self closeAnimated:animationStyle];
}

- (void)clearCurrentObjects {
    [self.effectView removeFromSuperview];
    self.effectView = nil;
    JsenAlertConfigManagerDefine.currentAlert = nil;
}

- (void)show {
    [self show:JsenAlertAnimationStyleNone];
}

- (void)show:(JsenAlertAnimationStyle)animationStyle {
    CGFloat afterTime = 0.0;
//    if (JsenAlertConfigManagerDefine.currentAlert) {
//        [JsenAlertConfigManagerDefine.currentAlert hiden:animationStyle];
//        afterTime = 0.52;
//    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JsenAlertConfigManagerDefine.currentAlert = self;
        [self showAnimated:animationStyle];
    });
    
    

}

- (BOOL)notEmpty:(NSString *)string {
    if (self.title != nil && ![self.title isEqualToString:@""] && self.title.length != 0) {
        return YES;
    }
    return NO;
}

- (void)actionButtonClicked:(UIButton *)btn {
    if (self.action) {
        self.action(btn.tag);
    }
    [self hiden];
}

- (void)addAlertViewBackgroundView {
    [self.effectView addSubview:self.alertViewBackgroundView];
}

- (void)addTitleAndDetailLabel {
    CGFloat height = 0.0;
    if (self.hadTitle && self.hadDetailMessage) {
        height = JsenAlertViewActionButton_H + JsenAlertViewTitleLabel_H +JsenAlertViewDetailMessageLabel_H_WithTitleLabel;
        [self.alertViewBackgroundView addSubview:self.titleLabel];
        [self.alertViewBackgroundView addSubview:self.detailMessageLabel];
        
    } else if (self.hadTitle && !self.hadDetailMessage) {
        height = JsenAlertViewActionButton_H + JsenAlertViewTitleLabel_H;
        [self.alertViewBackgroundView addSubview:self.titleLabel];
        
    } else if (!self.hadTitle && self.hadDetailMessage) {
        height = JsenAlertViewActionButton_H + JsenAlertViewDetailMessageLabel_H_WithoutTitleLabel;
        [self.alertViewBackgroundView addSubview:self.detailMessageLabel];
        
    } else {
        height = JsenAlertViewActionButton_H + JsenAlertViewTitleLabel_H;
        [self.alertViewBackgroundView addSubview:self.titleLabel];
    }
}

#pragma mark - animation

- (void)showAnimated:(JsenAlertAnimationStyle)animationStyle {
    
    _currentWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _currentWindow.windowLevel = 999;
    _currentWindow.rootViewController = [[UIViewController alloc] init];
    [_currentWindow makeKeyAndVisible];
    
    // 保存当前弹出的视图
    CGFloat halfScreenWidth = [[UIScreen mainScreen] bounds].size.width * 0.5;
    CGFloat halfScreenHeight = [[UIScreen mainScreen] bounds].size.height * 0.5;
    // 屏幕中心
    CGPoint screenCenter = CGPointMake(halfScreenWidth, halfScreenHeight - 20);
    self.alertViewBackgroundView.center = screenCenter;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.effectView];
    
    if (animationStyle == JsenAlertAnimationStylePop) {
        // 第一步：将view宽高缩至无限小（点）
        self.alertViewBackgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                CGFLOAT_MIN, CGFLOAT_MIN);
        [UIView animateWithDuration:0.3
                         animations:^{
                             // 第二步： 以动画的形式将view慢慢放大至原始大小的1.2倍
                             self.alertViewBackgroundView.transform =
                             CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2
                                              animations:^{
                                                  // 第三步： 以动画的形式将view恢复至原始大小
                                                  self.alertViewBackgroundView.transform = CGAffineTransformIdentity;
                                              }];
                         }];
    }
}

- (void)closeAnimated:(JsenAlertAnimationStyle)animationStyle {
    if (animationStyle == JsenAlertAnimationStylePop) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             // 第一步： 以动画的形式将view慢慢放大至原始大小的1.2倍
                             self.alertViewBackgroundView.transform =
                             CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  // 第二步： 以动画的形式将view缩小至原来的1/1000分之1倍
                                                  self.alertViewBackgroundView.transform = CGAffineTransformScale(
                                                                                          CGAffineTransformIdentity, 0.001, 0.001);
                                              }
                                              completion:^(BOOL finished) {
                                                  // 第三步： 移除
                                                  [self clearCurrentObjects];
                                              }];
                         }];
    } else {
        [self clearCurrentObjects];
    }
}

- (void)addButtons {
    CGFloat buttonY = self.alertViewBackgroundView.bounds.size.height - JsenAlertViewActionButton_H;
    CGFloat buttonW = (JsenAlertView_W - self.actionTitles.count+1)/(self.actionTitles.count==0 ? 1.0 : self.actionTitles.count);
    
    CALayer *lineLayer = [[CALayer alloc] init];
    lineLayer.frame = CGRectMake(0, buttonY-1, JsenAlertView_W, 1);
    lineLayer.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor;
    [self.alertViewBackgroundView.layer addSublayer:lineLayer];
    
    if (self.actionTitles.count == 0) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonY, buttonW, JsenAlertViewActionButton_H)];
        button.userInteractionEnabled = YES;
        button.tag = 0;
        [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        NSString *title = [self notEmpty:self.actionTitles[0]] ? self.actionTitles[0] : JsenAlertConfigManagerDefine.defualtButtonTitle;
        [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundImage:JsenAlertConfigManagerDefine.buttonBackgroundImageForHighlight forState:UIControlStateHighlighted];

        [self.alertViewBackgroundView addSubview:button];
    } else {
        for (NSInteger i=0 ; i<self.actionTitles.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((buttonW+1) * i, buttonY, buttonW, JsenAlertViewActionButton_H)];
            button.tag = i;
            [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *title = [self notEmpty:self.actionTitles[i]] ? self.actionTitles[i] : JsenAlertConfigManagerDefine.defualtButtonTitle;
            [button setTitle:title forState:UIControlStateNormal];
            
            if (i == 0) {
                [button setTitleColor:JsenAlertConfigManagerDefine.firstButtonTitleNormalColor forState:UIControlStateNormal];
                [button.titleLabel setFont:JsenAlertConfigManagerDefine.firstButtonTitleNormalFont];
                [button setBackgroundImage:JsenAlertConfigManagerDefine.firstButtonBackgroundImage forState:UIControlStateNormal];
                [button setBackgroundImage:JsenAlertConfigManagerDefine.buttonBackgroundImageForHighlight forState:UIControlStateHighlighted];

            } else {
                
                CALayer *lineLayer = [[CALayer alloc] init];
                lineLayer.frame = CGRectMake((buttonW+1) * i - 1, buttonY + 5, 1, JsenAlertViewActionButton_H-10);
                lineLayer.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor;
                [self.alertViewBackgroundView.layer addSublayer:lineLayer];
                
                [button setTitleColor:JsenAlertConfigManagerDefine.secondButtonTitleNormalColor forState:UIControlStateNormal];
                [button.titleLabel setFont:JsenAlertConfigManagerDefine.secondButtonTitleNormalFont];
                [button setBackgroundImage:JsenAlertConfigManagerDefine.secondButtonBackgroundImage forState:UIControlStateNormal];
                [button setBackgroundImage:JsenAlertConfigManagerDefine.buttonBackgroundImageForHighlight forState:UIControlStateHighlighted];


            }
            
            [self.alertViewBackgroundView addSubview:button];
            
        }
    }
}


#pragma mark - getter
- (UIView *)effectView {
    if (!_effectView) {
        _effectView = [[UIView alloc] init];
        _effectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _effectView.frame = CGRectMake(0, 0, width, height);
        _effectView.userInteractionEnabled = YES;
    }
    return _effectView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = JsenAlertConfigManagerDefine.titleFont;
        _titleLabel.textColor = JsenAlertConfigManagerDefine.titleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = self.title;
        _titleLabel.frame = CGRectMake(0, 10, JsenAlertView_W, JsenAlertViewTitleLabel_H);
    }
    return _titleLabel;
}

- (UILabel *)detailMessageLabel {
    if (!_detailMessageLabel) {
        _detailMessageLabel = [[UILabel alloc] init];
        _detailMessageLabel.font = JsenAlertConfigManagerDefine.detailMessageFont;
        _detailMessageLabel.textColor = JsenAlertConfigManagerDefine.detailMessageColor;
        _detailMessageLabel.textAlignment = NSTextAlignmentCenter;
        _detailMessageLabel.text = self.detailMessage;
        _detailMessageLabel.numberOfLines = 0;
        CGFloat height = self.hadTitle ? JsenAlertViewDetailMessageLabel_H_WithTitleLabel : JsenAlertViewDetailMessageLabel_H_WithoutTitleLabel;
        CGFloat y = self.hadTitle ? JsenAlertViewTitleLabel_H : 0.0;
        _detailMessageLabel.frame = CGRectMake(5, y, JsenAlertView_W-10, height);
        _detailMessageLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _detailMessageLabel;
}

- (UIView *)alertViewBackgroundView {
    if (!_alertViewBackgroundView) {
        _alertViewBackgroundView = [[UIView alloc] init];
        _alertViewBackgroundView.backgroundColor = [UIColor redColor];
        CGFloat height = [self alertViewHeight];
        CGFloat width = JsenAlertView_W;
        _alertViewBackgroundView.bounds = CGRectMake(0, 0, width, height);
        _alertViewBackgroundView.center = JsenAlertKeyWindow.center;
        _alertViewBackgroundView.layer.masksToBounds = YES;
        _alertViewBackgroundView.layer.cornerRadius = 8;
        _alertViewBackgroundView.backgroundColor = [JsenAlertConfigManager shared].alertViewBackgroundColor;
        _alertViewBackgroundView.userInteractionEnabled = YES;
        
    }
    return _alertViewBackgroundView;
}

- (CGFloat)alertViewHeight {
    CGFloat height = 0.0;
    if (self.hadTitle && self.hadDetailMessage) {
        height = JsenAlertViewActionButton_H + JsenAlertViewTitleLabel_H +JsenAlertViewDetailMessageLabel_H_WithTitleLabel;
        
    } else if (self.hadTitle && !self.hadDetailMessage) {
        height = JsenAlertViewActionButton_H + JsenAlertViewTitleLabel_H;
        
    } else if (!self.hadTitle && self.hadDetailMessage) {
        height = JsenAlertViewActionButton_H + JsenAlertViewDetailMessageLabel_H_WithoutTitleLabel;
        
    } else {
        height = JsenAlertViewActionButton_H + JsenAlertViewTitleLabel_H;
    }
    return height;
}

- (BOOL)hadTitle {
    return [self notEmpty:self.title];
}

- (BOOL)hadDetailMessage {
    return [self notEmpty:self.detailMessage];
}

@end
