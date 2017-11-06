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


@interface JsenHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray<JsenHomeCellModel *> *dataSource;

@end

@implementation JsenHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self loadInfo];
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
        JsenSuccessShow(@"成功");
        self.dataSource = response.data;
        [self.tableView reloadData];
    } failed:^(JsenNetworkingFailedResponse * _Nonnull response) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            JsenErrorShow(response.message);
            //假装请求成功
            [self.tableView reloadData];
        });
    } finished:^{
        
    }];
}

- (void)pushToLoadingVC {
    JsenLoadingViewController *VC = [[JsenLoadingViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)pushToUIButtonJsenKitVC {
    JsenUIButtonJsenKitViewController *VC = [[JsenUIButtonJsenKitViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
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

        _dataSource = [[NSMutableArray alloc] initWithObjects:model,model1, nil];
    }
    return _dataSource;
}

@end
