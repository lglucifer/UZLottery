//
//  BetContentModel.m
//  CSLCPlay
//
//  Created by liwei on 15/9/18.
//  Copyright (c) 2015年 liwei. All rights reserved.
//

#import "BetContentModel.h"

@implementation BetContentModel

- (id)init
{
    self = [super init];
    if (self) {
        self.appticketcnt = @"appticketcnt";/**票数*/
        self.apptsn = @"app_tsn";/**票号*/
        self.apptvr = @"app_tvr";/**验证码*/
        self.money = @"totalmoney";/**金额*/
        self.bet = @"bet";/**注数*/
        self.msg = @"msg";
    }
    return self;
}

@end
