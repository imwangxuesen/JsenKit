//
//  JsenProgressHUD.m
//  JsenProjectEncapsulation
//
//  Created by WangXuesen on 15/12/17.
//  Copyright © 2015年 Jsen. All rights reserved.
//

#define UIColorFromRGB(rgbValue)            [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define Jsen_HUD_FONT               [JsenProgressHUD shareDefault].textFont
#define Jsen_HUD_TEXT_COLOR        [JsenProgressHUD shareDefault].textColor

#define Jsen_HUD_SPINNER_COLOR        [JsenProgressHUD shareDefault].spinnerColor
#define Jsen_HUD_BACKGROUND_COLOR    [JsenProgressHUD shareDefault].hudBackgroundColor
#define Jsen_HUD_WINDOW_COLOR       [JsenProgressHUD shareDefault].hudWindowColor

#define Jsen_HUD_IMAGE_SUCCESS      [JsenProgressHUD shareDefault].imageForSuccess
#define Jsen_HUD_IMAGE_ERROR        [JsenProgressHUD shareDefault].imageForFail

#ifndef JsenLOCK
#define JsenLOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif

#ifndef JsenUNLOCK
#define JsenUNLOCK(lock) dispatch_semaphore_signal(lock);
#endif

static NSString *const JsenHUDQueueTextKey = @"text";
static NSString *const JsenHUDQueueImageKey = @"image";
static NSString *const JsenHUDQueueShowSpinnerKey = @"showSpinner";
static NSString *const JsenHUDQueueAutoHidenHUDKey = @"autoHidenHUD";
static NSString *const JsenHUDQueueInteractionKey = @"interaction";
static NSString *const JsenHUDQueueSuperViewKey = @"superView";

#import "JsenProgressHUD.h"
static JsenProgressHUD * progressHUD = nil;

@interface JsenProgressHUD()

@property (nonatomic, retain) UIWindow                *window;
@property (nonatomic, retain) UIView                  *background;
@property (nonatomic, retain) UIToolbar               *hud;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIImageView             *image;
@property (nonatomic, retain) UILabel                 *label;

/**
 @{
 text:NSString
 image:NString
 showSpinner:NSNumber
 autoHidenHUD:NSNumber
 interaction:NSNumber
 superView:id
 }
 */
@property (nonatomic, strong) NSDictionary *showingHUDInfo;

@property (nonatomic, assign) BOOL interaction;

/**
 if keyboard is displaying, this value equl keyboard height, else zero
 */
@property (nonatomic, assign) CGFloat keyboardHeight;

/**
 eg:
 @[
 @{
 text:NSString
 image:NString
 showSpinner:NSNumber
 autoHidenHUD:NSNumber
 interaction:NSNumber
 superView:id
 },
 ...
 ]
 
 if value is NO/nil , the key can't get anything, the key non-existent;
 
 */
@property (nonatomic, strong) NSMutableArray *hudQueue;

@end

@implementation JsenProgressHUD {
    dispatch_semaphore_t _lock;
}

+ (JsenProgressHUD *)shareDefault {
    static dispatch_once_t once = 0;
    
    dispatch_once(&once, ^{progressHUD = [[JsenProgressHUD alloc] init];});
    
    return progressHUD;
    
}

- (instancetype)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    _lock = dispatch_semaphore_create(1);
    self.allowRepeat = NO;
    self.background = nil;
    self.hud        = nil;
    self.spinner    = nil;
    self.image      = nil;
    self.label      = nil;
    self.alpha      = 0;
    [self registerNotifications];
    
    return self;
}


