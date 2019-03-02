//
//  JsenNetworkingSuccessResponse.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/14.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenNetworkingSuccessResponse.h"
#import "JsenNetworkingConfig.h"
#import "YYModel.h"

@implementation JsenNetworkingSuccessResponse

+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject apiKey:(NSString *)apiKey {
    JsenNetworkingSuccessResponse *response = [[JsenNetworkingSuccessResponse alloc] init];
    response.responseObject = responseObject;
    [response modelWithResponseObject:responseObject apiKey:apiKey];
    return response;
}

+ (instancetype)downloadSuccesResponsesWithResponse:(NSURLResponse *)response filePath:(NSURL *)filePath {
    JsenNetworkingSuccessResponse *downloadResponse = [[JsenNetworkingSuccessResponse alloc] init];
    downloadResponse.urlResponse = response;
    downloadResponse.filePath = filePath;
    return downloadResponse;
}

- (JsenNetworkingSuccessResponse *)modelWithResponseObject:(NSDictionary *)object apiKey:(NSString *)apiKey {
    if (object && apiKey && [[JsenNetworkingConfig shareConfig] modelClassWithAPIKey:apiKey]) {
        
        Class class = [[JsenNetworkingConfig shareConfig] modelClassWithAPIKey:apiKey];
        id json = object[JsenNetworkingResponseDataKeyDefine];
        json = json == nil ? object : json;
        if (json && class != nil) {
            if ([json isKindOfClass:[NSDictionary class]]) {
                self.data = [class yy_modelWithJSON:json];
            } else if([object[JsenNetworkingResponseDataKeyDefine] isKindOfClass:[NSArray class]]) {
                self.data = [NSArray yy_modelArrayWithClass:class json:json];
            } else {
                self.data = json;
            }
        } else {
            self.data = nil;
        }
        
        [self configMessageAndTimestampAndCodeWithObject:object];
        
    } else if(object && apiKey && [[JsenNetworkingConfig shareConfig] modelClassWithAPIKey:apiKey] ==nil) {
        self.data = nil;
        [self configMessageAndTimestampAndCodeWithObject:object];
        
    }
    return self;
}


- (void)configMessageAndTimestampAndCodeWithObject:(NSDictionary *)object {
    if (object[JsenNetworkingResponseMessageKeyDefine]) {
        
        self.message = object[JsenNetworkingResponseMessageKeyDefine];
    } else {
        self.message = @"unkwon message";
    }
    
    if (object[JsenNetworkingResponseTimelineKeyDefine]) {
        self.timestamp = object[JsenNetworkingResponseTimelineKeyDefine];
    }
    
    if (object[JsenNetworkingResponseStatusCodeKeyDefine]) {
        self.code = object[JsenNetworkingResponseStatusCodeKeyDefine];
    }
}


@end
