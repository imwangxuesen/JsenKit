//
//  JsenTabBar.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBar.h"
#import "JsenTabBarItem.h"
#import "JsenTabBarItemAttribute.h"

@interface JsenTabBar()

@property (nonatomic,assign)UIEdgeInsets oldSafeAreaInsets;


@end


@implementation JsenTabBar {
    // if one attribute with type equl 'JsenTabBarItemAttributeCenterPlusUnBulgeType' or 'JsenTabBarItemAttributeCenterPlusBulgeType' in 'tabBarItemAttributes', hadPlusButton will be YES,but is NO.
    BOOL __block _hadPlusButton;
    
    // it's value will be assignment when one attribute with type equl 'JsenTabBarItemAttributeCenterPlusUnBulgeType' or 'JsenTabBarItemAttributeCenterPlusBulgeType' in 'tabBarItemAttributes'.
    JsenTabBarItemAttributeType __block _plusButtonType;
    
    // it's storage JsenTabBarItems
    NSMutableArray<JsenTabBarItem *> *_buttonArray;
    
    // system tabBar width
    CGFloat _tabBarWidth;
    
    // if had one attribute is equl to xxxBulgeType, it's center item width,but it's 0.0.
    CGFloat _plusButtonWidth;
    
    // if attribute type is not equl to xxxBulgeType, it's not center item, so, this's height and width.
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
    _plusButtonWidth = self.plusButtonWidth?:self.frame.size.width * 0.25;
    _unPlusButtonHeight = self.frame.size.height;
    _unPlusButtonWidth = 0.0;
    if (_hadPlusButton) {
        _unPlusButtonWidth = (_tabBarWidth - _plusButtonWidth) / (self.tabBarItemAttributes.count-1);
    } else {
        _unPlusButtonWidth = _tabBarWidth / self.tabBarItemAttributes.count;
    }
    
    NSInteger tag = 0;
    UIButton *leftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, _unPlusButtonHeight)];
    for (JsenTabBarItemAttribute *attribute in self.tabBarItemAttributes) {
        JsenTabBarItem *item = [self configTabBarItemButtonWithAttribute:attribute tag:tag];
        if (attribute.type == JsenTabBarItemAttributeCenterPlusBulgeType) {
            CGFloat plusButtonExceedTabBarHeight = self.plusButtonExceedTabBarHeight?:20;
            item.frame = CGRectMake(CGRectGetMaxX(leftItem.frame), -plusButtonExceedTabBarHeight, _plusButtonWidth, _unPlusButtonHeight+plusButtonExceedTabBarHeight);
        } else if (attribute.type == JsenTabBarItemAttributeCenterPlusUnBulgeType) {
            item.frame = CGRectMake(CGRectGetMaxX(leftItem.frame), 0, _plusButtonWidth, _unPlusButtonHeight);
        } else {
            tag++;
            item.frame = CGRectMake(CGRectGetMaxX(leftItem.frame), 0, _unPlusButtonWidth, _unPlusButtonHeight);
        }
        [item configImageAndTitleEdgeInsets];
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        leftItem = item;
        [self addSubview:leftItem];
        [_buttonArray addObject:item];
        
        if (tag == 0) {
            self.currentSelectedItem = item;
        }
        
    }
    
    self.shadowImage = nil;
}


//update items frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _tabBarWidth = self.frame.size.width;
    _plusButtonWidth = self.frame.size.width * 0.25;
    if (_hadPlusButton) {
        _unPlusButtonWidth = (_tabBarWidth - _plusButtonWidth) / (self.tabBarItemAttributes.count-1);
    } else {
        _unPlusButtonWidth = _tabBarWidth / self.tabBarItemAttributes.count;
    }
    
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

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
- (void)setFrame:(CGRect)frame {
    if (self.superview &&CGRectGetMaxY(self.superview.bounds) !=CGRectGetMaxY(frame)) {
        frame.origin.y =CGRectGetHeight(self.superview.bounds) -CGRectGetHeight(frame);
    }
    [super setFrame:frame];
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    if(self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
       self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
       self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
       self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom)
    {
        self.oldSafeAreaInsets = self.safeAreaInsets;
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
    
}

- (CGSize)sizeThatFits:(CGSize) size {
    CGSize s = [super sizeThatFits:size];
    if(@available(iOS 11.0, *))
    {
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if( bottomInset > 0 && s.height < 50) {
            s.height += bottomInset;
        }
    }
    return s;
}
#endif


#pragma mark - private method
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

- (void)clearSelecteItemStatus {
    [_buttonArray enumerateObjectsUsingBlock:^(JsenTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != self.currentSelectedItem && obj.isSelected == YES) {
            obj.selected = NO;
        }
    }];
}

- (void)configSelectedItemWithIndex:(NSInteger)index {
    JsenTabBarItem *item = _buttonArray[index];
    item.selected = YES;
}

#pragma mark - clicked action
// item clicked action
- (void)itemClicked:(JsenTabBarItem *)sender {
    if (!sender.isSelected) {
        if (sender.jsenAttribute.type == JsenTabBarItemAttributeCenterPlusBulgeType || sender.jsenAttribute.type == JsenTabBarItemAttributeCenterPlusUnBulgeType) {
            if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(jsenTabBarCenterItemClicked:)]) {
                [self.tabBarDelegate jsenTabBarCenterItemClicked:sender];
            }
        } else {
            if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(jsenTabBarUnCenterItemClicked:)]) {
                [self.tabBarDelegate jsenTabBarUnCenterItemClicked:sender];
            }
            self.currentSelectedItem = sender;
            [self clearSelecteItemStatus];
            sender.selected = YES;
            [sender animation];
            
            
            
        }
    }
}




@end