#pragma mark - Private Method
- (void)removeHUDFromQueue {
    if (_hudQueue && _hudQueue.count > 0) {
        JsenLOCK(_lock);
        [_hudQueue removeObjectAtIndex:0];
        JsenUNLOCK(_lock);
    }
}
- (void)showHUDFromQueue {
    if (_hudQueue && _hudQueue.count > 0) {
        JsenLOCK(_lock);
        NSDictionary *content = [_hudQueue objectAtIndex:0];
        JsenUNLOCK(_lock);
        
        NSString *text = content[JsenHUDQueueTextKey] ?: nil;
        UIImage *image = content[JsenHUDQueueImageKey] ?: nil;
        NSNumber *showSpinnerNumber = content[JsenHUDQueueShowSpinnerKey] ?: @(0);
        BOOL showSpinner = [showSpinnerNumber boolValue];
        NSNumber *autoHidenHUDNumber = content[JsenHUDQueueAutoHidenHUDKey] ?: @(0);
        BOOL autoHidenHUD = [autoHidenHUDNumber boolValue];
        NSNumber *interactionNumber = content[JsenHUDQueueInteractionKey]?:@(0);
        BOOL interaction = [interactionNumber boolValue];
        id superView = content[JsenHUDQueueSuperViewKey];
        
        [self configHUD:text image:image showSpinner:showSpinner autoHidenHUD:autoHidenHUD interaction:interaction superView:superView];
        
    }
}

- (NSDictionary *)creatInfoWithText:(NSString *)text image:(UIImage *)image showSpinner:(BOOL)showSpinner autoHidenHUD:(BOOL)autoHiden interaction:(BOOL)interaction superView:(id)superView {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (text) params[JsenHUDQueueTextKey] = text;
    if (image) params[JsenHUDQueueImageKey] = image;
    if (showSpinner) params[JsenHUDQueueShowSpinnerKey] = @(1);
    if (autoHiden) params[JsenHUDQueueAutoHidenHUDKey] = @(1);
    if (interaction) params[JsenHUDQueueInteractionKey] = @(1);
    if (superView) params[JsenHUDQueueSuperViewKey] = superView;
    return (NSDictionary *)params;
}

//配置hud 并展示
- (void)configHUD:(NSString *)text image:(UIImage *)image showSpinner:(BOOL)showSpinner autoHidenHUD:(BOOL)autoHiden interaction:(BOOL)interaction superView:(id)superView {
    
    
    NSDictionary *info = [self creatInfoWithText:text image:image showSpinner:showSpinner autoHidenHUD:autoHiden interaction:interaction superView:superView];
    
    if (showSpinner) { //菊花 ， 清空队列，优先展示
        [self clearQueue];
    } else { //不是菊花
        // 如果没有文字，也不是菊花
        if (!text) return;
        
        // 如果不允许重复，有正在展示的纯文字，并且将要展示的文字和它相同
        NSString *showingText = self.showingHUDInfo ? self.showingHUDInfo[JsenHUDQueueTextKey] : nil;
        if (!self.allowRepeat && showingText && [showingText isEqualToString:text]) {
            return;
        }
        
        // 0，如果当前有正在展示的,
        // 1，当前展示的是菊花
        // 2，将要展示的是菊花，
        // 3，不允许重复&&即将展示的文字和正在展示的不一样
        // 4，允许重复
        
        BOOL factor0 = self.showingHUDInfo != nil;
        BOOL factor1 = self.showingHUDInfo[JsenHUDQueueShowSpinnerKey] ?: NO;
        BOOL factor2 = showSpinner;
        BOOL factor3 = !self.allowRepeat && showingText && ![text isEqualToString:showingText];
        BOOL factor4 = self.allowRepeat;
        
        // 当前展示的是菊花，即将展示的是文字
        if (factor0 && factor1 && !factor2) {
            [self pushInfoToQueue:info];
            return;
        }
        
        // 当前展示的是文字，将展示的是文字，(允许文字重复 或者 不允许重复单和正在展示的文字不同）
        if (factor0 && !factor1 && !factor2 && (factor3 || factor4)) {
            [self pushInfoToQueue:info];
            return;
        }
    }
    
    self.interaction = interaction;
    
    [self createHUD:superView];
    
    self.label.text = text;
    self.label.hidden = (text == nil ? YES : NO);
    self.image.image = image;
    self.image.hidden = (image == nil ? YES : NO);
    
    if (showSpinner) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }
    
    [self configHUDSize:showSpinner];
    [self hudPosition:nil];
    
    [self showHUDWithInfo:info];
    
    if (autoHiden) {
        [NSThread detachNewThreadSelector:@selector(getToHide) toTarget:self withObject:nil];
    }
    
}

