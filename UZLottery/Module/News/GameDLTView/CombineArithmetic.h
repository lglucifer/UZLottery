//
//  CombineArithmetic.h
//  CSLCLottery
//
//  Created by 李伟 on 13-10-14.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//
//  计算大乐透、11选5投注的注数、中奖金额
//

#import <Foundation/Foundation.h>

@interface CombineArithmetic : NSObject
/**大乐透 普通投注的注数*/
+ (NSInteger)getDLTPutongFrontCount:(NSInteger)frontCount backCount:(NSInteger)backCount;

/**大乐透 胆拖投注的注数*/
+ (NSInteger)getDLTDanTuoFrontDanCount:(NSInteger)frontDanCount frontTuoCount:(NSInteger)frontTuoCount backTuoCount:(NSInteger)backTuoCount;

/**11选5显示普通投注的注数*/
+ (NSInteger)game11in5PutongBetCountN:(NSArray *)numberArray count:(NSInteger)count_;

/**11选5计算胆拖投注的注数*/
+ (NSInteger)game11in5DantuoBetCountN:(NSArray *)danArray tuoArray:(NSArray *)tuoArray  count:(NSInteger)count_;

/**11选5计算直选2注数*/
+ (NSInteger)game11in5Zhixuan2CountN:(NSArray *)array1 array2:(NSArray *)array2;

/**11选5计算直选3注数*/
+ (NSInteger)game11in5Zhixuan3CountN:(NSArray *)array1 array2:(NSArray *)array2 array3:(NSArray *)array3;

/**11选5胆拖投注总奖金额*/
+ (NSInteger)getCombineDanTuoBonusWithDan:(NSInteger)d tuo:(NSInteger)at type:(NSInteger)tp  money:(NSInteger)money;

/**m中选择n个数的组合的数量*/
+ (NSInteger)getCombineCountWithM:(NSInteger)m n:(NSInteger)n;


@end
