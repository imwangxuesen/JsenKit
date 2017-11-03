//
//  UIButton+JsenKit.m
//  JsenKit
//
//  Created by WangXuesen on 2017/11/3.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "UIButton+JsenKit.h"
#import "UIImage+JsenKit.h"

@implementation UIButton (JsenKit)
- (void)addUnderlineToTitleWithRange:(NSRange)range underlineColor:(UIColor *)underlineColor {
    
    BOOL titleShowing = self.titleLabel && !self.titleLabel.hidden;
    if (!titleShowing) {
        return;
    }

    if (!NSLocationInRange(range.location+range.location,NSMakeRange(0, self.titleLabel.text.length))) {
        return;
    }
        NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    [title addAttributes:@{NSUnderlineColorAttributeName:underlineColor,NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:range];
    self.titleLabel.attributedText = title;
    

}

- (void)configBackgroundImageWithColor:(UIColor *)color {
    [self setBackgroundImage:[UIImage js_imageWithColor:color rect:self.bounds] forState:UIControlStateNormal];
}

- (void)configImageAndTitleRelativePosition:(JsenButtonImageViewPosition)position {
    BOOL titleShowing = self.titleLabel && !self.titleLabel.hidden;
    if (!titleShowing) {
        return;
    }
    
    BOOL imageShowing = self.imageView && !self.imageView.hidden;
    if (!imageShowing) {
        return;
    }
    
    CGFloat button_centerX = CGRectGetMidX(self.bounds);
    CGFloat button_centerY = CGRectGetMinY(self.bounds);
    CGFloat titleLabel_centerX = CGRectGetMidX(self.titleLabel.frame);
    CGFloat titleLabel_centerY = CGRectGetMinY(self.titleLabel.frame);
    CGFloat titleLabel_width = self.titleLabel.bounds.size.width;

    CGFloat imageView_centerX = CGRectGetMidX(self.imageView.frame);
    CGFloat imageView_centerY = CGRectGetMinY(self.imageView.frame);
    CGFloat imageView_width = self.imageView.bounds.size.width;

    
    switch (position) {
        case JsenButtonImageViewPositionUp:{
            self.imageEdgeInsets = UIEdgeInsetsMake(0- imageView_centerY,0 + (button_centerX - imageView_centerX),0,0 - (button_centerX - imageView_centerX));
            self.titleEdgeInsets = UIEdgeInsetsMake(titleLabel_centerY,0 - (titleLabel_centerX - button_centerX),0, 0 + (titleLabel_centerX - button_centerX));
        }
            break;
        case JsenButtonImageViewPositionDown:{
            self.imageEdgeInsets = UIEdgeInsetsMake(imageView_centerY,0 + (button_centerX - imageView_centerX),0,0 - (button_centerX - imageView_centerX));
            self.titleEdgeInsets = UIEdgeInsetsMake(0-titleLabel_centerY,0 - (titleLabel_centerX - button_centerX),0, 0 + (titleLabel_centerX - button_centerX));
        }
            break;
        case JsenButtonImageViewPositionRight:{
            self.imageEdgeInsets = UIEdgeInsetsMake(0,titleLabel_width,0,0-titleLabel_width);
            self.titleEdgeInsets = UIEdgeInsetsMake(0,0 - imageView_width,0,imageView_width);
        }
        default:
            break;
    }
    
    
}
@end
