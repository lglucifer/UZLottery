//
//  CombineArithmetic.m
//  CSLCLottery
//
//  Created by 李伟 on 13-10-14.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import "CombineArithmetic.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation CombineArithmetic

#pragma mark - 大乐透注数
/**
 大乐透 普通投注的注数
 @param frontCount：前区号码数量
 @param backCount： 后区号码数量

 @return 投注的注数
 */
+ (NSInteger)getDLTPutongFrontCount:(NSInteger)frontCount backCount:(NSInteger)backCount
{
    NSInteger result = 0;
    NSInteger front = [CombineArithmetic getCombineCountWithM:frontCount n:5];
    NSInteger back = [CombineArithmetic getCombineCountWithM:backCount n:2];
    result = front * back;
    return result;
}

/**
  大乐透 胆拖投注的注数
  @param frontDanCount：前区胆码数量
  @param frontTuoCount： 前区拖码数量
  @param backTuoCount：后区拖码数量
 
  @return 投注的注数
*/
+ (NSInteger)getDLTDanTuoFrontDanCount:(NSInteger)frontDanCount frontTuoCount:(NSInteger)frontTuoCount backTuoCount:(NSInteger)backTuoCount
{
    NSInteger result = 0;
    
    NSInteger frontTuo = [CombineArithmetic getCombineCountWithM:frontTuoCount n:5-frontDanCount];
    
    NSInteger backDan = 1;
    NSInteger backTuo = [CombineArithmetic getCombineCountWithM:backTuoCount n:2-backDan];
    
    result = frontTuo * backTuo;

    return result;
}


#pragma mark - 计算11选5注数、金额
/**
 11选5显示普通投注的注数
 @param numberArray：选择号码数量
 @param count_： 选号规则，单注的号码数，eg：任选二count_=2，任选五count_=5
 
 @return 投注的注数
 */
+ (NSInteger)game11in5PutongBetCountN:(NSArray *)numberArray count:(NSInteger)count_
{
    NSInteger bet = 0;
    if ([numberArray count] > count_) {
        bet = [CombineArithmetic getCombineCountWithM:[numberArray count] n:count_];
    }
    if ([numberArray count] == count_) {
        bet = 1;
    }
    return bet;
}

/**
 11选5计算胆拖投注的注数
 @param danArray：胆码数量
 @param tuoArray： 拖码数量
 @param count_：选号规则，选取几个拖码，eg：任选二count_=2，任选五count_=5
 
 @return 投注的注数
 */
+ (NSInteger)game11in5DantuoBetCountN:(NSArray *)danArray tuoArray:(NSArray *)tuoArray  count:(NSInteger)count_
{
    NSInteger nn = (count_ - [danArray count]);
    NSInteger bet = [CombineArithmetic getCombineCountWithM:[tuoArray count] n:nn];
    
    return bet;
}

/**
 11选5计算直选2注数
 @param array1：第一位号码数量
 @param array2： 第二位号码数量
 
 @return 投注的注数
 */
+ (NSInteger)game11in5Zhixuan2CountN:(NSArray *)array1 array2:(NSArray *)array2
{
    NSInteger bet = 0;
    NSInteger bet1 = 0;
    NSInteger bet2 = 0;
    if ([array1 count] > 1) {
        bet1 = [CombineArithmetic getCombineCountWithM:[array1 count] n:1];
    }
    if ([array1 count] == 1) {
        bet1 = 1;
    }
    if ([array2 count] > 1) {
        bet2 = [CombineArithmetic getCombineCountWithM:[array2 count] n:1];
    }
    if ([array2 count] == 1) {
        bet2 = 1;
    }
    
    bet = bet1 * bet2;
    return bet;
}

/**
 11选5计算直选3注数
 @param array1：第一位号码数量
 @param array2： 第二位号码数量
 @param array3：第三位数量
 
 @return 投注的注数
 */
