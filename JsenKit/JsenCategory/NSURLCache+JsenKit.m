//
//  NSURLCache+JsenKit.m
//  gaea
//
//  Created by WangXuesen on 2018/4/27.
//  Copyright © 2018年 ucredit. All rights reserved.
//

#import "NSURLCache+JsenKit.h"

#ifndef NSFoundationVersionNumber_iOS_9_0
#import <WebKit/WebKit.h>
#endif

@implementation NSURLCache (JsenKit)

+ (void)removeCookieCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //清除cookies
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
#ifndef NSFoundationVersionNumber_iOS_9_0

    NSArray * types =@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache]; // 9.0之后才有的
    NSSet *websiteDataTypes = [NSSet setWithArray:types];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore]removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
    
#endif
}

@end
