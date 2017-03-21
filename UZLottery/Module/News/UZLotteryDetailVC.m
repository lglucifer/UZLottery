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
//    _link = nil;
    _news = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"详情";
//    UIWebView *webView = [[UIWebView alloc] init];
//    webView.scalesPageToFit = YES;
//    [self.view addSubview:webView];
//    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
//    }];
//    NSArray * ui = [self.link componentsSeparatedByString:@"/"];
//    NSArray * g = [[ui lastObject] componentsSeparatedByString:@"."];
//    
//    NSString * s = [NSString stringWithFormat:@"http://3g.163.com/touch/article.html?channel=caipiao&child=all&offset=4&docid=%@",[g firstObject]];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:s]]];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.f;
    style.firstLineHeadIndent = 20.f;
    UILabel *textLb = [[UILabel alloc] init];
    textLb.numberOfLines = 0;
    textLb.attributedText = [[NSAttributedString alloc] initWithString:self.news.content
                                                            attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                                                         NSForegroundColorAttributeName: [UIColor colorWithRGB:0x333333],
                                                                         NSParagraphStyleAttributeName: style}];
    textLb.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
    [scrollView addSubview:textLb];

    if (self.news.topimageurl &&
        self.news.topimageurl.length > 0) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.news.topimageurl] placeholderImage:nil];
        [scrollView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(scrollView).mas_offset(10);
            make.centerX.equalTo(scrollView);
            make.width.mas_equalTo(SCREEN_WIDTH - 20);
            make.height.mas_equalTo((SCREEN_WIDTH - 20) / 2);
        }];
        
        [textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageV.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(scrollView).mas_offset(10);
            make.right.mas_equalTo(scrollView).mas_offset(-10);
            make.bottom.mas_equalTo(scrollView).mas_offset(-20);
        }];
    } else {
        [textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(scrollView).mas_offset(20);
            make.left.mas_equalTo(scrollView).mas_offset(10);
            make.right.mas_equalTo(scrollView).mas_offset(-10);
            make.bottom.mas_equalTo(scrollView).mas_offset(-20);
        }];
    }
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 54.f, 40.f);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50.f - 20.f);
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2.f, 0, 0);
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *  backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;

}
-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
