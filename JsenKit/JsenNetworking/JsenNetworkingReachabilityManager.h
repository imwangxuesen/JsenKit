//
//  JsenNetworkingReachabilityManager.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/28.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JsenNetworkingReachabilityStatus) {
    JsenNetworkingReachabilityStatusUnknown          = -1,
    JsenNetworkingReachabilityStatusNotReachable     = 0,
    JsenNetworkingReachabilityStatusReachableViaWWAN = 1,
    JsenNetworkingReachabilityStatusReachableViaWiFi = 2,
};

@interface JsenNetworkingReachabilityManager : NSObject

/**
 当前的状态
 */
@property (nonatomic, assign) JsenNetworkingReachabilityStatus currentStatus;


+ (instancetype _Nonnull)manager;

/**
 Starts monitoring for changes in network reachability status.
 */
- (void)startMonitoring;

/**
 Stops monitoring for changes in network reachability status.
 */
- (void)stopMonitoring;

///---------------------------------------------------
/// @name Setting Network Reachability Change Callback
///---------------------------------------------------

/**
 Sets a callback to be executed when the network availability of the `baseURL` host changes.
 
 @param block A block object to be executed when the network availability of the `baseURL` host changes.. This block has no return value and takes a single argument which represents the various reachability states from the device to the `baseURL`.
 */

- (void)setJsenReachabilityStatusChangeBlock:(nullable void (^)(JsenNetworkingReachabilityStatus status))block;

@end
