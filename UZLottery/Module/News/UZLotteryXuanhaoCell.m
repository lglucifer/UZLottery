//
//  UZLotteryXuanhaoCell.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryXuanhaoCell.h"

@interface UZLotteryXuanhaoCell()


@end

@implementation UZLotteryXuanhaoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(20);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(60);
        }];
        
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.font = [UIFont boldSystemFontOfSize:20];
        titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        [self.contentView addSubview:titleLb];
        self.titleLb = titleLb;
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.contentView).mas_offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setLotteryType:(UZLotteryType)lotteryType {
    _lotteryType = lotteryType;
    if (lotteryType == UZLotteryType_DaLeTou) {
        self.icon.image = [UIImage imageNamed:@"home_icon_10"];
        self.titleLb.text = @"超级大乐透";
        self.titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
    } else {
        self.icon.image = [UIImage imageNamed:@"home_icon_20"];
        self.titleLb.text = @"更多游戏选号敬请期待";
        self.titleLb.textColor = [UIColor lightGrayColor];
    }
}

@end
