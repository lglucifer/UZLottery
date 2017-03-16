//
//  GameNumbersTableViewDelegate.h
//  CSLCPlay
//
//  Created by liwei on 15/11/4.
//  Copyright © 2015年 liwei. All rights reserved.
//

#ifndef GameNumbersTableViewDelegate_h
#define GameNumbersTableViewDelegate_h

@protocol GameNumbersTableViewDelegate <NSObject>

@optional

/*
  获取选择号码和相关内容的delegate
  @parma  number 选中号码
  @parma  gameType 11选5：任选一、任选二....
  @parma  subType 11选5：单式、复式、胆拖
  @parma  bet    注数
 */
- (void)getBetContentNumber:(NSString *)number gameType:(NSString *)gameType subType:(NSInteger)subType bet:(int)bet;
- (void)get11in5BetContentArray1:(NSArray *)arr1 arr2:(NSArray *)arr2 arr3:(NSArray *)arr3;


/*
 获取选择号码和相关内容的delegate
 @parma  frontArr1 大乐透：前区，胆拖则为前区胆码
 @parma  frontArr2 大乐透：前区，胆拖则为前区拖码
 @parma  backArr1  大乐透：后区，胆拖则为后区胆码
 @parma  backArr2  大乐透：后区，胆拖则为后区拖码
 */
- (void)getDLTBetContentFrontArray1:(NSArray *)frontArr1 frontArray2:(NSArray *)frontArr2 backArray1:(NSArray *)backArr1 backArray2:(NSArray *)backArr2;

@end

#endif /* GameNumbersTableViewDelegate_h */
