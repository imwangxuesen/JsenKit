//
//  JsenTextView.m
//  JsenKit
//
//  Created by WangXuesen on 2017/9/25.
//  Copyright © 2017年 Xuesen Wang. All rights reserved.
//

#import "JsenTextView.h"

@implementation JsenTextView


-(instancetype)initWithPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor {
    self = [super init];
    if (self) {
        
        self.placeholder = placeholder;
        self.placeholderColor = placeholderColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:nil];
        self.autoresizesSubviews = NO;
        self.returnKeyType = UIReturnKeySend;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //内容为空时才绘制placeholder
    if ([self.text isEqualToString:@""]) {
        CGRect placeholderRect;
        placeholderRect.origin.y = 8;
        placeholderRect.size.height = CGRectGetHeight(self.frame)-8;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            placeholderRect.origin.x = 5;
            placeholderRect.size.width = CGRectGetWidth(self.frame)-5;
        } else {
            placeholderRect.origin.x = 10;
            placeholderRect.size.width = CGRectGetWidth(self.frame)-10;
        }
        [self.placeholderColor set];
        [self.placeholder drawInRect:placeholderRect withAttributes:@{NSFontAttributeName : self.font , NSForegroundColorAttributeName :self.placeholderColor }];
        
    }
}

- (void)textChanged:(NSNotification *)not
{
    if (!self.markedTextRange) {
        NSString *text = (NSString *)not.object;
        if (text.length > self.characterMaximum) {
           text = [text substringToIndex:self.characterMaximum];
            self.text = text;
        }
    }
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

#pragma mark - getter
- (UIColor *)placeholderColor {
    if (!_placeholderColor) {
        _placeholderColor = [UIColor colorWithRed:196/255.0 green:200/255.0 blue:208/255.0 alpha:1.0];
    }
    return _placeholderColor;
}

- (NSString *)placeholder {
    if (!_placeholder) {
        _placeholder = @"请输入";
    }
    return _placeholder;
}

- (NSInteger)characterMaximum {
    if (!_characterMaximum) {
        _characterMaximum = 200;
    }
    return _characterMaximum;
}

- (NSInteger)characterMinimum {
    if (!_characterMinimum) {
        _characterMinimum = 0;
    }
    return _characterMinimum;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
