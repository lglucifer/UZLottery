//
//  UZAppStartUp.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZAppStartUp.h"
#import "UZLotteryNewsVC.h"
#import "UZLotteryXuanhaoVC.h"
#import "UZLotteryAppLaunchVC.h"

@interface UZAppStartUp()

@property (nonatomic, strong, readwrite) UITabBarController *rootViewController;

@property (nonatomic, strong) UZLotteryAppLaunchVC *appLaunchVC;

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
        [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRGB:0xdbdbdb], NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRGB:0xd81e06], NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];

        UIImage *normalImage = [[UIImage imageNamed:@"xuanhao_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *highlightImage = [[UIImage imageNamed:@"xuanhao_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"选号"
                                                           image:normalImage
                                                   selectedImage:highlightImage];
        UZLotteryXuanhaoVC *firstVC = [[UZLotteryXuanhaoVC alloc] init];
        firstVC.tabBarItem = item;
        UINavigationController *firstNavi = [[UINavigationController alloc] initWithRootViewController:firstVC];
        
        normalImage = [[UIImage imageNamed:@"xinwen_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        highlightImage = [[UIImage imageNamed:@"xinwen_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item = [[UITabBarItem alloc] initWithTitle:@"咨询"
                                             image:normalImage
                                     selectedImage:highlightImage];
        UZLotteryNewsVC *secondVC = [[UZLotteryNewsVC alloc] init];
        secondVC.tabBarItem = item;
        secondVC.pageType = UZLotteryNewsType_Page1;
        UINavigationController *secondNavi = [[UINavigationController alloc] initWithRootViewController:secondVC];
        
        normalImage = [[UIImage imageNamed:@"hangye_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        highlightImage = [[UIImage imageNamed:@"hangye_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item = [[UITabBarItem alloc] initWithTitle:@"行业动态"
                                             image:normalImage
                                     selectedImage:highlightImage];
        UZLotteryNewsVC *thirdVC = [[UZLotteryNewsVC alloc] init];
        thirdVC.tabBarItem = item;
        secondVC.pageType = UZLotteryNewsType_Page2;
        UINavigationController *thirdNavi = [[UINavigationController alloc] initWithRootViewController:thirdVC];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.viewControllers = @[firstNavi, secondNavi, thirdNavi];
        tabBarController.selectedIndex = 1;
        self.rootViewController = tabBarController;
        
        self.appLaunchVC = [[UZLotteryAppLaunchVC alloc] init];
        [tabBarController.view addSubview:self.appLaunchVC.view];
    }
    return self;
}

@end
