//
//  UZLotteryAppLaunchMediaCell.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/16.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryAppLaunchMediaCell.h"
#import "UZLotteryMediaView.h"

@interface UZLotteryAppLaunchMediaCell()

@property (nonatomic, weak) UZLotteryMediaView *launchMediaView;

@end

@implementation UZLotteryAppLaunchMediaCell

- (void)dealloc {
    _media = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UZLotteryMediaView *launchMediaView = [[UZLotteryMediaView alloc] init];
        launchMediaView.enableShowCloseBtn = NO;
        launchMediaView.imageScaleSize = CGSizeMake(SCREEN_WIDTH,
                                                    SCREEN_Height);
        [self.contentView addSubview:launchMediaView];
        self.launchMediaView = launchMediaView;
        [launchMediaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setMedia:(UZLotteryMedia *)media {
    if (!media) {
        return;
    }
    self.launchMediaView.media = media;
}

@end
