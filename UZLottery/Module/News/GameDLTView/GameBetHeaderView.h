//
//  GameBetHeaderView.h
//  CSLCPlay
//
//  Created by liwei on 15/10/10.
//  Copyright © 2015年 liwei. All rights reserved.

#import <UIKit/UIKit.h>

@interface GameBetHeaderView : UIView

@property (nonatomic, strong) UILabel *drawLabel, *timerLabel;
@property (nonatomic, strong) UIButton *shakeButton;
@property (nonatomic, strong) UILabel *introlLabel;

- (void)setupIntroLabelAttributedTextWithMoney:(NSString *)money;

@end
