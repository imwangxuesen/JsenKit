//
//  JsenCacheTool.m
//  gaea
//
//  Created by WangXuesen on 2018/5/15.
//  Copyright © 2018年 ucredit. All rights reserved.
//

#import "JsenCacheTool.h"

@implementation JsenCacheTool

+ (NSString *)js_cacheCapacity:(NSSearchPathDirectory)searchPatch {
    NSUInteger size = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(searchPatch, NSUserDomainMask, YES) lastObject];
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [fileManager attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return [NSString stringWithFormat:@"%.2fM",(CGFloat)(size / 1024.0 / 1024.0)];
    
}

+ (BOOL)js_deleteCache:(NSSearchPathDirectory)searchPatch {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(searchPatch, NSUserDomainMask, YES) lastObject];
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        if (![fileManager removeItemAtPath:filePath error:nil]) {
            return NO;
        }
    }
    return YES;
}
@end
