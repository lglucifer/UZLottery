//
//  BetFooterView.h
//  CSLCShop
//
//  Created by 李伟 on 15/2/9.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetFooterTextField.h"
#import "BetFooterButtonView.h"
#import "BetFooterViewDelegate.h"

//@interface BetFooterLabel : UILabel
//
//- (id)initWithFrame:(CGRect)frame;
//
//@end
//
//@protocol BetFooterViewDelegate <NSObject>
//
//@optional
//- (void)saveBetContentAction;
//- (void)setQREncoderAction;
//- (void)getMutiple:(NSString *)mutiple appendDraw:(NSString *)draw;
//@end

@interface BetFooterView : UIView <UITextFieldDelegate>
{
    CGRect viewFrame;
    UIButton *bgButton;
    UIView *inputView;
}

//@property (nonatomic, strong)   UILabel *moneyLabel;
//@property (nonatomic, strong)   UILabel *descLabel;
@property (nonatomic, strong)   BetFooterButtonView *btnView;
@property (nonatomic, assign)   CGFloat originY;
@property (nonatomic, strong)   BetFooterTextField *drawTextField;
@property (nonatomic, strong)   BetFooterTextField *multipleTextField;
@property (nonatomic, strong)   UIButton *appendButton;

@property (nonatomic) NSInteger maxBetCount;

@property (nonatomic, weak) id<BetFooterViewDelegate> delegate;

- (void)closeKeyboard;

- (void)setupDLTTextField;
- (void)setup11in5TextField;

@end
