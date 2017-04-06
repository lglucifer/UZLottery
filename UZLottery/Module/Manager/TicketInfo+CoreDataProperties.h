//
//  TicketInfo+CoreDataProperties.h
//  CSLCPlay
//
//  Created by liwei on 15/11/6.
//  Copyright © 2015年 liwei. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//


#import "TicketInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bet;
@property (nullable, nonatomic, retain) NSString *betDetail;
@property (nullable, nonatomic, retain) NSString *betType;
@property (nullable, nonatomic, retain) NSDate *createTime;
@property (nullable, nonatomic, retain) NSString *displayDetail;
@property (nullable, nonatomic, retain) NSString *gameType;//超级大乐透为空或者是“大乐透”；11选5=任选一、二、三；扑克3=包选、猜对子...
@property (nullable, nonatomic, retain) NSString *groupIdx;
@property (nullable, nonatomic, retain) NSString *isDirect;
@property (nullable, nonatomic, retain) NSString *money;
@property (nullable, nonatomic, retain) NSString *pickMethod;
@property (nullable, nonatomic, retain) NSString *region;
@property (nullable, nonatomic, retain) NSString *subType;//单式、复式、胆拖
@property (nullable, nonatomic, retain) NSNumber *idx;

@end

NS_ASSUME_NONNULL_END
