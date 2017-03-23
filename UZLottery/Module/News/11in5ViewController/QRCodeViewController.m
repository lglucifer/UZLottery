//
//  QRCodeViewController.m
//  CSLCPlay
//
//  Created by liwei on 15/9/12.
//  Copyright (c) 2015年 liwei. All rights reserved.
//
//  显示二维码
//

#import "QRCodeViewController.h"
//#import "QRCodeGenerator.h"
//#import "TicketInfoViewController.h"

#import "BetQRCodeView.h"

//#import "UserManager.h"
//#import "BetContentDao.h"
//#import "UIButton+Additions.h"
//#import "UIImage+Additions.h"
//#import "GameControlHelper.h"

//#import "MyCenterDao.h"
//#import "PayAlertView.h"
#import "SVProgressHUD.h"

static const CGFloat kPadding = 30.f;

@interface QRCodeViewController ()

//@property (nonatomic, strong) TicketInfoViewController *ticketInfoController;
@property (nonatomic, strong) UIView * couponbgView;
@property (nonatomic, strong) UILabel * couponLabel;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[BetQRCodeView shareInstance] qrcodeHelpImage];
    


    
    self.title = @"二维码";
    
    self.view.backgroundColor = [UIColor colorRGBWithRed:45.f green:49.f blue:50.f alpha:1.f];
    
    //UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(shareButtonAction)];
    //self.navigationItem.rightBarButtonItem = shareButton;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1.f)];
    topView.backgroundColor = [UIColor colorRGBWithRed:230.f green:155.f blue:175.f alpha:1.f];
    [self.view addSubview:topView];
    
    

    

    

    
    //    //调整屏幕亮度和防止休眠代码
    //    [[UIScreen mainScreen] setBrightness:0.6];
    //    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction:(UISwipeGestureRecognizer *)recognizer
{
    [self.navigationController popToViewController:_popController animated:YES];
}

- (void)backButtonAction
{
    [self.navigationController popToViewController:_popController animated:YES];
}

