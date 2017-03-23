//
//  11in5BetTypeSelectView.m
//  CSLCShop
//
//  Created by liwei on 15/7/20.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import "GP11in5GameTypeView.h"
#import "GP11in5Description.h"

@implementation CSLCSelectButton

+ (id)buttonWithType:(UIButtonType)buttonType
{
    static CSLCSelectButton *mySelf = nil;
    mySelf = [super buttonWithType:buttonType];
    if (mySelf) {
        mySelf.layer.borderColor = [[UIColor colorRGBWithRed:200.f green:200.f blue:200.f alpha:1.f] CGColor];
        mySelf.layer.borderWidth = 1.f;
        mySelf.layer.cornerRadius = 4.f;
        
        mySelf.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [mySelf setTitleColor:[UIColor colorRGBWithRed:177.f green:23.f blue:42.f alpha:1.f] forState:UIControlStateHighlighted];
    }
    return mySelf;
}

- (void)buttonControlStateNormal
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)buttonControlStateSelected
{
    [self setBackgroundColor:[UIColor colorRGBWithRed:177.f green:23.f blue:42.f alpha:1.f]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end

@implementation GP11in5GameTypeView

/**
 *	@brief	投注类型选择view
 *
 *	@return	view
 */
- (void)betTypeViewContainerTitle:(NSString *)title
{
    GP11in5Description *_11in5Desc = [[GP11in5Description alloc] init];
    
    self.backgroundColor = [UIColor colorWithHexString:@"E7E7E7"];
    
    UILabel *ptLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, 40.f, 22.f)];
    ptLabel.backgroundColor = [UIColor clearColor];
    ptLabel.font = [UIFont systemFontOfSize:14.f];
    ptLabel.textColor = [UIColor darkGrayColor];
    ptLabel.textAlignment = NSTextAlignmentCenter;
    ptLabel.adjustsFontSizeToFitWidth = YES;
    ptLabel.text = @"普通";
    [self addSubview:ptLabel];
    
    UIView *ptLineView = [[UIView alloc] initWithFrame:CGRectMake(50.f, 11.f, kScreenWidth-80.f, 0.8)];
    ptLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:ptLineView];
    
    CGSize size = CGSizeMake((kScreenWidth - 40.f)/3, 36.f);
    
    CSLCSelectButton *ptButton = nil;
    for (int i=0; i<4; i++) {
        for (int j=1; j<=3; j++) {
            int tag = i*3 + j;
            float btn_x = 5.f + size.width * (j - 1) + j * 5.f;
            float btn_y = CGRectGetMaxY(ptLabel.frame) + size.height*i + 10.f*i;
            ptButton = [CSLCSelectButton buttonWithType:UIButtonTypeCustom];
            ptButton.frame = CGRectMake(btn_x, btn_y, size.width, size.height);
            [ptButton setTitle:_11in5Desc.puTongNamesArr[tag-1] forState:UIControlStateNormal];
            [ptButton addTarget:self action:@selector(selectePtAction:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *ptTitle = [NSString stringWithFormat:@"%@-普通",ptButton.titleLabel.text];
            
            if ([ptTitle isEqualToString:title]) {
                [ptButton buttonControlStateSelected];
            }else {
                [ptButton buttonControlStateNormal];
            }
            
            [self addSubview:ptButton];
        }
    }
    
    CGFloat dtLable_y = CGRectGetMaxY(ptLabel.frame) + size.height*4 + 10.f*4;
    UILabel *dtLabel = [[UILabel alloc] initWithFrame:CGRectMake(ptLabel.frame.origin.x, dtLable_y, ptLabel.frame.size.width, ptLabel.frame.size.height)];
    dtLabel.backgroundColor = [UIColor clearColor];
    dtLabel.font = [UIFont systemFontOfSize:14.f];
    dtLabel.textColor = [UIColor darkGrayColor];
    dtLabel.textAlignment = NSTextAlignmentCenter;
    dtLabel.adjustsFontSizeToFitWidth = YES;
    
    dtLabel.text = @"胆拖";
    [self addSubview:dtLabel];
    
    UIView *dtLineView = [[UIView alloc] initWithFrame:CGRectMake(50.f, dtLable_y+11.f, ptLineView.frame.size.width, 1.f)];
    dtLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:dtLineView];
    
    CSLCSelectButton *dtButton = nil;
    for (int i=0; i<3; i++) {
        for (int j=1; j<=3; j++) {
            int tag = i*3 + j;
            if (tag < 9) {
                float btn_x = 5.f + size.width * (j - 1) + j * 5.f;
                float btn_y = CGRectGetMaxY(dtLabel.frame) + size.height*i + 10.f*i;
                dtButton = [CSLCSelectButton buttonWithType:UIButtonTypeCustom];
                dtButton.frame = CGRectMake(btn_x, btn_y, size.width, size.height);
                
                [dtButton setTitle:_11in5Desc.danTuoNamesArr[tag-1] forState:UIControlStateNormal];
                [dtButton addTarget:self action:@selector(selecteDtAction:) forControlEvents:UIControlEventTouchUpInside];
                
                NSString *dtTitle = [NSString stringWithFormat:@"%@-胆拖",dtButton.titleLabel.text];
                
                if ([dtTitle isEqualToString:title]) {
                    [dtButton buttonControlStateSelected];
                }else {
                    [dtButton buttonControlStateNormal];
                }
                
                [self addSubview:dtButton];
            }
            
        }
    }
}

- (void)selectePtAction:(UIButton *)button
{
    [_delegate ptGameTypeSelectedButton:button];
}

- (void)selecteDtAction:(UIButton *)button
{
    [_delegate dtGameTypeSelectedButton:button];
}

@end
