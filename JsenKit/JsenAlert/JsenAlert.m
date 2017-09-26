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
#define JsenAlertViewTitleLabel_H 56.0
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
    [self.effectView removeFromSuperview];
    self.effectView = nil;
    JsenAlertConfigManagerDefine.currentAlert = nil;
}

- (void)show {
    if (JsenAlertConfigManagerDefine.currentAlert) {
        [JsenAlertConfigManagerDefine.currentAlert hiden];
    }
    [JsenAlertKeyWindow addSubview:self.effectView];
    JsenAlertConfigManagerDefine.currentAlert = self;
}

- (BOOL)notEmpty:(NSString *)string {
    if (self.title != nil && ![self.title isEqualToString:@""] && self.title.length != 0) {
        return YES;
    }
    return NO;
}

- (void)actionButtonClicked:(UIButton *)btn {
    NSLog(@"123");
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

- (void)addButtons {
    CGFloat buttonY = self.alertViewBackgroundView.bounds.size.height - JsenAlertViewActionButton_H;
    CGFloat buttonW = (JsenAlertView_W - self.actionTitles.count+1)/(self.actionTitles.count==0 ? 1.0 : self.actionTitles.count);
    
    CALayer *lineLayer = [[CALayer alloc] init];
    lineLayer.frame = CGRectMake(0, buttonY-1, JsenAlertView_W, 1);
    lineLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.alertViewBackgroundView.layer addSublayer:lineLayer];
    
    if (self.actionTitles.count == 0) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonY, buttonW, JsenAlertViewActionButton_H)];
        button.userInteractionEnabled = YES;
        button.tag = 0;
        [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        NSString *title = [self notEmpty:self.actionTitles[0]] ? self.actionTitles[0] : JsenAlertConfigManagerDefine.defualtButtonTitle;
        [button setTitle:title forState:UIControlStateNormal];
        [self.alertViewBackgroundView addSubview:button];
    } else {
        for (NSInteger i=0 ; i<self.actionTitles.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((buttonW+1) * i, buttonY, buttonW, JsenAlertViewActionButton_H)];
            button.tag = i;
            [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *title = [self notEmpty:self.actionTitles[i]] ? self.actionTitles[0] : JsenAlertConfigManagerDefine.defualtButtonTitle;
            [button setTitle:title forState:UIControlStateNormal];
            
            if (i == 0) {
                [button setTitleColor:JsenAlertConfigManagerDefine.firstButtonTitleNormalColor forState:UIControlStateNormal];
                [button.titleLabel setFont:JsenAlertConfigManagerDefine.firstButtonTitleNormalFont];
                [button setBackgroundImage:JsenAlertConfigManagerDefine.firstButtonBackgroundImage forState:UIControlStateNormal];

            } else {
                
                CALayer *lineLayer = [[CALayer alloc] init];
                lineLayer.frame = CGRectMake((buttonW+1) * i - 1, buttonY + 5, 1, JsenAlertViewActionButton_H-10);
                lineLayer.backgroundColor = [UIColor grayColor].CGColor;
                [self.alertViewBackgroundView.layer addSublayer:lineLayer];
                
                [button setTitleColor:JsenAlertConfigManagerDefine.secondButtonTitleNormalColor forState:UIControlStateNormal];
                [button.titleLabel setFont:JsenAlertConfigManagerDefine.secondButtonTitleNormalFont];
                [button setBackgroundImage:JsenAlertConfigManagerDefine.secondButtonBackgroundImage forState:UIControlStateNormal];

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
        _titleLabel.frame = CGRectMake(0, 0, JsenAlertView_W, JsenAlertViewTitleLabel_H);
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
        _detailMessageLabel.frame = CGRectMake(0, y, JsenAlertView_W, height);
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
