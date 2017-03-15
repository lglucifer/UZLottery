//
//  UZLotteryXuanhaoCell.h
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UZLotteryType) {
    UZLotteryType_DaLeTou   = (0),
    UZLotteryType_11xuan5   = (1)
};

@interface UZLotteryXuanhaoCell : UITableViewCell

@property (nonatomic, assign) UZLotteryType lotteryType;

@end
