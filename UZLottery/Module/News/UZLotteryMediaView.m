//
//  UZLotteryMediaView.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/15.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZLotteryMediaView.h"
#import "UIImage+Scale.h"

@interface UZLotteryMediaView()

@property (nonatomic, weak) UIImageView *imageV;

@property (nonatomic, weak) UIButton *closeBtn;

@end

@implementation UZLotteryMediaView

- (void)dealloc {
    _kCloseMediaBlock = nil;
    _media = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = YES;
        [self addSubview:imageV];
        self.imageV = imageV;
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(inner_TapMedia:)];
        [self.imageV addGestureRecognizer:tapGesture];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
        closeBtn.hidden = YES;
        [closeBtn addTarget:self action:@selector(inner_Close:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        self.closeBtn = closeBtn;
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-10);
            make.top.mas_equalTo(self).mas_offset(10);
            make.width.height.mas_equalTo(25);
        }];
    }
    return self;
}

- (void)setMedia:(UZLotteryMedia *)media {
    if (!media) {
        return;
    }
    _media = media;
    __weak __typeof(self) weakSelf = self;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:media.img]
                   placeholderImage:nil
                          completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                              if ([imageURL.absoluteString isEqualToString:media.img]) {
                                  UIImage *newImage = [UIImage scaleImage:image size:weakSelf.imageScaleSize];
                                  weakSelf.imageV.image = newImage;
                              }
                          }];
    if (media.can_close &&
        self.enableShowCloseBtn) {
        self.closeBtn.hidden = NO;
    }
}

- (void)inner_TapMedia:(UITapGestureRecognizer *)tapGesture {
    if (!self.media.url ||
        self.media.url.length == 0) {
        return;
    }
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.media.url]
                                           options:@{}
                                 completionHandler:nil];
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= 100000
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.media.url]];
#endif
    }
}

- (void)inner_Close:(UIButton *)sender {
    if (self.kCloseMediaBlock) {
        self.kCloseMediaBlock(self);
    }
}

@end
