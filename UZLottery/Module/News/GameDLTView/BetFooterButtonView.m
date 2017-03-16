//
//  BetFooterButtonView.m
//  CSLCPlay
//
//  Created by liwei on 15/12/28.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "BetFooterButtonView.h"

@implementation BetFooterLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:14.f];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor blackColor];
        self.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}
@end

@implementation BetFooterButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorRGBWithRed:82.f green:82.f blue:82.f alpha:1.f];
        
        
        CGFloat btnW = 50.f;
        if (iPhone6) {
            btnW = 50.f * 1.5;
        }
        if (iPhone6Plus) {
            btnW = 50.f * 1.5;
        }
        
        CGFloat btnY = 7.f;
        CGFloat btnHeight = 36.f;
        
        //---- 保存
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.frame = CGRectMake(15.f, btnY, btnW, btnHeight);
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        _saveButton.backgroundColor = [UIColor colorRGBWithRed:106.f green:106.f blue:106.f alpha:1.f];
        _saveButton.layer.cornerRadius = 4;
        [self addSubview:_saveButton];
        
        //---- 生成二维码
        _qrCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qrCodeButton.frame = CGRectMake(self.frame.size.width - btnW - 25.f, btnY, btnW+15.f, btnHeight);
        [_qrCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _qrCodeButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _qrCodeButton.backgroundColor = kBackgroundGlobalRedColor;
        _qrCodeButton.layer.cornerRadius = 4;
        _qrCodeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_qrCodeButton];
        
        //金额/注数
        CGFloat moneyLW = kScreenWidth - (CGRectGetMaxX(_saveButton.frame) + btnW + 50.f);
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-moneyLW)/2, 3.f, moneyLW, self.frame.size.height-6.f)];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = [UIFont systemFontOfSize:16.f];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_moneyLabel];
        
        //公益券
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(_moneyLabel.frame.origin.x, CGRectGetMaxY(_moneyLabel.frame), _moneyLabel.frame.size.width, self.frame.size.height/2 - 10.f)];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.textColor = [UIColor whiteColor];
        _descLabel.font = [UIFont systemFontOfSize:12.f];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.adjustsFontSizeToFitWidth = YES;
        //[btnView addSubview:_descLabel];
    }
    return self;
}


- (void)getBetText:(NSString *)bet money:(NSString *)money
{
    NSString *text = [NSString stringWithFormat:@"共 %@ 注 %@ 元", bet, money];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    if ([bet intValue] > 0 && [money intValue] > 0) {
        NSRange range1 = [text rangeOfString:bet];
        NSRange range2 = [text rangeOfString:money];
        if (range1.location != NSNotFound) {
            [attrString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:NSMakeRange(range1.location, range1.length)];
        }
        if (range2.location != NSNotFound) {
            [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorRGBWithRed:215.f green:164.f blue:32.f alpha:1.f], NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:NSMakeRange(range2.location, range2.length)];
            
        }
    }
    if (bet == 0) {
        [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorRGBWithRed:215.f green:164.f blue:32.f alpha:1.f], NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:NSMakeRange(6, 1)];
    }
    _moneyLabel.attributedText = attrString;
}

@end
