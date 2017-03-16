//
//  BallSizeConfig.m
//  CSLCShop
//
//  Created by liwei on 15/7/21.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import "BallSizeConfig.h"

NSString * const kWhiteBallName = @"white_ball";
NSString * const kRedBallName = @"red_ball";
NSString * const kBlueBallName = @"blue_ball";

@implementation BallSizeConfig

+ (CGSize)betBallSize
{
    CGFloat w = 36.f;
    CGFloat h = 36.f;
    
    if (iPhone4) {
        w = 36.f;
        h = 36.f;
    }
    if (iPhone5) {
        w = 36.f;
        h = 36.f;
    }
    if (iPhone6) {
        w = 45.f;
        h = 45.f;
    }
    if (iPhone6Plus) {
        w = 50.f;
        h = 50.f;
    }
    return CGSizeMake(w, h);
}

+ (NSString *)redBallImageName
{
    NSString *imgName = @"ball_red_ip5";
    if (iPhone4) {
        imgName = @"ball_red_ip5";
    }
    if (iPhone5) {
        imgName = @"ball_red_ip5";
    }
    if (iPhone6) {
        imgName = @"ball_red_ip6";
    }
    if (iPhone6Plus) {
        imgName = @"ball_red_ip6plus";
    }
    return imgName;
}

+ (NSString *)blueBallImageName
{
    NSString *imgName = @"ball_blue_ip5";
    if (iPhone4) {
        imgName = @"ball_blue_ip5";
    }
    if (iPhone5) {
        imgName = @"ball_blue_ip5";
    }
    if (iPhone6) {
        imgName = @"ball_blue_ip6";
    }
    if (iPhone6Plus) {
        imgName = @"ball_blue_ip6plus";
    }
    return imgName;
}

+ (NSString *)noneBallImageName
{
    NSString *imgName = @"ball_none_ip5";
    if (iPhone4) {
        imgName = @"ball_none_ip5";
    }
    if (iPhone5) {
        imgName = @"ball_none_ip5";
    }
    if (iPhone6) {
        imgName = @"ball_none_ip6";
    }
    if (iPhone6Plus) {
        imgName = @"ball_none_ip6plus";
    }
    return imgName;
}


@end