#pragma mark - 二维码
- (void)generateQREncoderString:(const char *)string ticketCnt:(NSString *)ticketCnt bet:(NSString *)bet totalMoney:(NSString *)totalMoney
{
    NSLog(@"result_char = %s", string);
    
    CGFloat qrcodeX = 20.f;
    CGFloat qrcodeY = 0;
    CGFloat qrcodeheight = 0;
    
    if (iPhone4 || is_iPad.location != NSNotFound) {
        qrcodeY = 35.f;
        qrcodeheight = kScreenHeight-qrcodeY-64.f-50.f;
    }else{
        qrcodeY = 48.f;
        qrcodeheight = kScreenHeight-qrcodeY-64.f-102.f;
    }
    UIView *qrcodeView = [[UIView alloc] initWithFrame:CGRectMake(qrcodeX, qrcodeY, kScreenWidth - qrcodeX*2, qrcodeheight)];
    qrcodeView.backgroundColor = [UIColor whiteColor];
    qrcodeView.layer.cornerRadius = 5.f;
    [self.view addSubview:qrcodeView];
    
    //---金额
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 10, qrcodeView.frame.size.width-10.f, 30.f)];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.textColor = [UIColor colorRGBWithRed:176.f green:37.f blue:51.f alpha:1.f];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.adjustsFontSizeToFitWidth = YES;
    moneyLabel.font = [UIFont boldSystemFontOfSize:22.f];
    moneyLabel.text = [NSString stringWithFormat:@"共 %@ 元", totalMoney];
    [qrcodeView addSubview:moneyLabel];
    
    NSRange mrange = [moneyLabel.text rangeOfString:totalMoney];
    if (mrange.location != NSNotFound) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:moneyLabel.text];
        [attrStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.f]} range:NSMakeRange(mrange.location, mrange.length)];
        moneyLabel.attributedText = attrStr;
    }
    
    //---
    CGFloat dh = 0;
    if (iPhone4 || is_iPad.location != NSNotFound) {
        dh = 46;
    }
    else{
        dh = 60;
    }
    UILabel *dianLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabel.frame.origin.x, CGRectGetMaxY(moneyLabel.frame), moneyLabel.frame.size.width, dh)];
    dianLabel.text = @"二维码责任彩票";
    dianLabel.backgroundColor = [UIColor clearColor];
    dianLabel.textColor = [UIColor redColor];
    dianLabel.textAlignment = NSTextAlignmentCenter;
    dianLabel.numberOfLines = 2;
    if (iPhone4 || is_iPad.location != NSNotFound) {
        dianLabel.font = [UIFont systemFontOfSize:12.f];
    }
    else{
       dianLabel.font = [UIFont systemFontOfSize:16.f];
    }
    [qrcodeView addSubview:dianLabel];
    
    //---二维码图片
    CGSize qrSize = CGSizeMake(qrcodeView.frame.size.width - kPadding * 2, qrcodeView.frame.size.width - kPadding * 2);
    CGRect qrFrame = CGRectMake(kPadding, CGRectGetMaxY(dianLabel.frame)-10.f, qrSize.width, qrSize.height);
    //UIImageView* imageView = [[UIImageView alloc] initWithFrame:qrFrame];
    
    BetQRCodeView *qrView = [[BetQRCodeView alloc] initWithFrame:qrFrame];
    //[qrView qrcodeHelpImage];
    if (string != NULL || string != nil) {
        UIImage *qrImg = [qrView getBetQRCodeImage:string imageSize:qrView.bounds.size.width];
        [qrView setupQRImageView:qrImg];
        [qrcodeView addSubview:qrView];
        [qrcodeView bringSubviewToFront:qrView];
        
        //        QRCodeGenerator *qrcode = [[QRCodeGenerator alloc] init];
        //        UIImage *qrImage = [qrcode qrImageForString:string inputLength:0 imageSize:imageView.bounds.size.width];
        //        imageView.userInteractionEnabled = YES;
        //        imageView.backgroundColor = [UIColor whiteColor];
        //        [imageView layer].magnificationFilter = kCAFilterNearest;
        //
        //        //-- 合并图
        //        imageView.image = [UIImage drawQRCodeImage:qrImage];
        //        [qrcodeView addSubview:imageView];
        //        [qrcodeView bringSubviewToFront:imageView];
        
    }
    
    
    //--注数 张数
    CGFloat ify = 0;
    if (iPhone4 || is_iPad.location != NSNotFound) {
        ify = CGRectGetMaxY(qrView.frame)-5.f;
    }
    else{
        ify = CGRectGetMaxY(qrView.frame)+5.f;
    }
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabel.frame.origin.x, ify, moneyLabel.frame.size.width, 20.f)];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textColor = [UIColor colorRGBWithRed:157.f green:157.f blue:157.f alpha:1.f];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.adjustsFontSizeToFitWidth = YES;
    if (iPhone4 || is_iPad.location != NSNotFound) {
        infoLabel.font = [UIFont systemFontOfSize:13.f];
    }
    else{
        infoLabel.font = [UIFont systemFontOfSize:18.f];
    }
    infoLabel.text = [NSString stringWithFormat:@"本次预计出票共%@张%@注",ticketCnt, bet];
    [qrcodeView addSubview:infoLabel];
    
    //---手机号
    NSString *account = @"15652291050";
    NSString *phone = @"";
    if ([account length] > 10) {
        NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:account];
        [mutableStr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        phone = [[NSString alloc] initWithString:mutableStr];
    }
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabel.frame.origin.x, CGRectGetMaxY(infoLabel.frame)+3.f, moneyLabel.frame.size.width, 16.f)];
    textLabel.text = phone;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor colorRGBWithRed:157.f green:157.f blue:157.f alpha:1.f];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.adjustsFontSizeToFitWidth = YES;
    if (iPhone4 || is_iPad.location != NSNotFound) {
        textLabel.font = [UIFont systemFontOfSize:12.f];
    }
    else{
        textLabel.font = [UIFont systemFontOfSize:18.f];
    }
    [qrcodeView addSubview:textLabel];

//    UIButton *ticketButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    ticketButton.frame = CGRectMake((kScreenWidth - 113.f)/2, CGRectGetMaxY(qrcodeView.frame) + 15.f, 113.f, 30.f);
//    ticketButton.backgroundColor = [UIColor clearColor];
//    [ticketButton setBackgroundImage:[UIImage imageNamed:@"gotopay"] forState:UIControlStateNormal];
//    [ticketButton addTarget:self action:@selector(showPayView) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:ticketButton];
    

    

}





@end
