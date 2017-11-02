//
//  JsenHomeCellModel.m
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenHomeCellModel.h"

@implementation JsenHomeCellModel

+ (instancetype)setupModelWithName:(NSString *)name enable:(BOOL)enable showPoint:(BOOL)show {
    JsenHomeCellModel *model = [[JsenHomeCellModel alloc] init];
    model.name = name;
    model.enable = enable;
    model.showPoint = show;
    return model;
}
@end
