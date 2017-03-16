//
//  UIImage+Scale.h
//  AForm
//
//  Created by Xiaoyu Liu on 16/9/19.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

+ (UIImage *)scaleImage:(UIImage *)image
                   size:(CGSize)size;

- (UIImage *)scaleImageMaxWidth1200;

- (UIImage *)scaleImageScreenWidth;

- (UIImage *)scaleImageMaxWidth:(CGFloat)width;

@end
