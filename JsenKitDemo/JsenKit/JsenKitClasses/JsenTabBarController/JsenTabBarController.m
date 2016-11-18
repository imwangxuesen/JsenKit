//
//  JsenTabBarController.m
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBarController.h"

@interface JsenTabBarController ()

@end

@implementation JsenTabBarController {
    BOOL __block _hadPlusButton;
    JsenTabBarItemAttributeType __block _plusButtonType;
    NSMutableArray *_buttonArray;
}

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers tabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes {
    self = [super init];
    if (self) {
        _customControllers = controllers;
        _tabBarItemAttributes = attributes;
    }
    return self;
}

- (UIButton *)configTabBarItemButtonWithAttribute:(JsenTabBarItemAttribute *)attribute tag:(NSInteger)tag {
    UIButton *btn = [[UIButton alloc] init];
    
    NSString *normalTitle = attribute.normalTitle?:@"";
    NSString *selectedTitle = attribute.selectedTitle?:normalTitle;
    UIColor *normalTitleColor = attribute.normalTitleColor?:[UIColor blackColor];
    UIColor *selectedTitleColor = attribute.selectedTitleColor?:normalTitleColor;
    UIColor *backgroundColor = attribute.backgroundColor?:[UIColor clearColor];
    UIFont *normalFont = attribute.normalTitleFont?:[UIFont systemFontOfSize:10];
    UIFont *selectedFont = attribute.selectedTitleFont?:normalFont;
    NSAttributedString *normalAttributeTitle = [[NSAttributedString alloc] initWithString:normalTitle attributes:@{NSForegroundColorAttributeName:normalTitleColor,NSFontAttributeName:normalFont}];
    NSAttributedString *selectedAttributeTitle = [[NSAttributedString alloc] initWithString:selectedTitle attributes:@{NSForegroundColorAttributeName:selectedTitleColor,NSFontAttributeName:selectedFont}];
    
    [btn setBackgroundColor:backgroundColor];
    [btn setImage:attribute.normalImage forState:UIControlStateNormal];
    [btn setImage:attribute.selectedImage forState:UIControlStateSelected];
    [btn setBackgroundImage:attribute.normalBackgroundImage forState:UIControlStateNormal];
    [btn setBackgroundImage:attribute.selectedBackgroundImage forState:UIControlStateSelected];
    
//    [btn setTitle:normalTitle forState:UIControlStateNormal];
//    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    
    
    [btn setAttributedTitle:normalAttributeTitle forState:UIControlStateNormal];
    [btn setAttributedTitle:selectedAttributeTitle forState:UIControlStateSelected];
    [btn setTag:tag];
    
    btn.titleLabel.backgroundColor = [UIColor blackColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;

    
    return btn;
}


- (void)configWithControllers:(NSArray<UIViewController *> *)controllers tabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes {
    self.customControllers = controllers;
    self.tabBarItemAttributes = attributes;
    _buttonArray = [[NSMutableArray alloc] init];

    [self setViewControllers:self.customControllers animated:YES];
    
    [self.tabBarItemAttributes enumerateObjectsUsingBlock:^(JsenTabBarItemAttribute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == JsenTabBarItemAttributeCenterPlusUnBulgeType || obj.type == JsenTabBarItemAttributeCenterPlusBulgeType) {
            _hadPlusButton = YES;
            *stop = YES;
        }
    }];
    
    CGFloat tabBarWidth = self.tabBar.frame.size.width;
    CGFloat plusButtonWidth = self.plusButtonWidth?:[UIScreen mainScreen].bounds.size.width * 0.25;
    CGFloat unPlusButtonHeight = self.tabBar.frame.size.height;
    CGFloat unPlusButtonWidth = 0.0;
    if (_hadPlusButton) {
        unPlusButtonWidth = (tabBarWidth - plusButtonWidth) / (self.tabBarItemAttributes.count-1);
    } else {
        unPlusButtonWidth = tabBarWidth / self.tabBarItemAttributes.count;
    }
    
    NSInteger tag = 0;
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, unPlusButtonHeight)];
    for (JsenTabBarItemAttribute *attribute in self.tabBarItemAttributes) {
        UIButton *btn = [self configTabBarItemButtonWithAttribute:attribute tag:tag];
        if (attribute.type == JsenTabBarItemAttributeCenterPlusBulgeType) {
            CGFloat plusButtonExceedTabBarHeight = self.plusButtonExceedTabBarHeight?:20;
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), -plusButtonExceedTabBarHeight, plusButtonWidth, unPlusButtonHeight+plusButtonExceedTabBarHeight);
        } else if (attribute.type == JsenTabBarItemAttributeCenterPlusUnBulgeType) {
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), 0, plusButtonWidth, unPlusButtonHeight);
        } else {
            tag++;
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), 0, unPlusButtonWidth, unPlusButtonHeight);
            [self configButton:btn];
        }
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArray addObject:btn];
        leftBtn = btn;
        [self.tabBar addSubview:leftBtn];
    }
    
    self.tabBar.shadowImage = nil;
}


