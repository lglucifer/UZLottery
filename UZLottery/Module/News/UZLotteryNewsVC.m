//
//  UZLotteryNewsVC.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryNewsVC.h"
#import "UZLotteryDetailVC.h"
#import "UZLotteryNewsCell.h"
#import "UZSessionManager.h"

@interface UZLotteryNewsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSArray *items;

@end

@implementation UZLotteryNewsVC

- (NSString *)title {
    return self.tabBarItem.title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80.f;
    [tableView registerClass:[UZLotteryNewsCell class] forCellReuseIdentifier:NSStringFromClass([UZLotteryNewsCell class])];
    [self.view addSubview:tableView];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                           refreshingAction:@selector(inner_Refresh)];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.items ||
        self.items.count == 0) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)inner_Refresh {
    __weak __typeof(self) weakSelf = self;
    [[UZSessionManager manager] requestLotteryNewsWithPageType:self.pageType
                                                       Success:^(NSArray *news, NSURLSessionDataTask *dataTask) {
                                                           weakSelf.items = news;
                                                           [weakSelf.tableView.mj_header endRefreshing];
                                                           [weakSelf.tableView reloadData];
                                                       } failure:^(NSError *error, NSURLSessionDataTask *dataTask) {
                                                           [weakSelf.tableView.mj_header endRefreshing];
                                                       }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UZLotteryNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UZLotteryNewsCell class])];
    cell.news = self.items[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UZLotteryDetailVC *detailVC = [[UZLotteryDetailVC alloc] init];
    UZLotteryNews *news = self.items[indexPath.row];
    detailVC.link = news.link;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end