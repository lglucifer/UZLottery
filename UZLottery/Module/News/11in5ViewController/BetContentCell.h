//
//  BetContentCell.h
//  CSLCPlay
//
//  Created by liwei on 15/10/13.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BetContentCellDelegate <NSObject>

- (void)delCellButton:(UIButton *)button;

@end


@interface BetContentCell : UITableViewCell
{
    UIImageView *lineImageView;
}

@property (nonatomic, strong)   UIButton *delButton;
@property (nonatomic, strong)   UILabel *numbersLabel;
@property (nonatomic, strong)   UILabel *descLabel;

@property (nonatomic, weak) id<BetContentCellDelegate> delegate;


- (CGFloat)cellHeight;

@end
