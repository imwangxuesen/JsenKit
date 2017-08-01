//
//  TimerViewController.m
//  JsenKit
//
//  Created by WangXuesen on 2017/8/1.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property(nonatomic,strong) NSTimer *timer;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(takeIt:) userInfo:nil repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer");
    }];

}

- (void)takeIt:(NSTimer *)timer {
    NSLog(@"timer");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.timer invalidate];
    NSLog(@"timer invalidate");
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
