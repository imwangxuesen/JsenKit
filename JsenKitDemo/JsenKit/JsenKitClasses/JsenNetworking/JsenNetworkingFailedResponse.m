//
//  JsenNetworkingFailedResponse.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/14.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenNetworkingFailedResponse.h"
#import "JsenNetworkingConfig.h"

@implementation JsenNetworkingFailedResponse

- (NSString *)message {
    if (_message) {
        return _message;
    }
    
    if (_userInfo) {
        return _userInfo[NSLocalizedDescriptionKey];
    }
    
    return @"unkwon error";
}

- (void)setCode:(NSNumber *)code {
    _code = code;
    if(_code.intValue == -1001) {
        _message = @"请求超时";
    }
}

+ (instancetype)responseWithError:(NSError *)error {
    JsenNetworkingFailedResponse *response = [[JsenNetworkingFailedResponse alloc] init];
    response.userInfo = error.userInfo;
    response.code = @(error.code);
    return response;
}

+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject {
    JsenNetworkingFailedResponse *response  = [[JsenNetworkingFailedResponse alloc] init];
    response.userInfo = nil;
    NSNumber *code = responseObject[JsenNetworkingResponseStatusCodeKeyDefine];
    if (code) {
        response.code = code;
    }
    
    NSString *message = responseObject[JsenNetworkingResponseMessageKeyDefine];
    if (message) {
        response.message = message;
    } else {
        response.message = [JsenNetworkingConfig shareConfig].customErrorStatusCode[code];
    }
    
    return response;
}
@end
