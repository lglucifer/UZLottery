//
//  UZLotteryNewsVC.h
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UZLotteryDetailVC.h"
#import "UZLotteryNewsCell.h"
#import "UZSessionManager.h"
#import "ZixunContent.h"
#import "NSDate+YYAdd.h"

typedef NS_ENUM(NSUInteger, UZLotteryNewsType) {
    UZLotteryNewsType_Page1 = (0),
    UZLotteryNewsType_Page2 = (1)
};

@interface UZLotteryNewsVC : UIViewController

@property (nonatomic, assign) UZLotteryNewsType pageType;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSArray *items;

@property (nonatomic, assign) NSInteger pageIndex;

@end
