//
//  BetQRCodeView.m
//  CSLCPlay
//
//  Created by liwei on 16/9/13.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import "BetQRCodeView.h"
#import "QRCodeGenerator.h"
#import "UIImage+Additions.h"

@implementation BetQRCodeView

+ (BetQRCodeView *)shareInstance
{
    static BetQRCodeView *qrCodeView;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        qrCodeView = [[BetQRCodeView alloc] init];
    });
    
    
    return qrCodeView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        
        viewWidth = self.frame.size.width;
        viewHeight = self.frame.size.height;

    }
    return self;
}


- (UIImage *)getBetQRCodeImage:(const char *)string imageSize:(CGFloat)size
{
    UIImage *image = nil;
    
    if (string != NULL || string != nil) {
        QRCodeGenerator *qrcode = [[QRCodeGenerator alloc] init];
        UIImage *qrImage = [qrcode qrImageForString:string inputLength:0 imageSize:size];
        
        //-- 合并图
        image = [UIImage drawQRCodeImage:qrImage];
    }
    
    return image;
}

- (void)setupQRImageView:(UIImage *)qrImage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *widthNum = [userDefaults objectForKey:@"bet_qr_code_display_width"];
    NSNumber *heightNum = [userDefaults objectForKey:@"bet_qr_code_display_height"];
    
    CGFloat ivWidth = [widthNum floatValue];
    CGFloat ivHeight = [heightNum floatValue];
    
    CGRect ivFrame = CGRectZero;
    if (ivWidth !=0 && ivHeight != 0) {
        ivFrame = CGRectMake((viewWidth-ivWidth)/2, (viewHeight-ivHeight)/2, ivWidth, ivHeight);
    }else {
        ivFrame = CGRectMake(0, 0, viewWidth, viewHeight);
    }
    
    if (qrImageView == nil) {
        qrImageView = [[UIImageView alloc] initWithFrame:ivFrame];
    }
    
    qrImageView.userInteractionEnabled = YES;
    qrImageView.backgroundColor = [UIColor whiteColor];
    [qrImageView layer].magnificationFilter = kCAFilterNearest;
    
    qrImageView.image = qrImage;
    
    [self addSubview:qrImageView];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(imageViewPinchAction:)];
    [qrImageView addGestureRecognizer:pinch];
}

- (void)imageViewPinchAction:(UIPinchGestureRecognizer *)gesture
{
    CGFloat factor = gesture.scale;
    CGFloat minValue = 120;
    
    CGFloat tempWith = factor * viewWidth;
    if (factor * viewWidth < minValue) {
        tempWith = minValue;
    }
    if (factor * viewWidth > viewWidth) {
        tempWith = viewWidth;
    }
    
    CGFloat tempHeight = factor * viewHeight;
    if (factor * viewHeight < minValue) {
        tempHeight = minValue;
    }
    if (factor * viewHeight > viewHeight) {
        tempHeight = viewHeight;
    }
    
    CGRect rect = qrImageView.frame;
    rect.size.width = tempWith;
    rect.size.height = tempHeight;
    rect.origin.x = (viewWidth - qrImageView.frame.size.width)/2;
    rect.origin.y = (viewHeight - qrImageView.frame.size.height)/2;
    
    qrImageView.frame = rect;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(tempWith) forKey:@"bet_qr_code_display_width"];
    [userDefaults setObject:@(tempHeight) forKey:@"bet_qr_code_display_height"];
}

#pragma mark - 二维码使用说明
- (void)qrcodeHelpImage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [userDefaults objectForKey:@"bet_qr_code_display_count"];
    NSInteger count = [number integerValue];
    
    if (count < 1) {
        count = 0;
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *bgView = [[UIView alloc] initWithFrame:window.bounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.85;
        bgView.userInteractionEnabled = YES;
        bgView.tag = 111111;
        [window addSubview:bgView];
        
        UIImage *helpImg = [UIImage imageNamed:@"bet_qrcode_help"];
        
        CGFloat imgWidth = helpImg.size.width;
        CGFloat imgHeight = helpImg.size.height;
        CGFloat imgX = (window.frame.size.width - imgWidth)/2;
        CGFloat imgY = (window.frame.size.height - imgHeight)/2;
        
        UIImageView *helpImgView = [[UIImageView alloc] initWithImage:helpImg];
        helpImgView.frame = CGRectZero;
        helpImgView.center = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
        helpImgView.backgroundColor = [UIColor clearColor];
        helpImgView.userInteractionEnabled = YES;
        [bgView addSubview:helpImgView];
        
        
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect imgViewRect = helpImgView.frame;
                             imgViewRect.origin.x = imgX;
                             imgViewRect.origin.y = imgY;
                             imgViewRect.size.width = imgWidth;
                             imgViewRect.size.height = imgHeight;
                             helpImgView.frame = imgViewRect;
                             
                         } completion:^(BOOL finished) {
                             
                         }];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeHelpImageViewAction:)];
        [bgView addGestureRecognizer:bgTap];
        
        UITapGestureRecognizer *imgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeHelpImageViewAction:)];
        [helpImgView addGestureRecognizer:imgViewTap];
    }
    
    [userDefaults setObject:@(count+1) forKey:@"bet_qr_code_display_count"];

}

- (void)removeHelpImageViewAction:(UITapGestureRecognizer *)ges
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (id obj in window.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)obj;
            if (view.tag == 111111) {
                [view removeFromSuperview];
            }
        }
    }
}

@end
