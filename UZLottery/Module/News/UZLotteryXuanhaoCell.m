//
//  UZLotteryXuanhaoCell.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryXuanhaoCell.h"

@interface UZLotteryXuanhaoCell()

@property (nonatomic, weak) UILabel *titleLb;

@property (nonatomic, weak) UIImageView *icon;

@end

@implementation UZLotteryXuanhaoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(80);
        }];
        
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.font = [UIFont boldSystemFontOfSize:25];
        titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        [self.contentView addSubview:titleLb];
        self.titleLb = titleLb;
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.contentView).mas_offset(10);
            make.right.mas_equalTo(self.contentView).mas_offset(-10);
        }];
    }
    return self;
}

- (void)setLotteryType:(UZLotteryType)lotteryType {
    _lotteryType = lotteryType;
    if (lotteryType == UZLotteryType_DaLeTou) {
        self.icon.image = [UIImage imageNamed:@"home_icon_10"];
        self.titleLb.text = @"大乐透";
    } else {
        self.icon.image = [UIImage imageNamed:@"home_icon_20"];
        self.titleLb.text = @"11选5";
    }
}

@end
