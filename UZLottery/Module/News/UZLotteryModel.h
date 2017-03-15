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
