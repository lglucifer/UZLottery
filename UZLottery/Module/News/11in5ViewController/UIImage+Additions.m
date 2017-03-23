//
//  UIImageView+Additions.m
//  ShopManager-iOS
//
//  Created by liwei on 15/5/21.
//  Copyright (c) 2015年 liwei. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage(Additions)

// 图片缩放 压缩图片
+ (UIImage *)scaleImage:(UIImage *)image  size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//二维码图片合并
+ (UIImage *)drawQRCodeImage:(UIImage *)qrcodeImage
{
    UIGraphicsBeginImageContextWithOptions(qrcodeImage.size, NO, 2.f);
    [qrcodeImage drawInRect:CGRectMake(0, 0, qrcodeImage.size.width, qrcodeImage.size.height)];
    
    UIImage *logoImage = [UIImage imageNamed:@"qrcode_logo"];
    [logoImage drawInRect:CGRectMake((qrcodeImage.size.width-40.f)/2, (qrcodeImage.size.height-40.f)/2, 40.f, 40.f)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
