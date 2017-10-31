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


/**
 去两头空格
 
 @return 去除之后的字符串
 */
- (NSString *)js_whitespace;

/**
 去全部空格
 
 @return 去除之后的字符串
 */
- (NSString *)js_whiteAllSpace;

/**
 *  判断身份证号的正确
 *
 *  @param cardNo 身份证号
 *
 *  @return yes or no
 */
+(BOOL)js_checkIdentityCardNo:(NSString*)cardNo;

/**
 *  判断是否符合邮箱格式
 *
 *  @param email 需要检测的字符串
 *
 *  @return yes是email no不符合邮箱格式
 */
+ (BOOL)js_doCheckEmailFormat:(NSString *)email;

/**
 *  判断是否符合手机号码格式
 *
 *  @param phoneNumber 需要检测的字符串
 *
 *  @return yes符合手机号码格式  no不符合格式
 */
+ (BOOL)js_doCheckMobilePhoneNumber:(NSString *)phoneNumber;


/**
 *  判断输入密码是否符合位数要求
 *
 *  @param password 密码
 *
 *  @return bool
 */
+ (BOOL)js_doCheckPasswordBit:(NSString *)password;

/**
 *  判断输入验证码是否符合位数要求
 *
 *  @param validateCode 短信验证码
 *
 *  @return yes or no
 */
+ (BOOL)js_doCheckValidateCodeBit:(NSString *)validateCode;

//中英文 字符数
- (int)js_charNumber;

/**
 url 格式化编码
 
 @return url
 */
- (NSString *)js_urlencode;

/**
 是否是url
 
 @return yes or no
 */
- (BOOL)js_isUrl;


// 手机号加密 133****3333
- (NSString *)js_encryptPhone;


@end
