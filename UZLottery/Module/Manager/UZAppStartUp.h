//
//  UZAppStartUp.h
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UZAppStartUp : NSObject

@property (nonatomic, strong, readonly) UITabBarController *rootViewController;

+ (instancetype)sharedStartUp;

@end