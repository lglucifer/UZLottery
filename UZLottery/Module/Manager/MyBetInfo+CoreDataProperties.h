//
//  MyBetInfo+CoreDataProperties.h
//  CSLCPlay
//
//  Created by liwei on 15/10/20.
//  Copyright © 2015年 liwei. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//


#import "MyBetInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyBetInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *provid;//省id
@property (nullable, nonatomic, retain) NSString *additionId;
@property (nullable, nonatomic, retain) NSString *fid;
@property (nullable, nonatomic, retain) NSString *gameNo;
@property (nullable, nonatomic, retain) NSString *gameName;
@property (nullable, nonatomic, retain) NSString *createDate;
@property (nullable, nonatomic, retain) NSString *createTime;
@property (nullable, nonatomic, retain) NSString *draw;//期数
@property (nullable, nonatomic, retain) NSString *mutiple;//倍数
@property (nullable, nonatomic, retain) NSString *totalBet;//总注数
@property (nullable, nonatomic, retain) NSString *totalMoney;

@end

NS_ASSUME_NONNULL_END
