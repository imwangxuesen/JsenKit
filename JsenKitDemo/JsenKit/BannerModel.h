//
//  BannerModel.h
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/15.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BannerItemModel : NSObject

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, strong) NSNumber *enabled;
@property (nonatomic, strong) NSNumber *iD;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *redirectUrl;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *updateTime;

@end

@interface BannerModel : NSObject

@property (nonatomic, strong) NSArray *footer;
@property (nonatomic, strong) NSArray *header;

@end
