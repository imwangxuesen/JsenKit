//
//  JsenTabBar.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBar.h"
#import "JsenTabBarItem.h"


@implementation JsenTabBar {
    BOOL __block _hadPlusButton;
    JsenTabBarItemAttributeType __block _plusButtonType;
    NSMutableArray *_buttonArray;
    
    CGFloat _tabBarWidth;
    CGFloat _plusButtonWidth;
    CGFloat _unPlusButtonHeight;
    CGFloat _unPlusButtonWidth;
}

/* config item attribute 、tag 、starting frame ，when frame updating layoutSubviews function will
   be call. items frame will update when layoutSubviews be call.
 */
- (void)configWithTabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes {
    self.tabBarItemAttributes = attributes;
    _buttonArray = [[NSMutableArray alloc] init];
    
    [self.tabBarItemAttributes enumerateObjectsUsingBlock:^(JsenTabBarItemAttribute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == JsenTabBarItemAttributeCenterPlusUnBulgeType || obj.type == JsenTabBarItemAttributeCenterPlusBulgeType) {
            _hadPlusButton = YES;
            *stop = YES;
        }
    }];
    
    _tabBarWidth = self.frame.size.width;
    _plusButtonWidth = self.plusButtonWidth?:[UIScreen mainScreen].bounds.size.width * 0.25;
    _unPlusButtonHeight = self.frame.size.height;
    _unPlusButtonWidth = 0.0;
    if (_hadPlusButton) {
        _unPlusButtonWidth = (_tabBarWidth - _plusButtonWidth) / (self.tabBarItemAttributes.count-1);
    } else {
        _unPlusButtonWidth = _tabBarWidth / self.tabBarItemAttributes.count;
    }
    
    NSInteger tag = 0;
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, _unPlusButtonHeight)];
    for (JsenTabBarItemAttribute *attribute in self.tabBarItemAttributes) {
        JsenTabBarItem *btn = [self configTabBarItemButtonWithAttribute:attribute tag:tag];
        if (attribute.type == JsenTabBarItemAttributeCenterPlusBulgeType) {
            CGFloat plusButtonExceedTabBarHeight = self.plusButtonExceedTabBarHeight?:20;
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), -plusButtonExceedTabBarHeight, _plusButtonWidth, _unPlusButtonHeight+plusButtonExceedTabBarHeight);
        } else if (attribute.type == JsenTabBarItemAttributeCenterPlusUnBulgeType) {
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), 0, _plusButtonWidth, _unPlusButtonHeight);
        } else {
            tag++;
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), 0, _unPlusButtonWidth, _unPlusButtonHeight);
            [btn configImageAndTitleEdgeInsets];
        }
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArray addObject:btn];
        leftBtn = btn;
        [self addSubview:leftBtn];
    }
    
    self.shadowImage = nil;
}


//update items frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    JsenTabBarItem *leftItem = [[JsenTabBarItem alloc] initWithFrame:CGRectMake(0, 0, 0, _unPlusButtonHeight)];
    for (int i=0;i<self.tabBarItemAttributes.count;i++) {
        JsenTabBarItemAttribute *attribute = self.tabBarItemAttributes[i];
        JsenTabBarItem *item = _buttonArray[i];
        if (attribute.type == JsenTabBarItemAttributeCenterPlusBulgeType) {
            CGFloat plusButtonExceedTabBarHeight = self.plusButtonExceedTabBarHeight?:20;
            item.frame = CGRectMake(CGRectGetMaxX(leftItem.frame), -plusButtonExceedTabBarHeight, _plusButtonWidth, _unPlusButtonHeight+plusButtonExceedTabBarHeight);
        } else if (attribute.type == JsenTabBarItemAttributeCenterPlusUnBulgeType) {
            item.frame = CGRectMake(CGRectGetMaxX(leftItem.frame), 0, _plusButtonWidth, _unPlusButtonHeight);
        } else {
            item.frame = CGRectMake(CGRectGetMaxX(leftItem.frame), 0, _unPlusButtonWidth, _unPlusButtonHeight);
        }
        leftItem = item;
    }
    [self bringToFront];
    
}

// bring every items to front
- (void)bringToFront {
    for (JsenTabBarItem *item in _buttonArray) {
        [self bringSubviewToFront:item];
    }
}

// init one item
- (JsenTabBarItem *)configTabBarItemButtonWithAttribute:(JsenTabBarItemAttribute *)attribute tag:(NSInteger)tag {
    JsenTabBarItem *item = [[JsenTabBarItem alloc] initWithAttribute:attribute];
    item.tag = tag;
    return item;
}

// item clicked action
- (void)btnClicked:(UIButton *)sender {
    if (!sender.isSelected) {
        sender.selected = YES;
        //TODO
    }
}



@end
