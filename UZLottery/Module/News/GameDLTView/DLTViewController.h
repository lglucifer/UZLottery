//
//  DLTViewController.h
//  CSLCPlay
//
//  Created by liwei on 15/10/15.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLTViewController : CSLCBaseViewController

@property (nonatomic, assign) BOOL isHomePush;
@property (nonatomic, assign) BOOL isDanTuo;
@property (nonatomic, strong) NSString *gameNo;
@property (nonatomic, strong) NSString *gameName;

@property (nonatomic, strong) NSString *updateNumbers;
@property (nonatomic, strong) NSNumber *ticketInfoIdx;
@property (nonatomic, assign) NSInteger ticketBet;

@end
