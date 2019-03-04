//
//  JsenNetworkingConfig.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/14.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenNetworkingConfig.h"
#import "JsenNetworkingReachabilityManager.h"


#pragma mark - 自定义错误的通知key
NSString *const JsenNetworkingCustomHttpErrorNotificationKey = @"JsenNetworkingCustomHttpErrorNotificationKey";

#pragma mark - json格式key
NSString *const JsenNetworkingResponseDataKey = @"data";
NSString *const JsenNetworkingResponseStatusCodeKey = @"code";
NSString *const JsenNetworkingResponseMessageKey = @"msg";
NSString *const JsenNetworkingResponseTimelineKey = @"timestamp";

#pragma mark - 默认超时时间
static NSTimeInterval const JsenNetworkingDefaultTimeOutInterval = 10;

#pragma mark - 签名方法

static JsenNetworkingConfig *config = nil;
@implementation JsenNetworkingConfig {
}

+ (instancetype)shareConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[JsenNetworkingConfig alloc] init];
        
        [[JsenNetworkingReachabilityManager manager] setJsenReachabilityStatusChangeBlock:nil];
        [[JsenNetworkingReachabilityManager manager] startMonitoring];
    });
    return config;
}


- (NSString *)api:(NSString *)apiKey {
    NSAssert(self.host != nil, @"JsenNetworkingConfig 'host' must be set");
    NSAssert(apiKey != nil, @"JsenNetworkingConfig 'api:' apiKey can`t nil");
    
    NSString *url = nil;
    if ([apiKey hasPrefix:@"http"]) {
        url = apiKey;
    } else {
        
        NSString *host = nil;
        if (self.hostMap && [self.hostMap objectForKey:apiKey]) {
            host = [self.hostMap objectForKey:apiKey];
        } else {
            host = self.host;
        }
        
        if ([apiKey hasPrefix:@"/"] && [host hasSuffix:@"/"]) {
            apiKey = [apiKey stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        } else if(![apiKey hasPrefix:@"/"] && ![host hasSuffix:@"/"]){
            host = [host stringByAppendingString:@"/"];
        }
        url = [NSString stringWithFormat:@"%@%@",host,apiKey];
    }
    return url;
}

#pragma mark - 请求返回model class
- (Class)modelClassWithAPIKey:(NSString *)apiKey {
    if (self.modelClass && [self.modelClass objectForKey:apiKey]) {
        return [self.modelClass objectForKey:apiKey];
    }
    return nil;
}

#pragma mark - 请求的超时时间
- (NSTimeInterval)timeoutIntervalWithAPIKey:(NSString *)apiKey {
    NSNumber *timeOut = nil;
    if (self.timeoutInterval) {
        id tmpTimeOut = [self.timeoutInterval objectForKey:apiKey];
        if ([tmpTimeOut isKindOfClass:[NSString class]]) {
            timeOut = [[NSNumberFormatter alloc] numberFromString:tmpTimeOut];
        } else if([tmpTimeOut isKindOfClass:[NSNumber class]]){
            timeOut = (NSNumber *)tmpTimeOut;
        } else {
            return self.defaultTimeoutInterval;
        }
    }
    if ([timeOut doubleValue] > 0.0) {
        return [timeOut doubleValue];
    }
    return self.defaultTimeoutInterval;
}


#pragma mark - getter
- (NSDictionary *)modelClass {
    if (!_modelClass) {
        _modelClass = @{};
    }
    return _modelClass;
}

- (NSDictionary *)httpHeader {
    if (!_httpHeader) {
        _httpHeader = @{};
    }
    return _httpHeader;
}

- (NSDictionary *)globalParameters {
    if (!_globalParameters || _alwaysRefreshGlobalParameters) {
        _globalParameters = @{};
        if (_globalParametersBlock) {
            _globalParameters = _globalParametersBlock() ?: @{};
        }else {
            _globalParameters = @{};
        }
    }
    return _globalParameters;
}

- (NSDictionary *)customErrorStatusCode {
    if (!_customErrorStatusCode) {
        _customErrorStatusCode = @{};
    }
    return _customErrorStatusCode;
}

- (NSNumber *)noNetworkStatusCode {
    if (!_noNetworkStatusCode) {
        _noNetworkStatusCode = @9999;
    }
    return _noNetworkStatusCode;
}

- (NSString *)signKeyName {
    if (!_signKeyName) {
        _signKeyName = @"sign";
    }
    return _signKeyName;
}

- (NSDictionary *)noSignAPI {
    if (!_noSignAPI) {
        _noSignAPI = @{};
    }
    return _noSignAPI;
}

- (NSDictionary *)responseFormat {
    if (!_responseFormat) {
        _responseFormat = @{
                            JsenNetworkingResponseDataKey:JsenNetworkingResponseDataKey,
                            JsenNetworkingResponseStatusCodeKey:JsenNetworkingResponseStatusCodeKey,
                            JsenNetworkingResponseMessageKey:JsenNetworkingResponseMessageKey,
                            JsenNetworkingResponseTimelineKey:JsenNetworkingResponseTimelineKey,
                            };
    }
    return _responseFormat;
}

- (NSArray<NSString *> *)customSuccessDataAllKeys {
    if (!_customSuccessDataAllKeys) {
        _customSuccessDataAllKeys = @[JsenNetworkingResponseDataKeyDefine];
    }
    return _customSuccessDataAllKeys;
}

- (NSTimeInterval)defaultTimeoutInterval {
    if (!_defaultTimeoutInterval) {
        return JsenNetworkingDefaultTimeOutInterval;
    }
    return _defaultTimeoutInterval;
}


- (NSNumber *)customSuccessStatusCode {
    if (!_customSuccessStatusCode) {
        _customSuccessStatusCode = @0;
    }
    return _customSuccessStatusCode;
}

@end
