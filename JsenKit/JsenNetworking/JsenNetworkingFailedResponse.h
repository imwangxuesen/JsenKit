//
//  JsenNetworkingFailedResponse.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/14.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsenNetworkingFailedResponse : NSObject

/**
 网络请求的状态码，这里对应的是服务端返回来的code值，不一定和http的状态码一一对应
 */
@property (nonatomic, strong) NSNumber *code;

/**
 网络请求失败回调后的消息字段信息
 */
@property (nonatomic, copy) NSString *message;

/**
 失败信息
 */
@property (nonatomic, strong) NSDictionary *userInfo;

/**
 初始化

 @param error 错误对象
 @return self的实例
 */
+ (instancetype)responseWithError:(NSError *)error;

/**
 初始化

 @param responseObject http请求成功后的响应json
 @return self的实例
 */
+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject;
@end
