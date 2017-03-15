//
//  UZLotteryDetailVC.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryDetailVC.h"

@interface UZLotteryDetailVC ()

@end

@implementation UZLotteryDetailVC

- (void)dealloc {
    _link = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