//配置hud的大小
- (void)configHUDSize:(BOOL)showSpinner
{
    CGRect labelRect = CGRectZero;
    CGFloat hudWidth = 100, hudHeight = 100;
    CGFloat space = 12.0;
    if (self.label.text != nil)
    {
        NSDictionary *attributes = @{NSFontAttributeName:self.label.font};
        NSInteger options        = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
        labelRect = [self.label.text boundingRectWithSize:CGSizeMake(200, 300) options:options attributes:attributes context:NULL];
        
        labelRect.origin.x = space;
        if(!self.image.hidden || showSpinner) {
            labelRect.origin.y = 66;
        } else {
            labelRect.origin.y = space;
            
        }
        
        hudWidth = CGRectGetWidth(labelRect) + space + space;
        hudHeight = CGRectGetMaxY(labelRect) + space;
        
        if (hudWidth < 100) {
            hudWidth = 100;
            labelRect.origin.x   = 0;
            labelRect.size.width = 100;
        }
        
    }
    
    self.hud.bounds   = CGRectMake(0, 0, hudWidth, hudHeight);
    if(!self.image.hidden || showSpinner) {
        CGFloat imagex    = hudWidth/2;
        CGFloat imagey    = (self.label.text == nil) ? hudHeight/2 : (24+space);
        self.image.center = self.spinner.center = CGPointMake(imagex, imagey);
    }
    
    self.label.frame  = labelRect;
}

//创建hud
- (void)createHUD:(id)superView {
    
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(window)]) {
        self.window = [delegate performSelector:@selector(window)];
    } else {
        self.window = [[UIApplication sharedApplication] keyWindow];
    }
    
    if (!self.hud) {
        self.hud = [[UIToolbar alloc] initWithFrame:CGRectZero];
        self.hud.translucent          = YES;
        self.hud.backgroundColor      = Jsen_HUD_BACKGROUND_COLOR;
        self.hud.layer.cornerRadius   = 10;
        self.hud.layer.masksToBounds  = YES;
    }
    
    if (!self.hud.superview) {
        if (!self.interaction) {
            self.background = [[UIView alloc] initWithFrame:self.window.frame];
            self.background.backgroundColor = Jsen_HUD_WINDOW_COLOR;
            
            if (superView) {
                [superView addSubview:self.background];
            } else {
                [self.window addSubview:self.background];
            }
            
            [self.background addSubview:self.hud];
        } else {
            
            if (superView) {
                [superView addSubview:self.hud];
            } else {
                [self.window addSubview:self.hud];
            }
        }
    }
    
    if (!self.spinner) {
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.spinner.color = Jsen_HUD_SPINNER_COLOR;
        self.spinner.hidesWhenStopped = YES;
    }
    
    if (!self.spinner.superview) {
        [self.hud addSubview:self.spinner];
    }
    
    if (!self.image) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        
    }
    
    if (!self.image.superview) {
        [self.hud addSubview:self.image];
    }
    
    if (!self.label) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.font                 = Jsen_HUD_FONT;
        self.label.textColor            = Jsen_HUD_TEXT_COLOR;
        self.label.backgroundColor      = [UIColor clearColor];
        self.label.textAlignment        = NSTextAlignmentCenter;
        self.label.baselineAdjustment   = UIBaselineAdjustmentAlignCenters;
        self.label.numberOfLines        = 0;
    }
    
    if (!self.label.superview) {
        [self.hud addSubview:self.label];
    }
    
    
}

//注册监听键盘动作
- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardDidShowNotification object:nil];
}

