//
//  UZLotteryMediaView.h
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UZLotteryModel.h"

@interface UZLotteryMediaView : UIView

@property (nonatomic, strong) UZLotteryMedia *media;

@property (nonatomic, copy) void(^kCloseMediaBlock)(UZLotteryMediaView *mediaView);
@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, assign) BOOL enableShowCloseBtn;
@property (nonatomic,strong)UILabel * timerLabel;
@property (nonatomic, assign) CGSize imageScaleSize;

@end
