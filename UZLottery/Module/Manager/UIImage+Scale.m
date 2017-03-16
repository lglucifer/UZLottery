//
//  UIImage+Scale.m
//  AForm
//
//  Created by Xiaoyu Liu on 16/9/19.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

+ (UIImage *)scaleImage:(UIImage *)image
                   size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)scaleImageScreenWidth {
    CGFloat h = self.size.height;
    CGFloat w = self.size.width;
    CGFloat scale = h/w;
    CGFloat uw = [UIScreen mainScreen].bounds.size.width - 30;
    CGFloat uh = uw * scale;
    return [UIImage scaleImage:self size:CGSizeMake(uw, uh)];
}

- (UIImage *)scaleImageMaxWidth1200 {
    CGFloat h = self.size.height;
    CGFloat w = self.size.width;
    CGFloat scale = h/w;
    CGFloat uw = 1200.f;
    CGFloat uh = uw * scale;
    return [UIImage scaleImage:self size:CGSizeMake(uw, uh)];
}

- (UIImage *)scaleImageMaxWidth:(CGFloat)width {
    CGFloat h = self.size.height;
    CGFloat w = self.size.width;
    CGFloat scale = h/w;
    CGFloat uw = width;
    CGFloat uh = uw * scale;
    return [UIImage scaleImage:self size:CGSizeMake(uw, uh)];
}

@end
