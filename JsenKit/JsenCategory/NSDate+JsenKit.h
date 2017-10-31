//
//  NSDate+JsenKit.h
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JsenKit)

/**
 eg：
 1分钟前
 1小时前
 1天前
 1998年8月 08：08

 @return 格式化时间距离
 */
- (NSString *)formatTime;

/**
 eg：
 2017.10.31 星期二

 @return 格式化时间
 */
- (NSString *)formatTimeWithWeekdays;

/**
 eg：
 2017-10-31

 @return 格式化时间
 */
- (NSString *)formatTimeYMD;

/**
 eg:
 2017-10-31 08:08:09

 @return 格式化时间
 */
- (NSString *)formatTimeYMDHMS;

/**
 eg:
 2017-10-31 08:08
 
 @return 格式化时间
 */
- (NSString *)formatTimeYMDHM;

/**
 eg:
 10-31
 
 @return 格式化时间
 */
- (NSString *)formatTimeMD;

/**
 eg：
 if 三分钟内 return 刚刚
 else if 当天 return HH：mm
 else return M-D HH：mm

 @return 格式化时间
 */
- (NSString *)formatTimeTimeLine;

/**
 距离今天有多少天
 如果是今天返回 “到期”

 @return X天
 */
- (NSString *)formatRemainingTime;
@end
