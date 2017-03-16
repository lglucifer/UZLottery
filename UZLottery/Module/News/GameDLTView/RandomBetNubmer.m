//
//  RandomBetNubmer.m
//  CSLCPlay
//
//  Created by liwei on 15/10/14.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "RandomBetNubmer.h"

@implementation RandomBetNubmer

/**
 机选一注号码

 @param  count_  号码数量
 @param total 号码总数、11选5=11， 大乐透前区=35 后区=12
 */
+ (NSMutableArray *)randomOneBetCount:(NSInteger)count_ total:(NSInteger)total
{
    NSMutableArray *resutArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSInteger i=1; i<=total; i++) {
        [tempArray addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    NSInteger m = [tempArray count];
    for (NSInteger i=0; i<count_; i++) {
        NSInteger index = arc4random()%(m-i);
        NSString *result = tempArray[index];
        [resutArray addObject:result];
        [tempArray removeObjectAtIndex:index];
        [resutArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 localizedStandardCompare:obj2];
        }];
    }
    return resutArray;
}

/**
 11选5机选
 
 @param  count_  号码数量
 @param  betType  玩法
 
 @return 号码数值
 */
+ (NSArray *)random11in5NumberCount:(NSInteger)count betType:(NSInteger)betType
{
    NSArray *resultArr = @[];
    if (betType == GameBetType11in5Putong) {
        NSArray *array = [NSArray arrayWithArray:[self randomOneBetCount:count total:11]];
        NSMutableArray *tempMutableArr = [[NSMutableArray alloc] init];
        for (NSString *number in array) {
            if ([number intValue] < 10) {
                [tempMutableArr addObject:[NSString stringWithFormat:@"0%@", number]];
            }else{
                [tempMutableArr addObject:number];
            }
        }
        resultArr = [NSArray arrayWithArray:tempMutableArr];
    }
    if (betType == GameBetType11in5Dantuo) {
        NSArray *array = [NSArray arrayWithArray:[self randomOneBetCount:count+1 total:11]];
        NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
        for (NSString *number in array) {
            if ([number intValue] < 10) {
                [mutableArr addObject:[NSString stringWithFormat:@"0%@", number]];
            }else{
                [mutableArr addObject:number];
            }
        }
        NSArray *randomArray = [NSArray arrayWithArray:mutableArr];
        if ([randomArray count] == count + 1) {
            //临时数组，拖码取randomArray后几位。
            NSMutableArray *tempMutableArr = [[NSMutableArray alloc] init];
            [tempMutableArr addObjectsFromArray:randomArray];
            [tempMutableArr removeObjectAtIndex:0];
            
            NSArray *tempArr = [NSArray arrayWithArray:tempMutableArr];
            
            //胆码randomArray中第一位,拖码取后几位
            resultArr = @[@[randomArray[0]], tempArr];
        }

    }
    return resultArr;
}

/**
 大乐透机选
 
 @param  count_  号码数量
 @param  betType  玩法
 @param total 号码总数大乐透前区=35 后区=12

 @return 号码数值
 */
+ (NSArray *)randomDLTNumberCount:(NSInteger)count total:(NSInteger)total betType:(NSInteger)betType
{
    NSArray *resultArr = @[];
    if (betType == GameBetTypeDLTPutong) {
        NSMutableArray *tempMutableArr = [[NSMutableArray alloc] init];
        NSArray *array = [NSArray arrayWithArray:[self randomOneBetCount:count total:total]];
        for (NSString *number in array) {
            if ([number intValue] < 10) {
                [tempMutableArr addObject:[NSString stringWithFormat:@"0%@", number]];
            }else{
                [tempMutableArr addObject:number];
            }
        }
        resultArr = [NSArray arrayWithArray:tempMutableArr];
    }
    if (betType == GameBetTypeDLTDantuo) {
        NSMutableArray *tempMutableArr = [[NSMutableArray alloc] init];
        NSArray *array = [NSArray arrayWithArray:[self randomOneBetCount:count+1 total:total]];
        for (NSString *number in array) {
            if ([number intValue] < 10) {
                [tempMutableArr addObject:[NSString stringWithFormat:@"0%@", number]];
            }else{
                [tempMutableArr addObject:number];
            }
        }
        NSArray *randomArray = [NSArray arrayWithArray:tempMutableArr];
        if ([randomArray count] == count + 1) {
            //临时数组，拖码取randomArray后几位。
            NSMutableArray *tempMutableArr = [[NSMutableArray alloc] init];
            [tempMutableArr addObjectsFromArray:randomArray];
            [tempMutableArr removeObjectAtIndex:0];
            
            NSArray *tempArr = [NSArray arrayWithArray:tempMutableArr];
            
            //胆码randomArray中第一位,拖码取后几位
            resultArr = @[@[randomArray[0]], tempArr];
        }
        
    }
    return resultArr;
}

@end
