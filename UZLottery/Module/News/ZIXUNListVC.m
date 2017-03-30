//
//  UZLotteryXuanhaoVC.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "ZIXUNListVC.h"
#import "UZLotteryXuanhaoDetailVC.h"
#import "UZLotteryXuanhaoCell.h"
#import "DLTViewController.h"
#import "KaijiangViewController.h"
#import "Game11in5ViewController.h"
//#import "UZLotteryNewsVC.h"
#import "WMPageController.h"
#import "UZFSTZXViewController.h"
#import "UZSECZXViewController.h"
#import "UZTRDZXViewController.h"
#import "UZFORZXViewController.h"

@interface ZIXUNListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ZIXUNListVC

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
    if (indexPath.section==0) {
        UZLotteryXuanhaoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UZLotteryXuanhaoCell class])];
        
        if (indexPath.row==0) {
            cell.icon.image = [UIImage imageNamed:@"shishicaiicon"];
            cell.titleLb.text = @"重庆时时彩";
            cell.titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        }
        else if (indexPath.row==1) {
            cell.icon.image = [UIImage imageNamed:@"shishicaiicon"];
            cell.titleLb.text = @"黑龙江时时彩";
            cell.titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        }
        else if (indexPath.row==2) {
            cell.icon.image = [UIImage imageNamed:@"shishicaiicon"];
            cell.titleLb.text = @"内蒙古时时彩";
            cell.titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        }
        else
        {
            cell.icon.image = [UIImage imageNamed:@"home_icon_20"];
            cell.titleLb.text = @"更多开奖信息敬请期待";
            cell.titleLb.textColor = [UIColor lightGrayColor];
        }
        return cell;
    }
    else{
        UZLotteryXuanhaoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UZLotteryXuanhaoCell class])];
        if (indexPath.row==0) {
            cell.icon.image = [UIImage imageNamed:@"zixund"];
            cell.titleLb.text = @"资讯信息";
            cell.titleLb.textColor = [UIColor colorWithRGB:0x2a2a2a];
        }

        
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"开奖信息";
    }
    else{
        return @"资讯";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 4;
    }
    else{
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    UZLotteryXuanhaoDetailVC *detailVC = [[UZLotteryXuanhaoDetailVC alloc] init];
    //    detailVC.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:detailVC animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            KaijiangViewController * dv = [[KaijiangViewController alloc] init];
            dv.hidesBottomBarWhenPushed = YES;
            dv.gamename = @"cqssc";
            [self.navigationController pushViewController:dv animated:YES];
        }
        else if (indexPath.row==1) {
                KaijiangViewController * dv = [[KaijiangViewController alloc] init];
                dv.hidesBottomBarWhenPushed = YES;
                dv.gamename = @"hljssc";
                [self.navigationController pushViewController:dv animated:YES];
            

        }
        else if (indexPath.row==2) {
            KaijiangViewController * dv = [[KaijiangViewController alloc] init];
            dv.hidesBottomBarWhenPushed = YES;
            dv.gamename = @"nmgssc";
            [self.navigationController pushViewController:dv animated:YES];
            
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"更多开奖资讯敬请期待..."
                                                           delegate:self
                                                  cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        if (indexPath.row==0) {
//            UZLotteryNewsVC * dv = [[UZLotteryNewsVC alloc] init];
//            dv.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:dv animated:YES];
            WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:@[[UZFSTZXViewController class], [UZSECZXViewController class], [UZTRDZXViewController class], [UZFORZXViewController class]] andTheirTitles:@[@"早间彩讯", @"中奖新闻", @"天选之子", @"彩民天地"]];
            pageVC.menuItemWidth = 85;
            pageVC.postNotification = YES;
            pageVC.bounces = YES;
            pageVC.preloadPolicy = WMPageControllerPreloadPolicyNever;
            pageVC.menuViewStyle = WMMenuViewStyleDefault;
            pageVC.titleSizeSelected = 20;
            pageVC.titleSizeNormal = 15;
            pageVC.titleColorSelected = [UIColor colorWithRGB:0xd81e06];
            pageVC.titleColorNormal = [UIColor colorWithRGB:0xdbdbdb];
            pageVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pageVC animated:YES];
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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
