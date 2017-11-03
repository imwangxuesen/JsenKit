//
//  JsenUIButtonJsenKitViewController.m
//  JsenKit
//
//  Created by WangXuesen on 2017/11/3.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenUIButtonJsenKitViewController.h"
#import "UIButton+JsenKit.h"

@interface JsenUIButtonJsenKitViewController ()

@end

@implementation JsenUIButtonJsenKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews {
    self.navigationItem.title = @"UIButton+JsenKit.h";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat view_centerX = CGRectGetMidX(self.view.frame);
    CGFloat view_centerY = CGRectGetMidY(self.view.frame) - 60;
    
    CGFloat button_width = 150;
    CGFloat button_height = 70;
    CGFloat space = 5;
    
    
    UIButton *underLine = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, button_width, button_height)];
    underLine.center = CGPointMake(view_centerX, view_centerY-button_height-space);
    [underLine setTitle:@"up" forState:UIControlStateNormal];
    [underLine addUnderlineToTitleWithRange:NSMakeRange(0, 1) underlineColor:[UIColor yellowColor]];
    [underLine setImage:[UIImage imageNamed:@"tab_setting_sel"] forState:UIControlStateNormal];
    [underLine configImageAndTitleRelativePosition:JsenButtonImageViewPositionUp];
    [underLine configBackgroundImageWithColor:[UIColor greenColor]];
    [self.view addSubview:underLine];
    
    UIButton *underLine2 = [[UIButton alloc] initWithFrame:CGRectMake(0,0, button_width, button_height)];
    underLine2.center = CGPointMake(view_centerX ,view_centerY + button_height + space);
    [underLine2 setTitle:@"down" forState:UIControlStateNormal];
    [underLine2 addUnderlineToTitleWithRange:NSMakeRange(0, 2) underlineColor:[UIColor redColor]];
    [underLine2 setImage:[UIImage imageNamed:@"tab_setting_sel"] forState:UIControlStateNormal];
    [underLine2 configImageAndTitleRelativePosition:JsenButtonImageViewPositionDown];
    [underLine2 configBackgroundImageWithColor:[UIColor greenColor]];
    [self.view addSubview:underLine2];
    
    UIButton *underLine3 = [[UIButton alloc] initWithFrame:CGRectMake(0,0, button_width, button_height)];
    underLine3.center = CGPointMake(view_centerX - button_width/2.0 - space,view_centerY);
    [underLine3 setTitle:@"left" forState:UIControlStateNormal];
    [underLine3 addUnderlineToTitleWithRange:NSMakeRange(1, 2) underlineColor:[UIColor blackColor]];
    [underLine3 setImage:[UIImage imageNamed:@"tab_setting_sel"] forState:UIControlStateNormal];
    [underLine3 configImageAndTitleRelativePosition:JsenButtonImageViewPositionLeft];
    [underLine3 configBackgroundImageWithColor:[UIColor greenColor]];
    [self.view addSubview:underLine3];
    
    UIButton *underLine4 = [[UIButton alloc] initWithFrame:CGRectMake(0,0, button_width, button_height)];
    underLine4.center = CGPointMake(view_centerX + button_width/2.0 + space,view_centerY);
    [underLine4 setTitle:@"right" forState:UIControlStateNormal];
    [underLine4 addUnderlineToTitleWithRange:NSMakeRange(0, 5) underlineColor:[UIColor blueColor]];
    [underLine4 setImage:[UIImage imageNamed:@"tab_setting_sel"] forState:UIControlStateNormal];
    [underLine4 configImageAndTitleRelativePosition:JsenButtonImageViewPositionRight];
    [underLine4 configBackgroundImageWithColor:[UIColor greenColor]];
    [self.view addSubview:underLine4];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
