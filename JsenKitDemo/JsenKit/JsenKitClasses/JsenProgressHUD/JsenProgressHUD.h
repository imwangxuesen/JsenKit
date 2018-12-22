//
//  JsenProgressHUD.h
//  JsenProjectEncapsulation
//
//  Created by WangXuesen on 15/12/17.
//  Copyright © 2015年 Jsen. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface JsenProgressHUD : UIView

/**
 set hud text font
 default : [UIFont boldSystemFontOfSize:14]
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 set hud text color
 default : hex color 0x353535
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 ActivityIndicatorView color
 default : hex color 0xb9dc2f
 */
@property (nonatomic, strong) UIColor *spinnerColor;

/**
 hud is UIToolbar which automatic adaptation text and activity indicatorview,
 this attribute will set hud's background color
 default : hex color 0xffffff
 */
@property (nonatomic, strong) UIColor *hudBackgroundColor;

/**
 if 'interaction' attribute is YES , we will insert one view(background) to between window and hud. this attribute will set it color
 
 default : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2]
 */
@property (nonatomic, strong) UIColor *hudWindowColor;

/**
 when use 'showSuccess:' or 'showSuccess: interaction:' function, will show a image to alert success.
 if you had set this attribute, it will use it .
 
 default : 'jsen_hud_success@2x/3x'
 */
@property (nonatomic, strong) UIImage *imageForSuccess;

/**
 when use 'showError:' or 'showError: interaction:' function, will show a image to alert error.
 if you had set this attribute, it will use it .
 
 default : 'jsen_hud_error@2x/3x'
 */
@property (nonatomic, strong) UIImage *imageForFail;

/**
 when hud showing , new one come , the new one will normal display.;
 
 if allowRepeat is NO , that disappear;
 
 default NO;
 */
@property (nonatomic, assign) BOOL allowRepeat;

/**
 hud show on superview's center if hudCenterOffset was null
 
 if that not null, hud will offset base on superview's center
 */
@property (nonatomic, assign) CGPoint hudCenterOffset;


+ (JsenProgressHUD *)shareDefault;

/**
 hiden HUD if showing
 */
+ (void)dismiss;

/**
 with text HUD on window

 @param text You want the user to see the text
 @param interaction Allow users to click on display，if no or nil . user can't click UI when HUD showing
 */
+ (void)showText:(NSString *)text interaction:(BOOL)interaction;

/**
 with text HUD on window
 
 interaction is NO

 @param text You want the user to see the text
 */
+ (void)showText:(NSString *)text;

/**
 with text HUD on super view

 interaction is NO

 @param text You want the user to see the text
 @param superView hud super view
 */
+ (void)showText:(NSString *)text superView:(id)superView;


/**
 show toast view without success or error status image
 */
+ (void)showToastWithoutStatus:(NSString *)text;

/**
 show success hud image on window

 interaction is NO
 
 @param text success text
 */
+ (void)showSuccess:(NSString *)text;

/**
 show success text with success image on super view
 
 interaction is NO
 
 @param text success text
 @param superView hud super view
 */
+ (void)showSuccess:(NSString *)text superView:(id)superView;

/**
 with text and success image HUD on window
 
 @param text text
 @param interaction Allow users to click on display，if no or nil . user can't click UI when HUD showing
 */
+ (void)showSuccess:(NSString *)text interaction:(BOOL)interaction;

/**
 show error hud image on window

 interaction is NO
 
 @param text error text
 */
+ (void)showError:(NSString *)text;

/**
 show error text with error image on super view

 interaction is NO
 
 @param text error text
 @param superView hud super view
 */
+ (void)showError:(NSString *)text superView:(id)superView;

/**
 with text and error image HUD on window
 
 interaction is NO
 
 @param text text
 @param interaction Allow users to click on display，if no or nil . user can't click UI when HUD showing
 */
+ (void)showError:(NSString *)text interaction:(BOOL)interaction;



@end
