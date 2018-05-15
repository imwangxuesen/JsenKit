//
//  JsenInputAlertView.m
//  gaea
//
//  Created by WangXuesen on 2018/5/14.
//  Copyright © 2018年 ucredit. All rights reserved.
//

#import "JsenInputAlertView.h"
#import "RJTextField.h"
#import <UIImage+JsenKit.h>

@interface JsenInputAlertView()

@property(nonatomic,strong) RJTextField *passwordTextField;
@property(nonatomic,strong) UIButton *cancelButton;
@property(nonatomic,strong) UIButton *confirmButton;
@property(nonatomic,copy) NSString *contentTitle;
@property(nonatomic,strong) UIWindow *currentWindow;


@end

@implementation JsenInputAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setupViewLayout];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
//    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = 4.f;
    self.layer.shadowOffset = CGSizeMake(2,2);

    [self addSubview:self.passwordTextField];
    [self addSubview:self.cancelButton];
    [self addSubview:self.confirmButton];
}

- (void)setupViewLayout {
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@50);
        make.centerY.equalTo(self.mas_centerY).offset(-10);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@25);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelButton.mas_right);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.cancelButton.mas_height);
        make.centerY.equalTo(self.cancelButton.mas_centerY);
    }];
    
}

- (void)showWithContentTitle:(NSString *)contentTitle animated:(BOOL)animated {
    
    _currentWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _currentWindow.windowLevel = 999;
    _currentWindow.rootViewController = [[UIViewController alloc] init];
    [_currentWindow makeKeyAndVisible];
    
    self.contentTitle = contentTitle;
    // 保存当前弹出的视图
    CGFloat halfScreenWidth = [[UIScreen mainScreen] bounds].size.width * 0.5;
    CGFloat halfScreenHeight = [[UIScreen mainScreen] bounds].size.height * 0.5;
    // 屏幕中心
    CGPoint screenCenter = CGPointMake(halfScreenWidth, halfScreenHeight);
    self.center = screenCenter;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    if (animated) {
        // 第一步：将view宽高缩至无限小（点）
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                CGFLOAT_MIN, CGFLOAT_MIN);
        [UIView animateWithDuration:0.3
                         animations:^{
                             // 第二步： 以动画的形式将view慢慢放大至原始大小的1.2倍
                             self.transform =
                             CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2
                                              animations:^{
                                                  // 第三步： 以动画的形式将view恢复至原始大小
                                                  self.transform = CGAffineTransformIdentity;
                                              }];
                         }];
    }
}

- (void)closeAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             // 第一步： 以动画的形式将view慢慢放大至原始大小的1.2倍
                             self.transform =
                             CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  // 第二步： 以动画的形式将view缩小至原来的1/1000分之1倍
                                                  self.transform = CGAffineTransformScale(
                                                                                                  CGAffineTransformIdentity, 0.001, 0.001);
                                              }
                                              completion:^(BOOL finished) {
                                                  // 第三步： 移除
                                                  [self removeFromSuperview];
                                              }];
                         }];
    } else {
        [self removeFromSuperview];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self closeAnimated:YES];
}

- (void)confirmAction:(UIButton *)btn {
    if ([NSObject isValueEmpty:self.passwordTextField.textField.text]) {
        GA_Error_Show(@"输入不能为空");
        return;
    }
    
    [self closeAnimated:YES];
    if (self.confirmBlock) {
        self.confirmBlock(self.passwordTextField.textField.text);
    }
    
}

#pragma mark - setter
- (void)setContentTitle:(NSString *)contentTitle {
    _contentTitle = contentTitle;
    self.passwordTextField.textField.placeholder = contentTitle;
    self.passwordTextField.placeholder = contentTitle;
}

#pragma mark - getter

- (RJTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[RJTextField alloc] initWithFrame:CGRectMake(0, 0, AdaptationLength(100), AdaptationLength(52))];
        _passwordTextField.textField.keyboardType = UIKeyboardTypeEmailAddress;
        _passwordTextField.textField.secureTextEntry = YES;
        _passwordTextField.showExpressButton = YES;
    }
    return _passwordTextField;
}


- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[UIImage js_imageWithColor:self.backgroundColor rect:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[UIImage js_imageWithColor:[[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5] rect:CGRectMake(0, 0, 1, 1)] forState:UIControlStateHighlighted];
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor mainOrangeColor] forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[UIImage js_imageWithColor:self.backgroundColor rect:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[UIImage js_imageWithColor:[[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5] rect:CGRectMake(0, 0, 1, 1)] forState:UIControlStateHighlighted];
        [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
