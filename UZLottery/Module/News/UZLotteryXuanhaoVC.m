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
#import "KaijiangViewController.h"
#import "Game11in5ViewController.h"
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
        if (indexPath.row==0) {
            cell.icon.image = [UIImage imageNamed:@"home_icon_10"];
            cell.titleLb.text = @"超级大乐透";
            cell.titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        }
    else if (indexPath.row==1) {
        cell.icon.image = [UIImage imageNamed:@"guangdong11in5"];
        cell.titleLb.text = @"11选5";
        cell.titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
    }
        else
        {
            cell.icon.image = [UIImage imageNamed:@"home_icon_20"];
            cell.titleLb.text = @"更多游戏选号敬请期待";
            cell.titleLb.textColor = [UIColor lightGrayColor];
        }

        return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

        if (indexPath.row==0) {
            DLTViewController * dv = [[DLTViewController alloc] init];
            dv.isHomePush = YES;
            dv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dv animated:YES];
        }
        else if (indexPath.row==1) {
//            KaijiangViewController * dv = [[KaijiangViewController alloc] init];
//            dv.hidesBottomBarWhenPushed = YES;
//            dv.gamename = @"hljssc";
//            [self.navigationController pushViewController:dv animated:YES];
            
            Game11in5ViewController * dv = [[Game11in5ViewController alloc] init];
            dv.isHomePush = YES;
            dv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dv animated:YES];
        }
        else{
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
