//
//  NSString+JsenKit.m
//  JsenKit
//
//  Created by WangXuesen on 2017/7/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "NSString+JsenKit.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSString (JsenKit)

- (NSString *)jen_md5 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    const void *str = [data bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)data.length, result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash lowercaseString];
}

- (NSString *)jsen_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)jsen_base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


@end
