//
//  JsenNetworkingManagerTransmitDelegate.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/16.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsenNetworkingSuccessResponse.h"
#import "JsenNetworkingFailedResponse.h"

@protocol JsenNetworkingManagerTransmitDelegate <NSObject>

/**
 网络请求成功回调

 @param successResponse 成功的响应数据model JsenNetworkingSuccessResponse *
 @param api 请求的api
 */
- (void)jsenNetworkingSuccess:(JsenNetworkingSuccessResponse *)successResponse api:(NSString *)api;

/**
 网络请求失败回调（服务端抛出异常的错误并且不包含自定义error code时的错误）

 @param failedResponse 失败的响应数据model JsenNetworkingFailedResponse *
 @param api 请求的api
 */
- (void)jsenNetworkingFailed:(JsenNetworkingFailedResponse *)failedResponse api:(NSString *)api;

/**
 自定义错误码失败时的回调 自定义错误码的设置请看JsenNetworkingConfig 类中的
 @property (nonatomic, strong) NSDictionary *customErrorStatusCode;
 
 @param failedResponse 失败的响应数据model JsenNetworkingFailedResponse *
 @param api 请求的api
 */
- (void)jsenNetworkingCustomErrorFailed:(JsenNetworkingFailedResponse *)failedResponse api:(NSString *)api;

/**
 网络请求进度回调(有进度的请求才会回调)
 
 @param progress 进度 NSProgress *
 */
- (void)jsenNetworkingProgress:(NSProgress *)progress;

/**
 网络请求结束的回调（在成功失败时都会调用）

 @param api 请求的api
 */
- (void)jsenNetworkingFinished:(NSString *)api;

@end
