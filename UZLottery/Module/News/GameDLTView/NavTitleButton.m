//
//  NavTitleView.m
//  CSLCPlay
//
//  Created by liwei on 15/12/22.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "NavTitleButton.h"

@implementation NavTitleButton

+ (id)buttonWithType:(UIButtonType)buttonType
{
    static NavTitleButton *mySelf = nil;
    mySelf = [super buttonWithType:buttonType];
    if (mySelf) {
        mySelf.frame = CGRectMake((kScreenWidth - 140.f)/2 + 10.f, 0, 140.f, 44.f);
        mySelf.enabled = YES;
        [mySelf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        mySelf.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
        mySelf.titleLabel.textAlignment = NSTextAlignmentLeft;
        mySelf.titleEdgeInsets = UIEdgeInsetsMake(0, -55.f, 0, 0);
        mySelf.imageEdgeInsets = UIEdgeInsetsMake(0, 115.f, 0, 0);
    }
    return mySelf;
}

- (void)openButtonImage
{
    [self setImage:[UIImage imageNamed:@"open_button_icon"] forState:UIControlStateNormal];
}

- (void)closeButtonImage
{
    [self setImage:[UIImage imageNamed:@"close_button_icon"] forState:UIControlStateNormal];
}

@end
