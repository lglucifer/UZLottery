//
//  UZLotteryAppLaunchVC.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryAppLaunchVC.h"
#import "UZSessionManager.h"

@interface UZLotteryAppLaunchVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UZLotteryAppLaunch *appLaunch;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation UZLotteryAppLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showActivityIndicatorTitle:nil inView:self.view];
    self.view.backgroundColor = [UIColor colorWithRGB:0xd81e06];
    __weak __typeof(self) weakSelf = self;
    [[UZSessionManager manager] requestLotteryInfoSuccess:^(UZLotteryAppLaunch *appLaunch, NSURLSessionDataTask *dataTask) {
        [weakSelf hideWithAfterDelay:YES];
        weakSelf.appLaunch = appLaunch;
    } failure:^(NSError *error, NSURLSessionDataTask *dataTask) {
        [weakSelf hideWithAfterDelay:YES];
        [weakSelf.view removeFromSuperview];
    }];
    
}

- (void)inner_ConfigureShowLotteryLaunchScreenIntro:(UZLotteryAppLaunch *)appLaunch {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
