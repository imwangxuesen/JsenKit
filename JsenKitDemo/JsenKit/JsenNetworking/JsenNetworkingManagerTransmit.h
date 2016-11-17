//
//  JsenNetworkingManagerTransmit.h
//  JsenKit
//
//  Created by Wangxuesen on 2016/11/16.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsenNetworkingManagerTransmitDelegate.h"


@interface JsenNetworkingManagerTransmit : NSObject<JsenNetworkingManagerTransmitDelegate>

@property (nonatomic, weak) id<JsenNetworkingManagerTransmitDelegate> delegate;

+ (instancetype)shareTransmit;

@end
