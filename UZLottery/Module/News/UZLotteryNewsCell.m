//
//  UZLotteryNewsCell.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryNewsCell.h"

@interface UZLotteryNewsCell()


@end

@implementation UZLotteryNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.font = [UIFont boldSystemFontOfSize:18];
        titleLb.numberOfLines = 2;
        titleLb.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
        titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        [self.contentView addSubview:titleLb];
        self.titleLb = titleLb;
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(10);
            make.top.mas_equalTo(self.contentView).mas_offset(10);
            make.right.mas_equalTo(self.contentView).mas_offset(-10);
        }];
        
        UILabel *dateLb = [[UILabel alloc] init];
        dateLb.font = [UIFont systemFontOfSize:12];
        dateLb.textColor = [UIColor colorWithRGB:0xa5a5a5];
        [self.contentView addSubview:dateLb];
        self.dateLb = dateLb;
        [dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-10);
            make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        }];
    }
    return self;
}

- (void)setNews:(UZLotteryNews *)news {
    if (!news) {
        return;
    }
    _news = news;
    self.titleLb.text = news.title;
//    self.dateLb.text = [NSString stringWithFormat:@"%@", news.createdTime];
    self.dateLb.text = news.createdTime;
}

@end
