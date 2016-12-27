//
//  JsenNetworkingReachabilityManager.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/28.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenNetworkingReachabilityManager.h"
#import "AFNetworkReachabilityManager.h"

@interface JsenNetworkingReachabilityManager()

/**
 真正用来监听网路状态的对象，本类的封装的核心。
 + (instancetype _Nonnull)manager;
 会初始化
 */
@property (nonatomic, strong) AFNetworkReachabilityManager * _Nonnull afnManager;

@end
static JsenNetworkingReachabilityManager *mgr = nil;


@implementation JsenNetworkingReachabilityManager
+ (instancetype _Nonnull)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[JsenNetworkingReachabilityManager alloc] init];
        mgr.afnManager = [AFNetworkReachabilityManager manager];
    });
    return mgr;
}

- (void)setJsenReachabilityStatusChangeBlock:(nullable void (^)(JsenNetworkingReachabilityStatus status))block {
    [mgr.afnManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.networkStatusConfirm = YES;
        self.currentStatus = (JsenNetworkingReachabilityStatus)status;
        if (block) {
            block(self.currentStatus);
        }
    }];
}

- (void)startMonitoring {
    [mgr.afnManager startMonitoring];
}

- (void)stopMonitoring {
    [mgr.afnManager stopMonitoring];
}

@end
