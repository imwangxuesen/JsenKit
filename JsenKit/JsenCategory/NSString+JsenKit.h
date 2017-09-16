//
//  NSString+JsenKit.h
//  JsenKit
//
//  Created by WangXuesen on 2017/7/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JsenKit)

/**
 md5 加密

 @return 加密后的字符串
 */
- (NSString *)jsen_md5;

/**
 转换为Base64编码

 @return 编码后的字符串
 */
- (NSString *)jsen_base64EncodedString;

/**
 将Base64编码还原

 @return 还原后的字符串
 */
- (NSString *)jsen_base64DecodedString;

@end
