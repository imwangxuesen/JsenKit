//
//  ViewController.m
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/14.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "JsenNetworkingManager.h"
#import "JsenNetworkingConfig.h"
#import "BannerModel.h"

@interface ViewController ()<JsenNetworkingManagerTransmitDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //配置:
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    
    //配置根url
    config.host = @"http://test-nirvana.ucredit.com";
    
    //若不配置则为默认值，配置超时时间
    config.timeoutInterval = @{
                               @"/nirvana/comment/feedBack":@"30",
                             };
    
    //配置model class
    config.modelClass = @{
                          @"/nirvana/comment/feedBack":NSClassFromString(@"BannerModel"),
                          };
    
    //配置公共参数
    config.globalParameters =  @{
                             @"blackBox"    :@"ewogICJ0b2tlbklkIiA6ICJ1Y3JlZGl0MTU4NmM1OGQxODMtNmE3MzU2NTA4NTY0YmZjMzI4ZWZkY2QwMTI4ZGYxY2QiLAogICJvcyIgOiAiaU9TIiwKICAicHJvZmlsZVRpbWUiIDogMTk4LAogICJ2ZXJzaW9uIiA6ICIyLjEuNCIKfQ==",
                                 @"clientIp"        : @"10.255.18.53",
                                 @"clientVersion"   : @"2.0.1",
                                 @"deviceInfo"      : @"{\"deviceModel\":\"iPhone 6S\",\"deviceOs\":\"iOS10.0.2\"}",
                                 @"network"         : @"WIFI",
                                 @"platform"        : @"iOS",
                                 @"screenSize"      : @"375x667",
                                 @"token"           : @"b906911b-a522-4238-9ed9-19dad83fe1d7",
                                 @"userId"          : @262,
                                 
                                 };
    
    //配置自定义的错误码及其message
    config.customErrorStatusCode = @{
                                     @10018:@"token error",
                                     };
    
    //配置默认超时时间，若不配置默认为10s
    config.defaultTimeoutInterval = 20.0;
    
}



//发起上传请求。
- (IBAction)buttonaction:(id)sender {
    
    [JsenNetworkingManagerTransmit shareTransmit].delegate = self;
    
    [[JsenNetworkingManager manager] uploadTaskWithMultiPartApiKey:@"/nirvana/comment/feedBack" name:@"files"
                                                         dataArray:@[
                                                                     UIImagePNGRepresentation([UIImage imageNamed:@"waiting"]),
                                                                     UIImagePNGRepresentation([UIImage imageNamed:@"waiting"]),
                                                                     UIImagePNGRepresentation([UIImage imageNamed:@"waiting"])
                                                                     ]
                                                     fileNameArray:@[
                                                                     @"imagename1.png",
                                                                     @"imagename2.png",
                                                                     @"imagename3.png"
                                                                     ]
                                                          mimeType:@"image/png"
                                                        parameters:@{@"mobile":@18600722414,
                                                                     @"content":@"hahaha"}
                                                          delegate:self];
}



#pragma mark - JsenNetworkingManagerTransmitDelegate

/**
 网络请求成功回调
 
 @param successResponse 成功的响应数据model JsenNetworkingSuccessResponse *
 @param api 请求的api
 */
- (void)jsenNetworkingSuccess:(JsenNetworkingSuccessResponse *)successResponse api:(NSString *)api {
    
}

/**
 网络请求失败回调（服务端抛出异常的错误并且不包含自定义error code时的错误）
 
 @param failedResponse 失败的响应数据model JsenNetworkingFailedResponse *
 @param api 请求的api
 */
- (void)jsenNetworkingFailed:(JsenNetworkingFailedResponse *)failedResponse api:(NSString *)api {
    
}

/**
 自定义错误码失败时的回调 自定义错误码的设置请看JsenNetworkingConfig 类中的
 @property (nonatomic, strong) NSDictionary *customErrorStatusCode;
 
 @param failedResponse 失败的响应数据model JsenNetworkingFailedResponse *
 @param api 请求的api
 */
- (void)jsenNetworkingCustomErrorFailed:(JsenNetworkingFailedResponse *)failedResponse api:(NSString *)api {
    
}

/**
 网络请求进度回调(有进度的请求才会回调)
 
 @param progress 进度 NSProgress *
 */
- (void)jsenNetworkingProgress:(NSProgress *)progress {
    
}

/**
 网络请求结束的回调（在成功失败时都会调用）
 
 @param api 请求的api
 */
- (void)jsenNetworkingFinished:(NSString *)api {
    
    
}

@end
