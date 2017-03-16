//
//  UZLotteryXuanhaoVC.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryXuanhaoVC.h"
#import "UZLotteryXuanhaoDetailVC.h"
#import "UZLotteryXuanhaoCell.h"
#import "DLTViewController.h"
@interface UZLotteryXuanhaoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation UZLotteryXuanhaoVC

- (NSString *)title {
    return self.tabBarItem.title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100.f;
    tableView.tableFooterView = [[UIView alloc] init];
    [tableView registerClass:[UZLotteryXuanhaoCell class] forCellReuseIdentifier:NSStringFromClass([UZLotteryXuanhaoCell class])];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UZLotteryXuanhaoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UZLotteryXuanhaoCell class])];
    cell.lotteryType = indexPath.row == 0 ? UZLotteryType_DaLeTou : UZLotteryType_11xuan5;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UZLotteryXuanhaoDetailVC *detailVC = [[UZLotteryXuanhaoDetailVC alloc] init];
//    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
    if (indexPath.row==0) {
        DLTViewController * dv = [[DLTViewController alloc] init];
        dv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dv animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"更多游戏选号敬请期待..."
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
