//
//  ODSSettingViewController.m
//  OneDaySeries
//
//  Created by TaoXinle on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSSettingViewController.h"


#import "ODSVersionViewController.h"
#import "SVProgressHUD.h"
#import "OSDWebViewController.h"
#import "SDImageCache.h"
@interface ODSSettingViewController ()
{
    NSInteger cacheSize;
}
@property (nonatomic,strong) UITableView * settingTableV;
@property (nonatomic,strong) NSArray * titleArray1;
@property (nonatomic,strong) NSArray * titleArray2;
@property (nonatomic,strong) NSArray * titleArray3;
@property (nonatomic, strong) NSString * currentCn;
@end

@implementation ODSSettingViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:240 alpha:1];
    self.title = @"设置";

    
    self.titleArray1 = [NSArray arrayWithObjects:@"清除缓存", nil];

    self.titleArray2 = [NSArray arrayWithObjects:@"意见反馈",@"版本信息",@"好评鼓励", nil];
    
    self.settingTableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //    self.tableview.rowHeight = 200;
    self.settingTableV.delegate = self;
    self.settingTableV.dataSource = self;
    self.settingTableV.backgroundColor = [UIColor clearColor];
    self.settingTableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.settingTableV];
    
    [self.settingTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view).mas_offset(0);
    }];

    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.titleArray1.count;
    } else {
        return self.titleArray2.count;
    }
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *settingIdentifier = @"seetingcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:settingIdentifier];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-50, 45)];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setTextColor:[UIColor colorWithWhite:100/255.0f alpha:1]];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:titleLabel];

    switch (indexPath.section) {
        case 0:
            titleLabel.text = [NSString stringWithFormat:@"清除缓存 (约%.2fM)",(double)cacheSize/1024/1024];
            break;
        case 1:
            titleLabel.text = [self.titleArray2 objectAtIndex:indexPath.row];
            break;
 
        default:
            break;
    }
    return cell;
    
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [SVProgressHUD showWithStatus:@"清理中..."];
        //        [[SDImageCache sharedImageCache] setMaxCacheSize:1];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [SVProgressHUD showSuccessWithStatus:@"清理完成"];
            [self calCacheSize];
        }];
    } else {
        if (indexPath.row==0) {
            OSDWebViewController *webVC = [[OSDWebViewController alloc] init];
            webVC.title = @"意见反馈";
            webVC.urlStr = @"http://form.mikecrm.com/atdxdE";
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];

        }
        else if (indexPath.row==1){
            ODSVersionViewController * versionV = [[ODSVersionViewController alloc] init];
            versionV.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:versionV animated:YES];
        } else if (indexPath.row == 2) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/shi-ci/id1084924739?l=zh&ls=1&mt=8"];
            if([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
    
        
    
}

-(void)calCacheSize
{
    cacheSize = [[SDImageCache sharedImageCache] getSize];
    [self.settingTableV reloadData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self calCacheSize];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
