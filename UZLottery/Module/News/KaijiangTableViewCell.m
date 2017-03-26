//
//  KaijiangTableViewCell.m
//  UZLottery
//
//  Created by Tolecen on 2017/3/26.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "KaijiangTableViewCell.h"

@implementation KaijiangTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 20)];
        titleLb.font = [UIFont boldSystemFontOfSize:15];
        titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        [self.contentView addSubview:titleLb];
        self.qiLabel = titleLb;
       
        
        for (int i = 0; i<5; i++) {
            UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(10*(i+1)+30*i, 35, 30, 30)];
            iv.image = [UIImage imageNamed:@"ball_red_ip6"];
            [self.contentView addSubview:iv];
            
            UILabel *dl = [[UILabel alloc] initWithFrame:CGRectMake(10*(i+1)+30*i, 35, 30, 30)];
            dl.font = [UIFont boldSystemFontOfSize:20];
            dl.textColor = [UIColor whiteColor];
            dl.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:dl];
            dl.tag = i+1;
            
        }
        
        UILabel *tl = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, kScreenWidth-20, 20)];
        tl.font = [UIFont boldSystemFontOfSize:14];
        tl.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:tl];
        tl.textAlignment = NSTextAlignmentRight;
        self.timeL = tl;

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSArray * jiangArray = [_jiangStr componentsSeparatedByString:@","];
    for (int i = 0; i<5; i++) {
        UILabel * j = (UILabel *)[self.contentView viewWithTag:i+1];
        j.text = jiangArray[i];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
