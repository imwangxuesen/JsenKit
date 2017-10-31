//
//  NSObject+JsenKit.h
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JsenKit)

/**
 判空
 
 @return bool
 */
+ (BOOL)isValueEmpty:(id)value;

/**
 json object to string
 
 @param jsonObject array/dictionary 等
 @return 去除空格和换行符的字符串
 */
+ (NSString *)jsonObjectToString:(id)jsonObject;

/**
 json string to object
 
 @param jsonString json string
 @return array/dictionary
 */
+ (id)jsonStringToObject:(NSString *)jsonString;


@end
