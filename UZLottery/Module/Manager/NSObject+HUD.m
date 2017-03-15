//
//  NSObject+HUD.m
//  ShunWangYuQing
//
//  Created by Xiaoyu Liu on 16/8/4.
//  Copyright © 2016年 www.e23.cn. All rights reserved.
//

#import "NSObject+HUD.h"
#import <objc/runtime.h>

static const char * const kHUDInViewControllerKey = "kHUDInViewControllerKey";

@implementation NSObject (HUD)

- (void)showTitle:(NSString *)title
          message:(NSString *)message
          hudMode:(MBProgressHUDMode)hudMode
       customMode:(MBProgressHUDCustomMode)customMode
           inView:(UIView *)view
    excutingBlock:(void (^)(void))excutingBlock
         autoHide:(BOOL)autoHide
       afterDelay:(BOOL)afterDelay {
    MBProgressHUD *hud = objc_getAssociatedObject(self, kHUDInViewControllerKey);
    if (hud == nil || ![hud isKindOfClass:[MBProgressHUD class]]) {
        hud =  [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
        objc_setAssociatedObject(self, kHUDInViewControllerKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
//    hud.label.textColor = [UIColor colorWithRGB:0x333333];
    hud.label.text = title;
    hud.detailsLabel.text = message;
//    hud.detailsLabel.textColor = [UIColor colorWithRGB:0x333333];
    hud.mode = hudMode;
    if (hud.mode == MBProgressHUDModeCustomView) {
        switch (customMode) {
            case MBProgressHUDCustomMode_None:
                break;
            case MBProgressHUDCustomMode_Success:
                hud.customView = hud.successImageView;
                break;
            case MBProgressHUDCustomMode_Error:
                hud.customView = hud.errorImageView;
                break;
            default:
                break;
        }
    }
    [hud showAnimated:YES];
    if (excutingBlock) {
        __weak __typeof(self) weakSelf = self;
        dispatch_async(dispatch_queue_create(NULL, NULL), ^{
            excutingBlock();
            if (autoHide) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf hideWithAfterDelay:afterDelay];
                });
            }
        });
    } else {
        if (autoHide) {
            [self hideWithAfterDelay:afterDelay];
        }
    }
}

- (void)showTitle:(NSString *)title
           inView:(UIView *)view
         autoHide:(BOOL)autoHide {
    [self showTitle:title
            message:nil
            hudMode:MBProgressHUDModeText
         customMode:MBProgressHUDCustomMode_None
             inView:view
      excutingBlock:nil
           autoHide:autoHide
         afterDelay:YES];
}

- (void)showMessage:(NSString *)message
             inView:(UIView *)view
           autoHide:(BOOL)autoHide {
    [self showTitle:nil
            message:message
            hudMode:MBProgressHUDModeText
         customMode:MBProgressHUDCustomMode_None
             inView:view
      excutingBlock:nil
           autoHide:autoHide
         afterDelay:YES];
}

- (void)showTitle:(NSString *)title
          message:(NSString *)message
       customMode:(MBProgressHUDCustomMode)customMode
           inView:(UIView *)view
         autoHide:(BOOL)autoHide {
    [self showTitle:title
            message:message
            hudMode:MBProgressHUDModeCustomView
         customMode:customMode
             inView:view
      excutingBlock:nil
           autoHide:autoHide
         afterDelay:YES];
}

- (void)hideWithAfterDelay:(BOOL)afterDelay {
    MBProgressHUD *hud = objc_getAssociatedObject(self, kHUDInViewControllerKey);
    if (hud && [hud isKindOfClass:[MBProgressHUD class]]) {
        if (afterDelay) {
            NSInteger length = hud.detailsLabel.text.length + hud.label.text.length;
            NSTimeInterval timeInterval = ceil(length / 6) + .5f;
            if (timeInterval < 1.f) {
                timeInterval = 1.f;
            } else if (timeInterval > 2.f) {
                timeInterval = 2.f;
            }
            [hud hideAnimated:YES afterDelay:timeInterval];
        } else {
            [hud hideAnimated:YES];
        }
    }
}

- (void)showOnlyTitle:(NSString *)title inView:(UIView *)view {
    [self showTitle:title
            message:nil
            hudMode:MBProgressHUDModeText
         customMode:MBProgressHUDCustomMode_None
             inView:view
      excutingBlock:nil
           autoHide:YES
         afterDelay:YES];
}

- (void)showActivityIndicatorTitle:(NSString *)title
                            inView:(UIView *)view {
    [self showTitle:title
            message:nil
            hudMode:MBProgressHUDModeIndeterminate
         customMode:MBProgressHUDCustomMode_None
             inView:view
      excutingBlock:nil
           autoHide:NO
         afterDelay:YES];
}

- (void)showSuccessTitle:(NSString *)title inView:(UIView *)view {
    [self showTitle:title
            message:nil
         customMode:MBProgressHUDCustomMode_Success
             inView:view
           autoHide:YES];
}

- (void)showErrorTitle:(NSString *)title inView:(UIView *)view {
    [self showTitle:title
            message:nil
         customMode:MBProgressHUDCustomMode_Error
             inView:view
           autoHide:YES];
}

@end
