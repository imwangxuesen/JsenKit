//
//  JsenNetworkingReachabilityManager.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/28.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenNetworkingReachabilityManager.h"


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

- (void)setReachabilityStatusChangeBlock:(nullable void (^)(AFNetworkReachabilityStatus status))block {
    [mgr.afnManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.currentStatus = (JsenNetworkingReachabilityStatus)status;
        if (block) {
            block(status);
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
