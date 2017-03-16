//
//  RandomBetNubmer.h
//  CSLCPlay
//
//  Created by liwei on 15/10/14.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GameBetType){
    GameBetType11in5Putong = 0,
    GameBetType11in5Zhixuan2 = 1,
    GameBetType11in5Zhixuan3 = 2,
    GameBetType11in5Dantuo = 3,
    GameBetTypeDLTPutong = 4,
    GameBetTypeDLTDantuo = 5
};

@interface RandomBetNubmer : NSObject

/**11选5机选*/
+ (NSArray *)random11in5NumberCount:(NSInteger)count betType:(NSInteger)betType;

/**11选5机选*/
+ (NSArray *)randomDLTNumberCount:(NSInteger)count total:(NSInteger)total betType:(NSInteger)betType;

@end
