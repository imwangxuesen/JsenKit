//
//  JsenCacheTool.h
//  gaea
//
//  Created by WangXuesen on 2018/5/15.
//  Copyright © 2018年 ucredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsenCacheTool : NSObject

/**
 当前缓存容量

 @return 以M为单位的大小
 */
+ (NSString *)js_cacheCapacity:(NSSearchPathDirectory)searchPatch;

/**
 删除缓存 Library/Caches/

 @return 是否成功
 */
+ (BOOL)js_deleteCache:(NSSearchPathDirectory)searchPatch;

@end
