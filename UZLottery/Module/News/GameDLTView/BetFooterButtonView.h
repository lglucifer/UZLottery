//
//  BetFooterButtonView.h
//  CSLCPlay
//
//  Created by liwei on 15/12/28.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetFooterLabel : UILabel

- (id)initWithFrame:(CGRect)frame;

@end


@interface BetFooterButtonView : UIView

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *qrCodeButton;

- (void)getBetText:(NSString *)bet money:(NSString *)money;

@end
