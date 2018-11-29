//
//  JsenLoadingViewController.m
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenLoadingViewController.h"

@interface JsenLoadingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *dataSource;

@end

@implementation JsenLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [JsenProgressHUD shareDefault].allowRepeat = NO;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 500, 100, 100)];
    [self.view addSubview:textView];
    
    for (int i = 0 ; i< 10; i++) {
        NSString *str = [NSString stringWithFormat:@"zheshi %d",i];
        
        JsenSuccessShow(str);
        if (i == 6) {
            JsenLoading(@"123");
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (void)setupSubviews {
    self.navigationItem.title = @"Loading";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *text = self.dataSource[indexPath.section];
    switch (indexPath.section) {
        case 0:
            JsenLoading(text);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                JsenHUDDismiss;
            });
            break;
        case 1:
            JsenLoading(nil);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                JsenHUDDismiss;
            });
            break;
        case 2:
            [JsenProgressHUD showToastWithoutStatus:@"without status"];
            
            break;
        case 3:
            JsenErrorShow(text);
            break;
        case 4:
            JsenSuccessShow(text);
            break;
            
        default:
//            JsenHUDDismiss;
            break;
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 40;
        _tableView.sectionFooterHeight = 1;
        _tableView.sectionHeaderHeight = 5;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
                        @"loading with text",
                        @"only loading",
                        @"toast without status",
                        @"error",
                        @"success",
                        @"dismiss"
                        ];
    }
    return _dataSource;
}
@end
