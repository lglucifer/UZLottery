//
//  MBProgressHUD+CustomView.m
//  ShunWangYuQing
//
//  Created by Xiaoyu Liu on 16/8/4.
//  Copyright © 2016年 www.e23.cn. All rights reserved.
//

#import "MBProgressHUD+CustomView.h"
#import <objc/runtime.h>

static const char * const kHUDCustomSuccessViewKey = "kHUDCustomSuccessViewKey";
static const char * const kHUDCustomErrorViewKey = "kHUDCustomErrorViewKey";

@implementation MBProgressHUD (CustomView)

- (void)setSuccessImageView:(UIImageView *)successImageView {
    objc_setAssociatedObject(self, kHUDCustomSuccessViewKey, successImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)successImageView {
    UIImageView *_successImageView = objc_getAssociatedObject(self, kHUDCustomSuccessViewKey);
    if (_successImageView == nil || ![_successImageView isKindOfClass:[UIImageView class]]) {
        _successImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success"]];
        objc_setAssociatedObject(self, kHUDCustomSuccessViewKey, _successImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _successImageView;
}
- (void)setErrorImageView:(UIImageView *)errorImageView {
    objc_setAssociatedObject(self, kHUDCustomErrorViewKey, errorImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)errorImageView {
    UIImageView *_errorImageView = objc_getAssociatedObject(self, kHUDCustomErrorViewKey);
    if (_errorImageView == nil || ![_errorImageView isKindOfClass:[UIImageView class]]) {
        _errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_error"]];
        objc_setAssociatedObject(self, kHUDCustomErrorViewKey, _errorImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _errorImageView;
}

@end
