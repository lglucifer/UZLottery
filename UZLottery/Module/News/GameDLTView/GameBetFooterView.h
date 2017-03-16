//
//  BetFooterView.h
//  CSLCShop
//
//  Created by 李伟 on 15/2/9.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetFooterButtonView.h"
#import "BetFooterViewDelegate.h"

@interface GameBetFooterView : UIView

@property (nonatomic, strong)   id<BetFooterViewDelegate> delegate;
@property (nonatomic, strong)   BetFooterButtonView *btnView;
 
//@property (nonatomic, strong) UIButton *clearButton;
//@property (nonatomic, strong) UIButton *betListButton;
//
//@property (nonatomic, strong) UILabel *moneyLabel;

@end
