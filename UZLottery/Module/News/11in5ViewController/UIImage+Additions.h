//
//  UIImageView+Additions.h
//  ShopManager-iOS
//
//  Created by liwei on 15/5/21.
//  Copyright (c) 2015年 liwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(Additions)

+ (UIImage *)scaleImage:(UIImage *)image  size:(CGSize)size;
+ (UIImage *)drawQRCodeImage:(UIImage *)qrcodeImage;

@end
