//
//  AppDelegate.m
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/14.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "AppDelegate.h"
#import "JsenTabBarController.h"
#import "JsenTabBarItemAttribute.h"
#import <AFNetworking.h>
#import "JsenFPSLabel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [JsenFPSLabel show];
    
    
    return YES;
}


- (void)configTabBarController {
    
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
    //    vc2.tabBarItem = item1;
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor greenColor];
    //    vc3.tabBarItem = item2;
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor yellowColor];
    //    vc4.tabBarItem = item3;
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    JsenTabBarController *tab = [[JsenTabBarController alloc] init];
    [tab configWithControllers:@[nv1,nv2,nv3,nv4] tabBarItemAttributes:@[attribute,attribute2,attributePlus,attribute3,attribute4]];
    
    
    self.window.rootViewController = tab;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
