//
//  KaijiangViewController.m
//  UZLottery
//
//  Created by Tolecen on 2017/3/17.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "KaijiangViewController.h"
#import "UZLotteryNewsCell.h"
#import "UZSessionManager.h"
#import "UZLotteryModel.h"
@interface KaijiangViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSArray *items;

@end

@implementation KaijiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80.f;
    tableView.tableFooterView = [[UIView alloc] init];
    [tableView registerClass:[UZLotteryNewsCell class] forCellReuseIdentifier:NSStringFromClass([UZLotteryNewsCell class])];
    [self.view addSubview:tableView];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                           refreshingAction:@selector(inner_Refresh)];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];

    [self inner_Refresh];
    // Do any additional setup after loading the view.
}

- (void)inner_Refresh {
    __weak __typeof(self) weakSelf = self;
    [[UZSessionManager manager] requestShishicaiKaijiangWithName:@"cqssc"
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
//    cell.news = self.items[indexPath.row];
    UZLotteryKaijiang * d = self.items[indexPath.row];
    cell.titleLb.text = [NSString stringWithFormat:@"第%@期 开奖号码%@",d.expect,d.opencode];
    cell.dateLb.text = [NSString stringWithFormat:@"开奖时间%@",d.opentime];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
