//
//  NSObject+HUD.h
//  ShunWangYuQing
//
//  Created by Xiaoyu Liu on 16/8/4.
//  Copyright © 2016年 www.e23.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+CustomView.h"

typedef NS_ENUM(NSUInteger, MBProgressHUDCustomMode) {
    MBProgressHUDCustomMode_None    = (0),
    MBProgressHUDCustomMode_Success = (1),
    MBProgressHUDCustomMode_Error   = (2)
};

@interface NSObject (HUD)

- (void)showTitle:(NSString *)title
          message:(NSString *)message
          hudMode:(MBProgressHUDMode)hudMode
       customMode:(MBProgressHUDCustomMode)customMode
           inView:(UIView *)view
    excutingBlock:(void(^)(void))excutingBlock
         autoHide:(BOOL)autoHide
       afterDelay:(BOOL)afterDelay;

- (void)showTitle:(NSString *)title
           inView:(UIView *)view
         autoHide:(BOOL)autoHide;

- (void)showMessage:(NSString *)message
             inView:(UIView *)view
           autoHide:(BOOL)autoHide;

- (void)showTitle:(NSString *)title
          message:(NSString *)message
       customMode:(MBProgressHUDCustomMode)customMode
           inView:(UIView *)view
         autoHide:(BOOL)autoHide;

- (void)hideWithAfterDelay:(BOOL)afterDelay;

- (void)showOnlyTitle:(NSString *)title
               inView:(UIView *)view;

- (void)showActivityIndicatorTitle:(NSString *)title
                            inView:(UIView *)view;

- (void)showSuccessTitle:(NSString *)title inView:(UIView *)view;

- (void)showErrorTitle:(NSString *)title inView:(UIView *)view;

@end
