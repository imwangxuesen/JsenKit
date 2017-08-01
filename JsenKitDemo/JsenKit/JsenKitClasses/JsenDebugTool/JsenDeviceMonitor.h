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

@interface JsenDeviceMonitor : NSObject

+ (void)jsn_deviceBatter:(JsenDeviceBatterInfo)info;

@end
