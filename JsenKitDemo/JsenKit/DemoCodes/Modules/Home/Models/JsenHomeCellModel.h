//
//  JsenHomeCellModel.h
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsenHomeCellModel : NSObject

@property(nonatomic,copy) NSString *name;

@property(nonatomic,assign) BOOL enable;

@property(nonatomic,assign) BOOL showPoint;

+ (instancetype)setupModelWithName:(NSString *)name enable:(BOOL)enable showPoint:(BOOL)show;

@end
