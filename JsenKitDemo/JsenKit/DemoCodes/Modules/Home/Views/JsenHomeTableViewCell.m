//
//  JsenHomeTableViewCell.m
//  JsenKit
//
//  Created by WangXuesen on 2017/11/2.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenHomeTableViewCell.h"

@interface JsenHomeTableViewCell()

@property(nonatomic,strong) JsenHomeCellModel *model;
@property(nonatomic,strong) NSIndexPath *indexPath;

@end

@implementation JsenHomeTableViewCell

+ (JsenHomeTableViewCell *)dequeueReusableCellWithTableView:(nonnull UITableView *)tableView
                                                 identifier:(nonnull NSString *)identifier
                                               forIndexPath:(nonnull NSIndexPath *)indexPath
                                                      model:(JsenHomeCellModel *)model{
    JsenHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = model;
    return cell;
}

- (void)setModel:(JsenHomeCellModel *)model {
    _model = model;
    self.textLabel.text = _model.name;
    self.userInteractionEnabled = _model.enable;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end