//监听键盘状态，做出对hud的位置调整
- (void)hudPosition:(NSNotification *)notification {
    
    NSTimeInterval duration = 0;
    
    if (notification != nil)
    {
        NSDictionary *info = [notification userInfo];
        CGRect keyboard = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        duration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        if ((notification.name == UIKeyboardWillShowNotification) || (notification.name == UIKeyboardDidShowNotification))
        {
            self.keyboardHeight = keyboard.size.height;
        } else {
            self.keyboardHeight = 0.0;
        }
    } else {
        self.keyboardHeight = 0.0;
    }
    
    CGRect  screen = [UIScreen mainScreen].bounds;
    CGPoint center = CGPointMake(CGRectGetWidth(screen)/2, (CGRectGetHeight(screen)-self.keyboardHeight)/2);
    
    if (self.hudCenterOffset.x != 0 || self.hudCenterOffset.y != 0) {
        center = CGPointMake(
                             self.hudCenterOffset.x + center.x,
                             self.hudCenterOffset.y + center.y
                             );
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.hud.center = center;
    } completion:nil];
    
    if (self.background != nil) self.background.frame = self.window.frame;
}

// 自动隐藏时的调用方法
- (void)getToHide {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSUInteger length = self.label.text.length;
        NSTimeInterval sleepTime = length * 0.03 + 1.1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sleepTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUD];
        });
    });
}

//销毁hud
- (void)hudDestroy {
    [self.label removeFromSuperview];
    self.label = nil;
    
    [self.image removeFromSuperview];
    self.image = nil;
    
    [self.spinner removeFromSuperview];
    self.spinner = nil;
    
    [self.hud removeFromSuperview];
    self.hud = nil;
    
    [self.background removeFromSuperview];
    self.background = nil;
}

- (void)showNext {
    if (self.hudQueue.count > 0
        ) {
        JsenLOCK(_lock)
        NSDictionary *info = self.hudQueue.firstObject;
        JsenUNLOCK(_lock)
        
        NSString *text = info[JsenHUDQueueTextKey];
        UIImage *image = info[JsenHUDQueueImageKey];
        BOOL showSpinner = info[JsenHUDQueueShowSpinnerKey] ? YES : NO;
        BOOL autoHiden = info[JsenHUDQueueAutoHidenHUDKey] ? YES : NO;
        BOOL interaction = info[JsenHUDQueueInteractionKey] ? YES : NO;
        id superView = info[JsenHUDQueueSuperViewKey];
        
        [self configHUD:text image:image showSpinner:showSpinner autoHidenHUD:autoHiden interaction:interaction superView:superView];
    }
}

#pragma mark - Queue
- (void)clearQueue {
    JsenLOCK(_lock)
    if (_hudQueue.count > 0) {
        [_hudQueue removeAllObjects];
    }
    JsenUNLOCK(_lock)
}

- (void)pushInfoToQueue:(NSDictionary *)info {
    JsenLOCK(_lock)
    [self.hudQueue addObject:info];
    NSLog(@"%@",_hudQueue);
    JsenUNLOCK(_lock)
}

#pragma mark -
#pragma mark - Public Method
+ (void)dismiss {
    
    [[self shareDefault] hideHUD];
}

