//
//  UITextField+JsenKit.m
//  JsenKit
//
//  Created by WangXuesen on 2017/10/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "UITextField+JsenKit.h"

@implementation UITextField (JsenKit)

- (void)js_configInputTextField:(NSString *)placeholder color:(UIColor *)color fontSize:(int)fontSize{
    self.font = [UIFont systemFontOfSize:fontSize];
    self.textColor = [UIColor whiteColor];
    self.clearsOnBeginEditing = YES;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.attributedPlaceholder = [[NSAttributedString alloc ]initWithString:placeholder attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];
    self.tintColor = [UIColor whiteColor];
}
@end
