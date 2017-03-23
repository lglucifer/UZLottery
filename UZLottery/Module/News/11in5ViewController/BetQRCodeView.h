//
//  BetQRCodeView.h
//  CSLCPlay
//
//  Created by liwei on 16/9/13.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetQRCodeView : UIView
{
    CGFloat viewWidth;
    CGFloat viewHeight;
    UIImageView *qrImageView;
}

+ (BetQRCodeView *)shareInstance;

- (id)initWithFrame:(CGRect)frame;
- (UIImage *)getBetQRCodeImage:(const char *)string imageSize:(CGFloat)size;
- (void)setupQRImageView:(UIImage *)qrImage;

//二维码使用说明
- (void)qrcodeHelpImage;

@end
