//
//  NSObject+JsenKit.m
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "NSObject+JsenKit.h"


@implementation NSObject (JsenKit)

/*
 * Functionality: check NSString, NSArray, NSDictionary is empty or not
 * @"", [], {}, are empty objects
 */
+ (BOOL)isValueEmpty:(id)value
{
    BOOL checkResult = NO;
    if (!value) {
        checkResult = YES;
        return checkResult;
    }
    if ([value isKindOfClass:[NSString class]] && ([value isEqualToString:@""] || [value isEqualToString:@"<null>"])) {
        checkResult = YES;
    } else if (([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) && ![value count]) {
        checkResult = YES;
    } else if ([value isKindOfClass:[NSNull class]]) {
        checkResult = YES;
    }
    
    return checkResult;
}


+ (NSString *)jsonObjectToString:(id)jsonObject {
    NSMutableString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSMutableString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    [jsonString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, jsonString.length)];
    [jsonString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, jsonString.length)];
    
    return jsonString;
}

+ (id)jsonStringToObject:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
}
@end
