//
//  JsenHomeViewController.m
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenHomeViewController.h"
#import "JsenHomeTableViewCell.h"
#import "JsenLoadingViewController.h"
#import "JsenUIButtonJsenKitViewController.h"
#import "JsenAlertConfigManager.h"
#import "JsenAlert.h"
#import "UIViewController+JsenKit.h"

@interface JsenHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray<JsenHomeCellModel *> *dataSource;

@end

@implementation JsenHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadInfo];
    });
    [self setupJsenAlertConfigManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (void)setupSubviews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

/**
 假装请求数据
 */
- (void)loadInfo {
    JsenLoading(@"请稍后");
    
    NSDictionary *parameters = @{
                                 @"id":@123,
                                 @"page":@1
                                 };
    [[JsenNetworkingManager manager] post:Jsen_HomeList_API parameters:parameters progress:nil success:^(JsenNetworkingSuccessResponse * _Nonnull response) {
        JsenHUDDismiss;
        JsenSuccessShow(@"成功");
        self.dataSource = response.data;
        [self.tableView reloadData];
    } failed:^(JsenNetworkingFailedResponse * _Nonnull response) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            JsenHUDDismiss;
            JsenErrorShow(response.message);
            //假装请求成功
            [self.tableView reloadData];
        });
    } finished:^{
        
    }];
}

/**
 配置alert
 */
- (void)setupJsenAlertConfigManager {
    JsenAlertConfigManager *alertManager = [JsenAlertConfigManager shared];
    alertManager.titleColor = [UIColor grayColor];
    alertManager.titleFont = [UIFont systemFontOfSize:14];
    alertManager.detailMessageFont = [UIFont systemFontOfSize:13];
    alertManager.detailMessageColor = [UIColor grayColor];
    alertManager.firstButtonTitleNormalFont = [UIFont systemFontOfSize:15];
    alertManager.secondButtonTitleNormalFont = [UIFont systemFontOfSize:15];
}

/**
 去loading展示页面
 */
- (void)pushToLoadingVC {
    JsenLoadingViewController *VC = [[JsenLoadingViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 去UIButtonJsenKit类别展示页面
 */
- (void)pushToUIButtonJsenKitVC {
    JsenUIButtonJsenKitViewController *VC = [[JsenUIButtonJsenKitViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)showAlertViewDemo {
    [JsenAlert alertWithActionTitles:@[@"取消",@"确定"] title:@"提示" detailMessage:[NSString stringWithFormat:@"最上层的ViewController是:%@",[[UIViewController js_currentViewController] description]] action:^(NSInteger index) {
        NSLog(@"你点击了第%d个按钮",index);
    } animation:JsenAlertAnimationStylePop];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (JsenHomeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JsenHomeTableViewCell *cell = [JsenHomeTableViewCell dequeueReusableCellWithTableView:tableView
                                                                               identifier:NSStringFromClass([JsenHomeTableViewCell class])
                                                                             forIndexPath:indexPath
                                                                                    model:self.dataSource[indexPath.section]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            [self pushToLoadingVC];
            break;
        case 1:
            [self pushToUIButtonJsenKitVC];
            break;
        case 2:
            [self showAlertViewDemo];
            break;
        default:
            break;
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[JsenHomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JsenHomeTableViewCell class])];
    }
    return _tableView;
}

- (NSMutableArray<JsenHomeCellModel *> *)dataSource {
    if (!_dataSource) {
        JsenHomeCellModel *model = [JsenHomeCellModel setupModelWithName:@"loading" enable:YES showPoint:YES];
        JsenHomeCellModel *model1 = [JsenHomeCellModel setupModelWithName:@"UIButton+JsenKit" enable:YES showPoint:YES];
        JsenHomeCellModel *model2 = [JsenHomeCellModel setupModelWithName:@"JsenAlert" enable:YES showPoint:NO];

        
        _dataSource = [[NSMutableArray alloc] initWithObjects:model,model1,model2, nil];
    }
    return _dataSource;
}

@end
