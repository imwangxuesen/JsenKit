//
//  JsenDeviceMonitor.m
//  JsenKit
//
//  Created by WangXuesen on 2017/8/1.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenDeviceMonitor.h"

@implementation JsenDeviceMonitor

+ (void)jsn_deviceBatter:(JsenDeviceBatterInfo)info {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = device.batteryState;
    NSUInteger batterLevel = (NSUInteger)(device.batteryLevel * 100);
    info(batterLevel,state);
    device.batteryMonitoringEnabled = NO;
}

@end
