//
//  MyTicketInfo+CoreDataProperties.h
//  CSLCPlay
//
//  Created by liwei on 15/10/20.
//  Copyright © 2015年 liwei. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//


#import "MyTicketInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTicketInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *gameNo;
@property (nullable, nonatomic, retain) NSString *gameName;
@property (nullable, nonatomic, retain) NSString *bet;
@property (nullable, nonatomic, retain) NSString *betDetail;
@property (nullable, nonatomic, retain) NSString *betType;
@property (nullable, nonatomic, retain) NSString *createDate;
@property (nullable, nonatomic, retain) NSString *createTime;
@property (nullable, nonatomic, retain) NSString *displayDetail;
@property (nullable, nonatomic, retain) NSString *gameType;
@property (nullable, nonatomic, retain) NSString *groupIdx;
@property (nullable, nonatomic, retain) NSString *isDirect;
@property (nullable, nonatomic, retain) NSString *money;
@property (nullable, nonatomic, retain) NSString *pickMethod;
@property (nullable, nonatomic, retain) NSString *region;
@property (nullable, nonatomic, retain) NSString *subType;

@end

NS_ASSUME_NONNULL_END
