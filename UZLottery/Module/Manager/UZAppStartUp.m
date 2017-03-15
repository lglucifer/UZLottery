//
//  UZAppStartUp.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZAppStartUp.h"
#import "UZLotteryNewsVC.h"

@interface UZAppStartUp()

@property (nonatomic, strong, readwrite) UITabBarController *rootViewController;

@end

@implementation UZAppStartUp

+ (instancetype)sharedStartUp {
    static UZAppStartUp *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[UZAppStartUp alloc] init];
    });
    return _manager;
}

- (instancetype)init {
    if (self = [super init]) {
        UZLotteryNewsVC *firstVC = [[UZLotteryNewsVC alloc] init];
        UINavigationController *firstNavi = [[UINavigationController alloc] initWithRootViewController:firstVC];
        
        UZLotteryNewsVC *secondVC = [[UZLotteryNewsVC alloc] init];
        UINavigationController *secondNavi = [[UINavigationController alloc] initWithRootViewController:secondVC];
        
        UZLotteryNewsVC *thirdVC = [[UZLotteryNewsVC alloc] init];
        UINavigationController *thirdNavi = [[UINavigationController alloc] initWithRootViewController:thirdVC];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.viewControllers = @[firstNavi, secondNavi, thirdNavi];
        self.rootViewController = tabBarController;
    }
    return self;
}

@end
