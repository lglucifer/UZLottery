//
//  APPFaceSharingView.h
//  CSLCPlay
//
//  Created by liwei on 15/11/17.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPFaceSharingView : UIView
{
    UIWindow *win;
    NSString *titleText;
    UIImage *qrImage;
    NSString * descStr;
    
    NSString * qrcodeStr;
    
    float viewWidth;
    float viewHeight;
    
    UIImageView *imageView;
    
    float originX;
    float originY;
    
}


- (id)initWithTitle:(NSString *)title qrcodeImage:(UIImage *)qrcodeImage;

- (id)initWithTitle:(NSString *)title qrcodeImage:(UIImage *)qrcodeImage qrcodeImageStr:(NSString *)qrcodeImageStr Desc:(NSString *)desc;


/**显示*/
- (void)show;

@end
