//
//  JsenTabBarItem.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/21.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBarItem.h"
#import "JsenTabBarItemAttribute.h"


@implementation JsenTabBarItem


- (instancetype)initWithAttribute:(JsenTabBarItemAttribute *)attribute
{
    self = [super init];
    if (self) {
        self.jsenAttribute = attribute;
    }
    return self;
}



- (void)configImageAndTitleEdgeInsets {
    self.titleLabel.backgroundColor = self.backgroundColor;
    self.imageView.backgroundColor = self.backgroundColor;
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    CGFloat interval = 1.0;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width))];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval + 1.0, -(imageSize.width), 0, 0)];
}



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
