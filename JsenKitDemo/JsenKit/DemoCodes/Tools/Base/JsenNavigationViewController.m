//
//  JsenNavigationViewController.m
//  JsenKit
//
//  Created by Xuesen Wang on 2017/9/13.
//  Copyright © 2017年 Xuesen Wang. All rights reserved.
//

#import "JsenNavigationViewController.h"
#import "UIImage+JsenKit.h"
#import "UIColor+JsenKit.h"

@interface JsenNavigationViewController ()

@end

@implementation JsenNavigationViewController


+ (void)initialize
{
    
    if (self == [JsenNavigationViewController class]) {
        UINavigationBar *navigationBar = [UINavigationBar appearance];
        [navigationBar setBackgroundImage:[UIImage js_imageWithColor:[UIColor js_ColorWithHex:0x28a7e2 alpha:1.0]  rect:CGRectMake(0, 0, JsenScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
        [navigationBar setTranslucent:NO];
        [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        [navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back"]];
        [navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];

        [navigationBar setTintColor:[UIColor whiteColor]];
        navigationBar.shadowImage = [UIImage new];

        //隐藏返回键title
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-400, 0)
                                                             forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
