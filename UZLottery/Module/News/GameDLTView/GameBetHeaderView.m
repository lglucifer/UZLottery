//
//  GameBetHeaderView.m
//  CSLCPlay
//
//  Created by liwei on 15/10/10.
//  Copyright © 2015年 liwei. All rights reserved.
//
//
//  选号页面头部
//


#import "GameBetHeaderView.h"
//#import "GP11in5Description.h"

@implementation GameBetHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /**---下拉显示近期开奖
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 24.f)];
        topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topView];
        
        _drawLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, topView.frame.size.height)];
        _drawLabel.backgroundColor = [UIColor clearColor];
        _drawLabel.textColor = [UIColor darkGrayColor];
        _drawLabel.font = [UIFont systemFontOfSize:14.f];
        _drawLabel.textAlignment = NSTextAlignmentCenter;
        _drawLabel.adjustsFontSizeToFitWidth = YES;
        [topView addSubview:_drawLabel];
        
        _timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_drawLabel.frame), 0, topView.frame.size.width/2, topView.frame.size.height)];
        _timerLabel.backgroundColor = [UIColor clearColor];
        _timerLabel.textColor = [UIColor colorRGBWithRed:142.f green:0 blue:0 alpha:1.f];
        _timerLabel.font = [UIFont systemFontOfSize:14.f];
        _timerLabel.textAlignment = NSTextAlignmentLeft;
        _timerLabel.adjustsFontSizeToFitWidth = YES;
        [topView addSubview:_timerLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height, kScreenWidth, 1.f)];
        lineView.backgroundColor = [UIColor colorRGBWithRed:210.f green:209.f blue:205.f alpha:1.f];
        [topView addSubview:lineView];
        
        UIImageView *drawImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 100.f)/2, CGRectGetMaxY(topView.frame), 95.f, 15.f)];
        drawImageView.image = [UIImage imageNamed:@"11in5_draw"];
        [self addSubview:drawImageView];
        */
        
        _shakeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shakeButton.backgroundColor = [UIColor clearColor];
        _shakeButton.frame = CGRectMake(kScreenWidth - 122.f, 5.f, 122.f, 32.f);
        [_shakeButton setBackgroundImage:[UIImage imageNamed:@"shake"] forState:UIControlStateNormal];
        [self addSubview:_shakeButton];
        
        _introlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, CGRectGetMaxY(_shakeButton.frame), self.frame.size.width - 15.f, 26.f)];
        _introlLabel.backgroundColor = [UIColor clearColor];
        _introlLabel.textColor = [UIColor darkGrayColor];
        _introlLabel.font = [UIFont systemFontOfSize:14.f];
        _introlLabel.textAlignment = NSTextAlignmentLeft;
        _introlLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_introlLabel];
    }
    return self;
}

- (void)setupIntroLabelAttributedTextWithMoney:(NSString *)money
{
    NSRange range = [_introlLabel.text rangeOfString:money];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_introlLabel.text];
        [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(range.location, range.length)];
        _introlLabel.attributedText = attrString;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
