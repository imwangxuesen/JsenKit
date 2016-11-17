
//
//  BannerModel.m
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/15.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"iD" : @"id",
             };
}

@end

@implementation BannerModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"footer" : [BannerItemModel class],
             @"header" : [BannerItemModel class],
             };
}

@end
