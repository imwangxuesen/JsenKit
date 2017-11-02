//
//  JsenTabBarControllerManager.m
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenTabBarControllerManager.h"
#import "JsenTabBarItemAttribute.h"


@implementation JsenTabBarControllerManager
+ (JsenTabBarController *)getTabBarController {
    
    JsenTabBarItemAttribute *attribute = [JsenTabBarItemAttribute configItemAttributeWithType:JsenTabBarItemAttributeShakeAnimationType];
    attribute.selectedImage = [UIImage imageNamed:@"tab_home_sel"];
    attribute.normalImage = [UIImage imageNamed:@"tab_home_nor"];
    attribute.selectedTitle = NSLocalizedString(@"home", nil);
    attribute.normalTitle = NSLocalizedString(@"home", nil);
    attribute.normalTitleFont = [UIFont systemFontOfSize:10];
    attribute.selectedTitleFont = [UIFont systemFontOfSize:10];
    attribute.normalTitleColor = [UIColor whiteColor];
    attribute.selectedTitleColor = [UIColor yellowColor];
    
    JsenTabBarItemAttribute *attribute2 = [JsenTabBarItemAttribute configItemAttributeWithType:JsenTabBarItemAttributeZoomAnimationType];
    attribute2.selectedImage = [UIImage imageNamed:@"tab_found_sel"];
    attribute2.normalImage = [UIImage imageNamed:@"tab_found_nor"];
    attribute2.selectedTitle = NSLocalizedString(@"found", nil);
    attribute2.normalTitle = NSLocalizedString(@"found", nil);
    attribute2.normalTitleFont = [UIFont systemFontOfSize:10];
    attribute2.selectedTitleFont = [UIFont systemFontOfSize:10];
    attribute2.normalTitleColor = [UIColor whiteColor];
    attribute2.selectedTitleColor = [UIColor yellowColor];
    
    JsenTabBarItemAttribute *attributePlus = [JsenTabBarItemAttribute configItemAttributeWithType:JsenTabBarItemAttributeCenterPlusBulgeType];
    attributePlus.selectedImage = [UIImage imageNamed:@"tab_plus"];
    attributePlus.normalImage = [UIImage imageNamed:@"tab_plus"];
    attributePlus.normalTitle = @"Plus";
    
    JsenTabBarItemAttribute *attribute3 = [JsenTabBarItemAttribute configItemAttributeWithType:JsenTabBarItemAttributeShakeAnimationType];
    attribute3.selectedImage = [UIImage imageNamed:@"tab_friend_sel"];
    attribute3.normalImage = [UIImage imageNamed:@"tab_friend_nor"];
    attribute3.selectedTitle = NSLocalizedString(@"message", nil);
    attribute3.normalTitle = NSLocalizedString(@"message", nil);
    attribute3.normalTitleFont = [UIFont systemFontOfSize:10];
    attribute3.selectedTitleFont = [UIFont systemFontOfSize:10];
    attribute3.normalTitleColor = [UIColor whiteColor];
    attribute3.selectedTitleColor = [UIColor yellowColor];
    
    JsenTabBarItemAttribute *attribute4 = [JsenTabBarItemAttribute configItemAttributeWithType:JsenTabBarItemAttributeZoomAnimationType];
    attribute4.selectedImage = [UIImage imageNamed:@"tab_setting_sel"];
    attribute4.normalImage = [UIImage imageNamed:@"tab_setting_nor"];
    attribute4.selectedTitle = NSLocalizedString(@"me", nil);
    attribute4.normalTitle = NSLocalizedString(@"me", nil);
    attribute4.normalTitleFont = [UIFont systemFontOfSize:10];
    attribute4.selectedTitleFont = [UIFont systemFontOfSize:10];
    attribute4.normalTitleColor = [UIColor whiteColor];
    attribute4.selectedTitleColor = [UIColor yellowColor];
    
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor blueColor];
    vc1.navigationItem.title = NSLocalizedString(@"home", nil);
    UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor grayColor];
    vc1.navigationItem.title = NSLocalizedString(@"found", nil);
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor greenColor];
    vc1.navigationItem.title = NSLocalizedString(@"message", nil);
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor yellowColor];
    vc1.navigationItem.title = NSLocalizedString(@"me", nil);
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    JsenTabBarController *tab = [[JsenTabBarController alloc] init];
    [tab configWithControllers:@[nv1,nv2,nv3,nv4] tabBarItemAttributes:@[attribute,attribute2,attributePlus,attribute3,attribute4]];
    
    return tab;
    
}
@end
