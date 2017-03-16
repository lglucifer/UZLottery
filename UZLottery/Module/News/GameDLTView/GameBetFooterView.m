//
//  BetFooterView.m
//  CSLCShop
//
//  Created by 李伟 on 15/2/9.
//  Copyright (c) 2015年 李伟. All rights reserved.
//
//  选号页面底部
//


#import "GameBetFooterView.h"

@implementation GameBetFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _btnView =  [[BetFooterButtonView alloc] initWithFrame:self.bounds];
        [self addSubview:_btnView];
        
        [_btnView.saveButton setTitle:@"清空" forState:UIControlStateNormal];
        [_btnView.saveButton addTarget:self action:@selector(clearButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_btnView.qrCodeButton setTitle:@"选好了" forState:UIControlStateNormal];
        [_btnView.qrCodeButton addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        //----
//        self.backgroundColor = [UIColor colorRGBWithRed:82.f green:82.f blue:82.f alpha:1.f];
//        
//        CGFloat btnW = 50.f;
//        if (iPhone6) {
//            btnW = 50.f * 1.5;
//        }
//        if (iPhone6Plus) {
//            btnW = 50.f * 1.5;
//        }
//        
//        CGFloat btnHeight = 40.f;
//
//        CGFloat btnY = (self.frame.size.height - btnHeight)/2;
//        
//        //---- 清除号码
//        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _clearButton.frame = CGRectMake(15.f, btnY, btnW, btnHeight);
//        [_clearButton setTitle:@"清空" forState:UIControlStateNormal];
//        [_clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _clearButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
//        _clearButton.backgroundColor = [UIColor colorRGBWithRed:106.f green:106.f blue:106.f alpha:1.f];
//        _clearButton.layer.cornerRadius = 4;
//        [self addSubview:_clearButton];
//        
//        //---- 加入购物列表
//        CGFloat blbX = self.frame.size.width - btnW - 25.f;
//        _betListButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _betListButton.frame = CGRectMake(blbX, btnY, btnW+15.f, btnHeight);
//        [_betListButton setTitle:@"选好了" forState:UIControlStateNormal];
//        [_betListButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _betListButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
//        _betListButton.backgroundColor = [UIColor colorRGBWithRed:189.f green:40.f blue:57.f alpha:1.f];
//        _betListButton.layer.cornerRadius = 4;
//
//        [self addSubview:_betListButton];
//        
//        //注数、金额
//        CGFloat lx = CGRectGetMaxX(_clearButton.frame)+2.f;
//        CGFloat lw = blbX-(lx) - 2.f;
//        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(lx, 0, lw, self.frame.size.height)];
//        _moneyLabel.backgroundColor = [UIColor clearColor];
//        _moneyLabel.textColor = [UIColor whiteColor];
//        _moneyLabel.font = [UIFont systemFontOfSize:16.f];
//        _moneyLabel.textAlignment = NSTextAlignmentCenter;
//        _moneyLabel.adjustsFontSizeToFitWidth = YES;
//        [self addSubview:_moneyLabel];
        
    }
    return self;
}


- (void)clearButtonAction
{
    [_delegate leftFooterButtonAction];
}

- (void)doneButtonAction
{
    [_delegate rightFooterButtonAction];
}

@end
