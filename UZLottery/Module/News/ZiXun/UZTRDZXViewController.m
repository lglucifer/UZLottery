//
//  UZTRDZXViewController.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/30.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZTRDZXViewController.h"

@interface UZTRDZXViewController ()

@end

@implementation UZTRDZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)inner_Refresh {
    //    __weak __typeof(self) weakSelf = self;
    [[UZSessionManager manager] requestLotteryNewsWithPageType:self.pageType
                                                       Success:^(NSArray *news, NSURLSessionDataTask *dataTask) {
                                                           //                                                           weakSelf.items = news;
                                                           //                                                           [weakSelf.tableView.mj_header endRefreshing];
                                                           //                                                           [weakSelf.tableView reloadData];
                                                       } failure:^(NSError *error, NSURLSessionDataTask *dataTask) {
                                                           //                                                           [weakSelf.tableView.mj_header endRefreshing];
                                                       }];
    self.items = [[UZLotteryNews arrayOfModelsFromDictionaries:[ZixunContent array1]
                                                        error:nil] reverseObjectEnumerator].allObjects;
    [self.items enumerateObjectsUsingBlock:^(UZLotteryNews *news, NSUInteger idx, BOOL * _Nonnull stop) {
        news.createdTime = [[NSDate date] stringWithFormat:@"yyyy/MM/dd"];
    }];
    
    self.pageIndex = 1;
    self.tableView.mj_footer.hidden = NO;
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

- (void)inner_LoadMore {
    NSArray *loadMoreArray = [[UZLotteryNews arrayOfModelsFromDictionaries:[ZixunContent array2]
                                                                    error:nil] reverseObjectEnumerator].allObjects;
    [loadMoreArray enumerateObjectsUsingBlock:^(UZLotteryNews *news, NSUInteger idx, BOOL * _Nonnull stop) {
        news.createdTime = [[NSDate dateWithTimeInterval:(-24 * 60 * 60 * self.pageIndex) sinceDate:[NSDate date]] stringWithFormat:@"yyyy/MM/dd"];
    }];
    self.items = [[NSArray arrayWithArray:self.items] arrayByAddingObjectsFromArray:loadMoreArray];
    
    self.pageIndex += 1;
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

@end
