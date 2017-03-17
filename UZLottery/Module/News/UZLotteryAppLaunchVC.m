//
//  UZLotteryAppLaunchVC.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryAppLaunchVC.h"
#import "UZSessionManager.h"
#import "UZLotteryAppLaunchMediaCell.h"
#import "UZLotteryMediaView.h"

@interface UZLotteryAppLaunchVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UZLotteryAppLaunch *appLaunch;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UZLotteryMediaView *launchMediaView;

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, weak) UIView *maskView;

@property (nonatomic, weak) UZLotteryMediaView *screenMediaView;

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
        //审核通过
        if (weakSelf.appLaunch.app_status) {
            [weakSelf inner_ConfigureShowLotteryLaunchScreenIntro:appLaunch];
        } else {
            [weakSelf.view removeFromSuperview];
        }
    } failure:^(NSError *error, NSURLSessionDataTask *dataTask) {
        [weakSelf hideWithAfterDelay:YES];
        [weakSelf.view removeFromSuperview];
    }];
    //网页
    UIView * top = [[UIView alloc] init];
    top.backgroundColor = [UIColor colorWithHexString:@"ec2828"];
    [self.view addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(20);
    }];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.hidden = YES;
    [self.view addSubview:webView];
    self.webView = webView;
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        
        make.left.right.bottom.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    //遮罩
    UIView *maskView = [[UIView alloc] init];
    maskView.hidden = YES;
    maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:.4f];
    [self.view addSubview:maskView];
    self.maskView = maskView;
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    //插屏图
    UZLotteryMediaView *screenMediaView = [[UZLotteryMediaView alloc] init];
    screenMediaView.imageScaleSize = CGSizeMake(SCREEN_WIDTH - 80,
                                                SCREEN_WIDTH - 80);
    screenMediaView.enableShowCloseBtn = YES;
    [screenMediaView setKCloseMediaBlock:^(UZLotteryMediaView *launchMediaView) {
        [UIView animateWithDuration:.5f
                         animations:^{
                             weakSelf.maskView.alpha = 0.f;
                         } completion:^(BOOL finished) {
                             [weakSelf.maskView removeFromSuperview];
                         }];
    }];
    [maskView addSubview:screenMediaView];
    self.screenMediaView = screenMediaView;
    [screenMediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(maskView);
        make.width.height.mas_equalTo(SCREEN_WIDTH - 80);
    }];
    //引导图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_Height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.hidden = YES;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[UZLotteryAppLaunchMediaCell class] forCellWithReuseIdentifier:NSStringFromClass([UZLotteryAppLaunchMediaCell class])];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    //开机图
    UZLotteryMediaView *launchMediaView = [[UZLotteryMediaView alloc] init];
    launchMediaView.hidden = YES;
    launchMediaView.enableShowCloseBtn = YES;
    launchMediaView.imageScaleSize = CGSizeMake(SCREEN_WIDTH,
                                                SCREEN_Height);
    [launchMediaView setKCloseMediaBlock:^(UZLotteryMediaView *launchMediaView) {
        [UIView animateWithDuration:.5
                         animations:^{
                             [weakSelf.launchMediaView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.edges.mas_equalTo(weakSelf.view).insets(UIEdgeInsetsMake(SCREEN_Height, 0, -SCREEN_Height, 0));
                             }];
                             [weakSelf.view layoutIfNeeded];
                         } completion:^(BOOL finished) {
                             [weakSelf.launchMediaView removeFromSuperview];
                         }];
    }];
    [self.view addSubview:launchMediaView];
    self.launchMediaView = launchMediaView;
    [launchMediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UZLotteryAppLaunchMediaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UZLotteryAppLaunchMediaCell class]) forIndexPath:indexPath];
    cell.media = self.appLaunch.intro[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.appLaunch.intro.count;
}

- (void)inner_ConfigureShowLotteryLaunchScreenIntro:(UZLotteryAppLaunch *)appLaunch {
    //显示开机图
    if (appLaunch.launch) {
        self.launchMediaView.hidden = NO;
        self.launchMediaView.media = appLaunch.launch;
    }
    //显示引导图
    if (appLaunch.intro &&
        appLaunch.intro.count > 0) {
        self.collectionView.hidden = NO;
        [self.collectionView reloadData];
    }
    //显示网页
    if (appLaunch.app_url &&
        appLaunch.app_url.length > 0) {
        self.webView.hidden = NO;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:appLaunch.app_url]]];
    }
    //显示插屏图
    if (appLaunch.screen) {
        self.maskView.hidden = NO;
        self.screenMediaView.media = appLaunch.screen;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ((scrollView.contentOffset.x + SCREEN_WIDTH) >= scrollView.contentSize.width && velocity.x > 0) {
        __weak __typeof(self) weakSelf = self;
        [UIView animateWithDuration:.5f
                         animations:^{
                             CGRect frame = weakSelf.view.frame;
                             frame.origin.x = -SCREEN_WIDTH;
                             weakSelf.collectionView.frame = frame;
                         } completion:^(BOOL finished) {
                             [weakSelf.collectionView removeFromSuperview];
                         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