+ (NSInteger)game11in5Zhixuan3CountN:(NSArray *)array1 array2:(NSArray *)array2 array3:(NSArray *)array3
{
    NSInteger bet = 0;
    NSInteger bet1 = 0;
    NSInteger bet2 = 0;
    NSInteger bet3 = 0;
    if ([array1 count] > 1) {
        bet1 = [CombineArithmetic getCombineCountWithM:[array1 count] n:1];
    }
    if ([array1 count] == 1) {
        bet1 = 1;
    }
    if ([array2 count] > 1) {
        bet2 = [CombineArithmetic getCombineCountWithM:[array2 count] n:1];
    }
    if ([array2 count] == 1) {
        bet2 = 1;
    }
    if ([array3 count] > 1) {
        bet3 = [CombineArithmetic getCombineCountWithM:[array3 count] n:1];
    }
    if ([array3 count] == 1) {
        bet3 = 1;
    }
    
    bet = bet1 * bet2 * bet3;
    return bet;
}


#pragma mark - 计算11选5总奖金额
/**
 *	@brief	计算胆拖投注的总奖金数额  任选二、三、四
 *
 *	@param 	d 	胆码数量
 *	@param 	at 	拖码中奖个数
 *	@param 	tp 	投注类型标志。任选二 tp=2；任选3 tp=3；任选4 tp=4
 *	@param 	money 	单注奖金的金额
 *
 *	@return	投注的总奖金额度
 */
+ (NSInteger)getCombineDanTuoBonusWithDan:(NSInteger)d tuo:(NSInteger)at type:(NSInteger)tp money:(NSInteger)money

{
    NSInteger result = 1;
    NSInteger st = tp - d;//拖码数量，如任选四，胆码1，则 tp=4,st=4-1.
    
    //在中奖拖码中选择st个数字。
    NSInteger bet = [CombineArithmetic getCombineCountWithM:at n:st];
    
    result = bet * money;
    
    return result;
}

#pragma mark - 通用方法
/**
 m中选择n个数的组合的数量
 公式：C(m, n)＝m*(m－1)*(m－2)．．．<n个数>／n*(n－1)*(n－2)．．．1
 eg：C(10, 5)=(10*9*8*7*6)/(5*4*3*2*1);
 
 @param 	m 	数组中元素的总数
 @param 	n 	数组中选择n个数

 @return	组合的数量
 */
+ (NSInteger)getCombineCountWithM:(NSInteger)m n:(NSInteger)n

{
    NSInteger result = 0;
    
    if (n == 0) {
        return 1;
    }
    else if (m == n) {
        result = 1;
    }else if (m == n+1) {
        result = m;
    }else if (m > n+1) {
        //C(m,n)
        NSInteger numerator = 1;
        for (NSInteger i=n; i>0; i--) {
            numerator = numerator * i;
        }
        
        NSInteger denominator = 1;
        for (NSInteger j=m; j>m-n; j--) {
            denominator = denominator * j;
        }
        
        result = denominator/numerator;
    }else{
        result = 0;
    }
    
    return  result;
}


/**
 NSArray中选择n个数的组合
 @param 	numArr 	数组，例如：@[@"1",@"2",@"3"]
 @param 	n 	    数组中选择n个数， 例如：n=2
 
 @return	组合明细, 例如：resultArray = @[@[1,2], @[1,3], @[2,3]]
 */
+ (NSArray *)getCombinCountWithM:(NSArray *)numArr n:(NSInteger)n
{
    NSArray *resultArray = @[];
    
    NSString *jsString = @"function add(arr, num) {"
    "var r = [];"
    "(function f(t, a, n) {"
    "if (n == 0) return r.push(t);"
    "for (var i = 0, l = a.length; i <= l - n; i++) {"
    "f(t.concat(a[i]), a.slice(i + 1), n - 1);"
    "}"
    "})([], arr, num);"
    "return r;}";
    
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:jsString];//@"function add(a, b) { return a + b; }"
    JSValue *jsArr = context[@"add"]; // Get array from JSContext
    
    //NSLog(@"JS Array: %@; Length: %d", jsArr, [jsArr[@"length"] toInt32]);
    
    JSValue *jsResult = [jsArr callWithArguments:@[numArr, @(n)]];
    //NSLog(@"js result: %@", jsResult);
    
    resultArray = [jsResult toArray];
    //NSLog(@"result Array(%@)=%@",@([resultArray count]), resultArray);
    
    
    //NSLog(@"NSArray: %@",resultArray);
    return resultArray;
}

@end
