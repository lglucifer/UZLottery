//
//  APPFaceSharingView.m
//  CSLCPlay
//
//  Created by liwei on 15/11/17.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "APPFaceSharingView.h"
#import "QRCodeGenerator.h"
#import "UIImage+Additions.h"


@implementation APPFaceSharingView

- (id)initWithTitle:(NSString *)title qrcodeImage:(UIImage *)qrcodeImage
{
    self = [super init];
    if (self) {
        self.frame = [[UIScreen mainScreen] bounds];
        self.alpha = 0.f;
        
        win =  [[UIApplication sharedApplication] keyWindow];
        [win addSubview:self];
        
        qrcodeStr = @"";
        
        titleText = title;
        qrImage = qrcodeImage;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title qrcodeImage:(UIImage *)qrcodeImage qrcodeImageStr:(NSString *)qrcodeImageStr Desc:(NSString *)desc
{
    self = [super init];
    if (self) {
        self.frame = [[UIScreen mainScreen] bounds];
        self.alpha = 0.f;
        
        
        win =  [[UIApplication sharedApplication] keyWindow];
        [win addSubview:self];
        
        titleText = title;
        if (qrcodeImage) {
            qrImage = qrcodeImage;
        }
        if (desc) {
            descStr = desc;
        }
        if (qrcodeImageStr) {
            qrcodeStr = qrcodeImageStr;
        }

        
    }
    return self;
}

//显示
- (void)show
{
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = self.bounds;
    bgButton.backgroundColor = [UIColor blackColor];
    bgButton.alpha = 0.8;
    [bgButton addTarget:self action:@selector(hiddenViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgButton];
    

    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(50, (kScreenHeight-(kScreenWidth-100))/2, kScreenWidth-100, kScreenWidth-100)];
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.layer.cornerRadius = 5.f;
    [self addSubview:shareView];

    
    //---金额
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 5.f, shareView.frame.size.width, 50.f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    titleLabel.text = titleText;
    [shareView addSubview:titleLabel];
    
    //---分享图片
    CGFloat padding = 40.f;
    CGSize imgSize = CGSizeMake(shareView.frame.size.width - padding * 2, shareView.frame.size.width - padding * 2);
    
   
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(titleLabel.frame)-10.f, imgSize.width, imgSize.height)];
    
    imageView.backgroundColor = [UIColor clearColor];
//    imageView.layer.borderWidth = 1.f;
//    imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [shareView addSubview:imageView];
    
    if (qrcodeStr) {
        QRCodeGenerator *qrcode = [[QRCodeGenerator alloc] init];
        UIImage *image = [qrcode qrImageForString:[qrcodeStr cStringUsingEncoding:NSUTF8StringEncoding] inputLength:0 imageSize:imgSize.width];
        imageView.image = [UIImage drawQRCodeImage:image];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSNumber *widthNum = [userDefaults objectForKey:@"bet_qr_code_display_width"];
        NSNumber *heightNum = [userDefaults objectForKey:@"bet_qr_code_display_height"];
        
        CGFloat ivWidth = [widthNum floatValue];
        CGFloat ivHeight = [heightNum floatValue];
        
        
        viewWidth = imgSize.width;
        viewHeight = imgSize.height;
        
        CGRect ivFrame = CGRectZero;
        if (ivWidth !=0 && ivHeight != 0) {
            if (ivWidth>viewWidth || ivHeight>viewHeight) {
                ivWidth = viewWidth;
                ivHeight = viewHeight;
            }
            ivFrame = CGRectMake(padding+(viewWidth-ivWidth)/2, CGRectGetMaxY(titleLabel.frame)-10.f+(viewHeight-ivHeight)/2, ivWidth, ivHeight);
        }else {
            ivFrame = CGRectMake(padding, CGRectGetMaxY(titleLabel.frame)-10.f, viewWidth, viewHeight);
        }
        
        originX = padding;
        originY = CGRectGetMaxY(titleLabel.frame)-10.f;
        
        [imageView setFrame:ivFrame];
        
        imageView.userInteractionEnabled = YES;
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(imageViewPinchAction:)];
        [imageView addGestureRecognizer:pinch];

    }
    
    if(descStr)
    {

        [shareView setFrame:CGRectMake(50, (kScreenHeight-((kScreenWidth-100)*1.5))/2, kScreenWidth-100, (kScreenWidth-100)*1.5)];
        
 
//        UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [shareBtn setFrame:CGRectMake(CGRectGetWidth(shareView.frame)-10-50, 17, 50, 25)];
//        shareBtn.backgroundColor = [UIColor clearColor];
//        shareBtn.layer.cornerRadius = 4;
//        shareBtn.layer.borderColor = [[UIColor colorRGBWithRed:150 green:150 blue:150 alpha:1] CGColor];
//        shareBtn.layer.borderWidth = 1;
//        shareBtn.layer.masksToBounds = YES;
//        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
//        [shareBtn setTitleColor:[UIColor colorRGBWithRed:100 green:100 blue:100 alpha:1] forState:UIControlStateNormal];
//        shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [shareView addSubview:shareBtn];
//        [shareBtn addTarget:self action:@selector(shareViewShow) forControlEvents:UIControlEventTouchUpInside];

        
        
        UITextView *descL = [[UITextView alloc] initWithFrame:CGRectMake(10.f, CGRectGetMaxY(imageView.frame)+5, shareView.frame.size.width-20, shareView.frame.size.height-(CGRectGetMaxY(imageView.frame)+5)-10)];
        descL.backgroundColor = [UIColor clearColor];
        descL.textColor = RGBCOLOR(100, 100, 100, 1);
        descL.font = [UIFont boldSystemFontOfSize:14.f];
        descL.text = descStr;
        [shareView addSubview:descL];
        descL.editable = NO;
    }
    
    
   
    
    
//    CGFloat btnWidth = imgSize.width - 50.f;
//    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    closeButton.frame = CGRectMake((shareView.frame.size.width - btnWidth)/2, shareView.frame.size.height - 60.f, btnWidth, 34.f);
//    closeButton.backgroundColor = [UIColor clearColor];
//    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
//    [closeButton setTitleColor:[UIColor colorRGBWithRed:163.f green:199.f blue:255.f alpha:1.f] forState:UIControlStateNormal];
//    closeButton.layer.cornerRadius = 4.f;
//    closeButton.layer.borderColor = [[UIColor colorRGBWithRed:163.f green:199.f blue:255.f alpha:1.f] CGColor];
//    closeButton.layer.borderWidth = 1.f;
//    [closeButton addTarget:self action:@selector(hiddenViewAction) forControlEvents:UIControlEventTouchUpInside];
//    [shareView addSubview:closeButton];
   
    //--
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.f;
    }];
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
    
    CGRect rect = imageView.frame;
    rect.size.width = tempWith;
    rect.size.height = tempHeight;
    rect.origin.x = originY+(viewWidth-tempWith)/2;
    rect.origin.y = originY + (viewHeight-tempHeight)/2;
    
    imageView.frame = rect;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(tempWith) forKey:@"bet_qr_code_display_width"];
    [userDefaults setObject:@(tempHeight) forKey:@"bet_qr_code_display_height"];
}


- (void)hiddenViewAction
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
