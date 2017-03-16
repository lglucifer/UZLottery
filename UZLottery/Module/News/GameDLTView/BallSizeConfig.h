//
//  BallSizeConfig.h
//  CSLCShop
//
//  Created by liwei on 15/7/21.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kWhiteBallName;
extern NSString * const kRedBallName;
extern NSString * const kBlueBallName;

@interface BallSizeConfig : NSObject

+ (CGSize)betBallSize;
+ (NSString *)redBallImageName;
+ (NSString *)blueBallImageName;
+ (NSString *)noneBallImageName;

@end
