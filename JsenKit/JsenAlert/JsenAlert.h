//
//  JsenAlert.h
//  JsenKit
//
//  Created by WangXuesen on 2016/12/28.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsenAlertConfigManager.h"

/**
 define action back blocks
 
 when you clicked item button which on alertview, JsenAlert will be call this blocks to 
 post one paramter tell reserive which one be clicked
 
 @param index be clicked button index, from left to right ,from zero to more
 */
typedef void (^JsenAlertAction)(NSInteger index);

@interface JsenAlert : NSObject


/**
 show alert with config alert view attributes

 @param actionTitles button title
 @param title alert view title, ,if this attributes is nil, alert view will remove it's place.
 @param detailMessage detail message , it show in between title and action buttons ,if this attributes is nil,
     alert view will remove it's place.
 @param action when action buttons be clicked, touch event will call this blocks to tell coder that action button which one be clicked.
 */
+ (JsenAlert *)alertWithActionTitles:(NSArray *)actionTitles
                               title:(NSString *)title
                       detailMessage:(NSString *)detailMessage
                              action:(JsenAlertAction)action;

/**
 hiden alert view
 */
- (void)hiden;

/**
 show alert view. if current keyWindow exited one alert view. will hiden it. then show new one.
 */
- (void)show;

@end
