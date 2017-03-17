//
//  UZLotteryModel.h
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "JSONModel.h"

@interface UZLotteryModel : JSONModel

@end

@interface UZLotteryNews : UZLotteryModel

@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDate *createdTime;

@end

@interface UZLotteryKaijiang : UZLotteryModel

@property (nonatomic, copy) NSString *expect;
@property (nonatomic, copy) NSString *opencode;
@property (nonatomic, copy) NSString *opentime;
//@property (nonatomic, strong) NSDate *createdTime;

@end

@protocol UZLotteryMedia <NSObject>

@end

@interface UZLotteryMedia : UZLotteryModel

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL can_close;

@end

@interface UZLotteryAppLaunch : UZLotteryModel

@property (nonatomic, assign) BOOL app_status;
@property (nonatomic, copy) NSString *app_url;
@property (nonatomic, strong) UZLotteryMedia *logo;
@property (nonatomic, strong) UZLotteryMedia *launch;
@property (nonatomic, strong) UZLotteryMedia *screen;
@property (nonatomic, copy) NSArray<UZLotteryMedia> *intro;

@end
