//
//  JsenDeviceMonitor.h
//  JsenKit
//
//  Created by WangXuesen on 2017/8/1.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^JsenDeviceBatterInfo) (NSUInteger batterLevel, UIDeviceBatteryState state);
typedef void(^JsenDeviceCPUsage) (float sage);

@interface JsenDeviceMonitor : NSObject

/**
 设备电量

 @param info 电量回调block
 */
+ (void)jsen_deviceBatter:(JsenDeviceBatterInfo)info;

/**
 cpu使用率

 @param sage 使用率回调block
 */
+ (void)jsen_deviceCPUsage:(JsenDeviceCPUsage)sage;

/**
 可用内存

 @return 当前可用内存（MB）
 */
+ (double)jsen_availableMemory;

/**
 当前占用的内存

 @return 当前占用的内存（MB）
 */
+ (double)jsen_usedMemory;

@end
