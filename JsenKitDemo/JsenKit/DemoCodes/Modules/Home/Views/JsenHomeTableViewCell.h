//
//  JsenHomeTableViewCell.h
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsenHomeCellModel.h"

@interface JsenHomeTableViewCell : UITableViewCell

+ (JsenHomeTableViewCell *_Nullable)dequeueReusableCellWithTableView:(nonnull UITableView *)tableView
                                                 identifier:(nonnull NSString *)identifier
                                               forIndexPath:(nonnull NSIndexPath *)indexPath
                                                               model:(JsenHomeCellModel *_Nullable)model;
@end
