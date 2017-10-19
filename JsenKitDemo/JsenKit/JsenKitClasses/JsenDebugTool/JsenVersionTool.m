//
//  JsenVersionTool.m
//  JsenKit
//
//  Created by WangXuesen on 2017/10/19.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenVersionTool.h"

@implementation JsenVersionTool

+ (NSString *)appCurVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

@end
