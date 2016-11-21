//
//  JsenTabBarController.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/18.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenTabBarController.h"

@interface JsenTabBarController ()

@end

@implementation JsenTabBarController {
    NSArray *_attributes;
}

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers tabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes {
    self = [super init];
    if (self) {
        _customControllers = controllers;

    }
    return self;
}


- (void)configWithControllers:(NSArray<UIViewController *> *)controllers tabBarItemAttributes:(NSArray<JsenTabBarItemAttribute*> *)attributes {
    _attributes = attributes;
    self.customControllers = controllers;
    [self setViewControllers:self.customControllers animated:YES];
    self.customTabBar = [[JsenTabBar alloc] initWithFrame:self.tabBar.frame];
    [self.customTabBar configWithTabBarItemAttributes:_attributes];
    [self setValue:self.customTabBar forKey:@"tabBar"];

}


- (void)viewDidLoad {
    [super viewDidLoad];

}




- (void)plusClicked:(UIButton *)sender {

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
