//
//  BetContentModel.h
//  CSLCPlay
//
//  Created by liwei on 15/9/18.
//  Copyright (c) 2015年 liwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetContentModel : NSObject

@property (nonatomic, strong) NSString *appticketcnt;
@property (nonatomic, strong) NSString *apptsn;
@property (nonatomic, strong) NSString *apptvr;
@property (nonatomic, strong) NSString *bet;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *msg;

- (id)init;

@end
