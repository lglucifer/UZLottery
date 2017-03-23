//
//  QRCodeViewController.h
//  CSLCPlay
//
//  Created by liwei on 15/9/12.
//  Copyright (c) 2015年 liwei. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface QRCodeViewController : UIViewController

@property (nonatomic, strong) NSArray *displayArray;
@property (nonatomic, strong) UIViewController *popController;

@property (nonatomic, strong) NSString *appsn;
@property (nonatomic, strong) NSString *apptvr;
@property (nonatomic, strong) NSString *gameNo;

- (void)generateQREncoderString:(const char *)string ticketCnt:(NSString *)ticketCnt bet:(NSString *)bet totalMoney:(NSString *)totalMoney
;

@end
