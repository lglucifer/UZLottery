//
//  UZLotteryNewsVC.h
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UZLotteryNewsType) {
    UZLotteryNewsType_Page1 = (0),
    UZLotteryNewsType_Page2 = (1)
};

@interface UZLotteryNewsVC : UIViewController

@property (nonatomic, assign) UZLotteryNewsType pageType;

@end