- (void)showHUDWithInfo:(NSDictionary *)info {
    
    if (self.alpha == 0)
    {
        self.alpha = 1;
        
        self.hud.alpha     = 0;
        self.hud.transform = CGAffineTransformScale(self.hud.transform, 1.4, 1.4);
        self.showingHUDInfo = info;
        
        NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
        [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
            self.hud.transform = CGAffineTransformScale(self.hud.transform, 1/1.4, 1/1.4);
            self.hud.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)hideHUD {
    if (self.alpha != 0)
    {
        NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;
        [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
            self.hud.transform = CGAffineTransformScale(self.hud.transform, 0.7, 0.7);
            self.hud.alpha = 0;
        }
                         completion:^(BOOL finished) {
                             
                             JsenLOCK(_lock)
                             if (self.hudQueue.count > 0) {
                                 [self.hudQueue removeObject:self.showingHUDInfo];
                             }
                             self.showingHUDInfo = nil;
                             JsenUNLOCK(_lock)
                             
                             [self hudDestroy];
                             self.alpha = 0;
                             [self showNext];
                         }];
    }
    
}

+ (void)showText:(NSString *)text interaction:(BOOL)interaction {
    [[self shareDefault] configHUD:text image:nil showSpinner:YES autoHidenHUD:NO interaction:interaction superView:nil];
    
}

+ (void)showText:(NSString *)text {
    [[self shareDefault] configHUD:text image:nil showSpinner:YES autoHidenHUD:NO interaction:NO superView:nil];
}

+ (void)showText:(NSString *)text superView:(id)superView {
    [[self shareDefault] configHUD:text image:nil showSpinner:YES autoHidenHUD:NO interaction:NO superView:superView];
}

+ (void)showToastWithoutStatus:(NSString *)text {
    [[self shareDefault] configHUD:text image:nil showSpinner:NO autoHidenHUD:YES interaction:NO superView:nil];
}

+ (void)showSuccess:(NSString *)text {
    [[self shareDefault] configHUD:text image:Jsen_HUD_IMAGE_SUCCESS showSpinner:NO autoHidenHUD:YES interaction:NO superView:nil];
    
}

+ (void)showSuccess:(NSString *)text superView:(id)superView {
    [[self shareDefault] configHUD:text image:Jsen_HUD_IMAGE_SUCCESS showSpinner:NO autoHidenHUD:YES interaction:NO superView:superView];
    
}


+ (void)showSuccess:(NSString *)text interaction:(BOOL)interaction {
    [[self shareDefault] configHUD:text image:Jsen_HUD_IMAGE_SUCCESS showSpinner:NO autoHidenHUD:YES interaction:interaction superView:nil];
    
}

+ (void)showError:(NSString *)text {
    [[self shareDefault] configHUD:text image:Jsen_HUD_IMAGE_ERROR showSpinner:NO autoHidenHUD:YES interaction:NO superView:nil];
}

+ (void)showError:(NSString *)text superView:(id)superView {
    [[self shareDefault] configHUD:text image:Jsen_HUD_IMAGE_ERROR showSpinner:NO autoHidenHUD:YES interaction:NO superView:superView];
}

+ (void)showError:(NSString *)text interaction:(BOOL)interaction {
    [[self shareDefault] configHUD:text image:Jsen_HUD_IMAGE_ERROR showSpinner:NO autoHidenHUD:YES interaction:interaction superView:nil];
    
}

#pragma mark - getter

- (UIFont *)textFont {
    if (!_textFont) {
        _textFont = [UIFont boldSystemFontOfSize:14];
    }
    return _textFont;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = UIColorFromRGB(0x353535);
    }
    return _textColor;
}

- (UIColor *)spinnerColor {
    if (!_spinnerColor) {
        _spinnerColor = UIColorFromRGB(0xb9dc2f);
    }
    return _spinnerColor;
}

- (UIColor *)hudBackgroundColor {
    if (!_hudBackgroundColor) {
        _hudBackgroundColor = UIColorFromRGB(0xffffff);
    }
    return _hudBackgroundColor;
}

- (UIColor *)hudWindowColor {
    if (!_hudWindowColor) {
        _hudWindowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    }
    return _hudWindowColor;
}

- (UIImage *)imageForSuccess {
    if (!_imageForSuccess) {
        _imageForSuccess = [UIImage imageNamed:@"jsen_hud_success"];
    }
    return _imageForSuccess;
}

- (UIImage *)imageForFail {
    if (!_imageForFail) {
        _imageForFail = [UIImage imageNamed:@"jsen_hud_error"];
    }
    return _imageForFail;
}

- (NSMutableArray *)hudQueue {
    if (!_hudQueue) {
        _hudQueue = [NSMutableArray array];
    }
    return _hudQueue;
}

@end
