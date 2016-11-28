//
//  JsenNetworkingManagerTransmit.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/16.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenNetworkingManagerTransmit.h"
@interface JsenNetworkingManagerTransmit()

@end

@implementation JsenNetworkingManagerTransmit

+ (instancetype)shareTransmit {
    static dispatch_once_t onceToken;
    static JsenNetworkingManagerTransmit *transmit = nil;
    dispatch_once(&onceToken, ^{
        transmit = [[JsenNetworkingManagerTransmit alloc] init];
    });
    return transmit;
}

- (void)jsenNetworkingSuccess:(JsenNetworkingSuccessResponse *)successResponse api:(NSString *)api {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingSuccess:api:)]) {
        [self.delegate jsenNetworkingSuccess:successResponse api:api];
    }
}

- (void)jsenNetworkingFailed:(JsenNetworkingFailedResponse *)failedResponse api:(NSString *)api {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingCustomErrorFailed:api:)]) {
        [self.delegate jsenNetworkingFailed:failedResponse api:api];
    }
}

- (void)jsenNetworkingCustomErrorFailed:(JsenNetworkingFailedResponse *)failedResponse api:(NSString *)api {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingCustomErrorFailed:api:)]) {
        [self.delegate jsenNetworkingCustomErrorFailed:failedResponse api:api];
    }
}

- (void)jsenNetworkingProgress:(NSProgress *)progress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingProgress:)]) {
        [self.delegate jsenNetworkingProgress:progress];
    }
}

- (void)jsenNetworkingFinished:(NSString *)api {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingFinished:)]) {
        [self.delegate jsenNetworkingFinished:api];
    }
}



@end
