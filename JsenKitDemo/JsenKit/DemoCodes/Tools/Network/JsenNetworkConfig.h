//
//  JsenNetworkConfig.h
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
//首页列表url
extern NSString *const Jsen_HomeList_API;


//token过期code
extern NSString *const Jsen_Notification_Error_Code;


@interface JsenNetworkConfig : NSObject

+ (void)config;

@end