- (void)configButton:(UIButton *)button {
    button.titleLabel.backgroundColor = button.backgroundColor;
    button.imageView.backgroundColor = button.backgroundColor;
    
    CGSize titleSize = button.titleLabel.bounds.size;
    CGSize imageSize = button.imageView.bounds.size;
    CGFloat interval = 1.0;
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width))];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval + 1.0, -(imageSize.width), 0, 0)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat tabBarWidth = self.tabBar.frame.size.width;
    CGFloat plusButtonWidth = self.plusButtonWidth?:[UIScreen mainScreen].bounds.size.width * 0.25;
    CGFloat unPlusButtonHeight = self.tabBar.frame.size.height;
    CGFloat unPlusButtonWidth = 0.0;
    if (_hadPlusButton) {
        unPlusButtonWidth = (tabBarWidth - plusButtonWidth) / (self.tabBarItemAttributes.count-1);
    } else {
        unPlusButtonWidth = tabBarWidth / self.tabBarItemAttributes.count;
    }
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, unPlusButtonHeight)];
    for (int i=0;i<self.tabBarItemAttributes.count;i++) {
        JsenTabBarItemAttribute *attribute = self.tabBarItemAttributes[i];
        UIButton *btn = _buttonArray[i];
        if (attribute.type == JsenTabBarItemAttributeCenterPlusBulgeType) {
            CGFloat plusButtonExceedTabBarHeight = self.plusButtonExceedTabBarHeight?:20;
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), -plusButtonExceedTabBarHeight, plusButtonWidth, unPlusButtonHeight+plusButtonExceedTabBarHeight);
        } else if (attribute.type == JsenTabBarItemAttributeCenterPlusUnBulgeType) {
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), 0, plusButtonWidth, unPlusButtonHeight);
        } else {
            btn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), 0, unPlusButtonWidth, unPlusButtonHeight);
        }
        leftBtn = btn;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    
    
//    UITabBarItem *item0 = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil tag:0];
//    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"朋友" image:nil tag:1];
//    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"发现" image:nil tag:2];
//    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"设置" image:nil tag:3];
//    

//    
//    
//    
//    UIButton *btn = [[UIButton alloc] init];
//    [btn setImage:[UIImage imageNamed:@"tab_home_nor"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"tab_home_sel"] forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    UIButton *btn2 = [[UIButton alloc] init];
//    [btn2 setImage:[UIImage imageNamed:@"tab_friend_nor"] forState:UIControlStateNormal];
//    [btn2 setImage:[UIImage imageNamed:@"tab_friend_sel"] forState:UIControlStateSelected];
//    [btn2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *plus = [[UIButton alloc] init];
//    [plus setImage:[UIImage imageNamed:@"tab_plus"] forState:UIControlStateNormal];
//    [plus setImage:[UIImage imageNamed:@"tab_plus"] forState:UIControlStateSelected];
//    [plus addTarget:self action:@selector(plusClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    
//    UIButton *btn3 = [[UIButton alloc] init];
//    [btn3 setImage:[UIImage imageNamed:@"tab_found_nor"] forState:UIControlStateNormal];
//    [btn3 setImage:[UIImage imageNamed:@"tab_found_sel"] forState:UIControlStateSelected];
//    [btn3 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    UIButton *btn4 = [[UIButton alloc] init];
//    [btn4 setImage:[UIImage imageNamed:@"tab_setting_nor"] forState:UIControlStateNormal];
//    [btn4 setImage:[UIImage imageNamed:@"tab_setting_sel"] forState:UIControlStateSelected];
//    [btn4 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    CGFloat btnWidth = self.tabBar.frame.size.width/5.0;
//    CGFloat btnHeight = self.tabBar.frame.size.height;
//    
//    btn.frame = CGRectMake(0, 0, btnWidth, btnHeight);
//    btn.backgroundColor = [UIColor yellowColor];
//    
//    btn2.frame = CGRectMake(CGRectGetMaxX(btn.frame), 0, btnWidth, btnHeight);
//    btn2.backgroundColor = [UIColor greenColor];
//    
//    plus.frame = CGRectMake(CGRectGetMaxX(btn2.frame), -10, btnWidth, btnHeight+5);
//    
//    btn3.frame = CGRectMake(CGRectGetMaxX(plus.frame), 0, btnWidth, btnHeight);
//    btn3.backgroundColor = [UIColor blueColor];
//    [btn3 setTitle:@"发现" forState:UIControlStateNormal];
//    [btn3 setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
//    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn3.titleLabel.font = [UIFont systemFontOfSize:10];
//    [self configButton:btn3];
//    btn4.frame = CGRectMake(CGRectGetMaxX(btn3.frame), 0, btnWidth, btnHeight);
//    btn4.backgroundColor = [UIColor purpleColor];
//    
//    
//    UIView *titleTopView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), self.tabBar.frame.size.width, self.tabBar.frame.size.height- btnHeight)];
//    titleTopView.backgroundColor = [UIColor clearColor];
//    
//    [self.tabBar addSubview:btn];
//    [self.tabBar addSubview:btn2];
//    [self.tabBar addSubview:plus];
//    [self.tabBar addSubview:btn3];
//    [self.tabBar addSubview:btn4];
//    [self.tabBar addSubview:titleTopView];
}



- (void)btnClicked:(UIButton *)sender {
    if (!sender.isSelected) {
        sender.selected = YES;
        //TODO
    }
}


- (void)plusClicked:(UIButton *)sender {

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
