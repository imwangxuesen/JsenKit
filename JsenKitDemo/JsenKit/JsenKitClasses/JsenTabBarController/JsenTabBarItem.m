//
//  JsenTabBarItem.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/21.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBarItem.h"
#import "JsenTabBarItemAttribute.h"

#define angelToRandian(x) ((x)/180.0*M_PI)

@implementation JsenTabBarItem

- (instancetype)initWithAttribute:(JsenTabBarItemAttribute *)attribute
{
    self = [super init];
    if (self) {
        self.jsenAttribute = attribute;
    }
    return self;
}

#pragma mark - animation
- (void)animation {
    switch (self.jsenAttribute.type) {
        case JsenTabBarItemAttributeShakeAnimationType:
            [self shakeAnimation];
            break;
        case JsenTabBarItemAttributeZoomAnimationType:
            [self zoomAnimation];
            
        default:
            break;
    }
}

- (void)shakeAnimation {
    CALayer *layer = [self layer];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(angelToRandian(-7)),@(angelToRandian(7)),@(angelToRandian(-7))];
    animation.repeatCount = 5;
    animation.duration = 0.1;
    [layer addAnimation:animation forKey:@"shake"];
}

- (void)zoomAnimation {
    CALayer *layer = [self layer];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"CAKeyframeAnimationanimation"];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [layer addAnimation:animation forKey:nil];
}
#pragma mark - private method
- (void)configImageAndTitleEdgeInsets {
    self.titleLabel.backgroundColor = self.backgroundColor;
    self.imageView.backgroundColor = self.backgroundColor;
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    CGFloat interval = 1.0;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width))];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval + 1.0, -(imageSize.width), 0, 0)];
}


#pragma mark - setter
- (void)setJsenAttribute:(JsenTabBarItemAttribute *)jsenAttribute {
    _jsenAttribute = jsenAttribute;
    
    NSString *normalTitle = jsenAttribute.normalTitle?:@"";
    NSString *selectedTitle = jsenAttribute.selectedTitle?:normalTitle;
    UIColor *normalTitleColor = jsenAttribute.normalTitleColor?:[UIColor blackColor];
    UIColor *selectedTitleColor = jsenAttribute.selectedTitleColor?:normalTitleColor;
    UIColor *backgroundColor = jsenAttribute.backgroundColor?:[UIColor clearColor];
    UIFont *normalFont = jsenAttribute.normalTitleFont?:[UIFont systemFontOfSize:10];
    UIFont *selectedFont = jsenAttribute.selectedTitleFont?:normalFont;
    NSAttributedString *normalAttributeTitle = [[NSAttributedString alloc] initWithString:normalTitle attributes:@{NSForegroundColorAttributeName:normalTitleColor,NSFontAttributeName:normalFont}];
    NSAttributedString *selectedAttributeTitle = [[NSAttributedString alloc] initWithString:selectedTitle attributes:@{NSForegroundColorAttributeName:selectedTitleColor,NSFontAttributeName:selectedFont}];
    
    [self setBackgroundColor:backgroundColor];
    [self setImage:jsenAttribute.normalImage forState:UIControlStateNormal];
    [self setImage:jsenAttribute.selectedImage forState:UIControlStateSelected];
    [self setBackgroundImage:jsenAttribute.normalBackgroundImage forState:UIControlStateNormal];
    [self setBackgroundImage:jsenAttribute.selectedBackgroundImage forState:UIControlStateSelected];
    [self setAttributedTitle:normalAttributeTitle forState:UIControlStateNormal];
    [self setAttributedTitle:selectedAttributeTitle forState:UIControlStateSelected];
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
