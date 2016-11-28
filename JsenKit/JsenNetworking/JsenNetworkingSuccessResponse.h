//
//  JsenNetworkingSuccessResponse.h
//  JsenKit
//
//  Created by WangXuesen on 2016/11/14.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsenNetworkingSuccessResponse : NSObject

/**
 NSURLResponse 有可能为空
 */
@property (nonatomic, strong) NSURLResponse *urlResponse;

/**
 下载成功后的文件路径
 */
@property (nonatomic, strong) NSURL *filePath;

/**
 网络请求成功后的json数据
 */
@property (nonatomic, strong) NSDictionary *responseObject;

/**
 json成后解析后的model对象
 */
@property (nonatomic, strong) id data;

/**
 网络请求的状态码，这里对应的是服务端返回来的code值，不一定和http的状态码一一对应
 */
@property (nonatomic, strong) NSNumber *code;

/**
 网络请求成功回调后的消息字段信息
 */
@property (nonatomic, copy) NSString *message;

/**
 网络请求成功回调后的时间戳 （根据服务端的返回格式可有可无）
 */
@property (nonatomic, strong) NSNumber *timestamp;

/**
 初始化

 @param responseObject 请求成功后回调的json
 @param apiKey apiKey
 @return self的实例
 */
+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject apiKey:(NSString *)apiKey;

/**
 下载成功后的初始化

 @param response NSURLResponse
 @param filePath 文件存放路径
 @return self的实例
 */
+ (instancetype)downloadSuccesResponsesWithResponse:(NSURLResponse *)response filePath:(NSURL *)filePath;
@end
