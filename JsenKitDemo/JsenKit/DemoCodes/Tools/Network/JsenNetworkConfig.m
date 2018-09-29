//
//  JsenNetworkConfig.m
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenNetworkConfig.h"

#import "JsenNetworkingConfig.h"
#import "JsenNetworkingReachabilityManager.h"


NSString *const Jsen_HomeList_API = @"/app/home/list";

NSString *const Jsen_Notification_Error_Code = @"10030";

@implementation JsenNetworkConfig

+ (void)config {
    
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    //根ulr
    config.host = @"http://test.jsen.com/demo";
    
    //url 对应的model， 没有model，或者不想解析成model 就不用写
    config.modelClass = @{
                          Jsen_HomeList_API:NSClassFromString(@"JsenHomeCellModel")
                          };
    
    //公共参数
    config.globalParametersBlock = ^NSDictionary *{
        return [JsenNetworkConfig globalParameters];
    };
    
    
    /*
     response 错误码监听
     比如 token 过期
     eg
     
     添加监听
     JsenNetworkingCustomHttpErrorNotificationKey 这个key 在 “JsenNetworkingConfig.h” 中
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commonNetworkErrorNotification:) name:JsenNetworkingCustomHttpErrorNotificationKey object:nil];

     收到监听
     - (void)commonNetworkErrorNotification:(NSNotification *)notifi {
        JsenNetworkingFailedResponse *response = [notifi object];
        NSLog(@"%@",notifi);
     }
     */
    config.customErrorStatusCode = @{
                                     @(Jsen_Notification_Error_Code.integerValue):@"登录过期，请重新登录"
                                     };
    
    // 如果你这个属性不实现,会有默认的 responseFormat.当然responseFormat也可以自定义,如下,二者选其一即可
    config.customSuccessDataAllKeys = [self configSuccessDataAllKeys];
    
    
    // 响应的数据格式
    config.responseFormat =  @{
                               JsenNetworkingResponseDataKey       :@"info",
                               JsenNetworkingResponseStatusCodeKey :@"codeNumber",
                               JsenNetworkingResponseMessageKey    :@"msg",
                               JsenNetworkingResponseTimelineKey   :@"time",
                               };
    
    
    // 请求序列化配置
    config.requestSerializerTypeConfig = @{
                                           Jsen_HomeList_API : @(JsenNetworkingConfigSerializerJSON)
                                           };
    // 设置http header
    config.httpHeader = @{
                          @"Content-Type":@"application/json"
                          };
    
    
    
    /*
     默认超时时长 单位：秒
     如果想对不同特殊接口做特殊的超时时长 请设置timeoutInterval属性
     */
    config.defaultTimeoutInterval = 30;
    
    
    /**
     监听网络状态

     startMonitoring 之后，由于 JsenNetworkingReachabilityManager 是单例，
     所以，通过[JsenNetworkingReachabilityManager manager].currentStatus 可以获取到当前的网络状态，全局可用。
     */
    [[JsenNetworkingReachabilityManager manager] setJsenReachabilityStatusChangeBlock:^(JsenNetworkingReachabilityStatus status) {
        //to do something
    }];
    [[JsenNetworkingReachabilityManager manager] startMonitoring];
    
}



+ (NSDictionary *)globalParameters {
    //公共参数
    NSString *netWorkStates = [JsenNetworkConfig getNetWorkStates];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970] * 1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    return    @{@"platform"        : @"iOS",
                @"network"         : netWorkStates,
                @"clientVersion"   : version,
                @"timestamp"       : timeString,
                };
}


+ (NSString *)getNetWorkStates {
    switch ([JsenNetworkingReachabilityManager manager].currentStatus) {
        case JsenNetworkingReachabilityStatusUnknown:
            return @"Unknown";
        case JsenNetworkingReachabilityStatusNotReachable:
            return @"NotReachable";
        case JsenNetworkingReachabilityStatusReachableViaWWAN:
            return @"WWAN";
        case JsenNetworkingReachabilityStatusReachableViaWiFi:
            return @"WiFi";
            
        default:
            break;
    }
}


+ (NSArray<NSString *> *)configSuccessDataAllKeys {
    return @[@"result", @"ext", JsenNetworkingResponseDataKeyDefine];
}


@end
