//
//  11in5BetTypeSelectView.h
//  CSLCShop
//
//  Created by liwei on 15/7/20.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLCSelectButton : UIButton

- (void)buttonControlStateNormal;
- (void)buttonControlStateSelected;

@end


@protocol GP11in5GameTypeViewDelegate <NSObject>

- (void)ptGameTypeSelectedButton:(UIButton *)button;
- (void)dtGameTypeSelectedButton:(UIButton *)button;

@end

@interface GP11in5GameTypeView : UIView

@property (nonatomic, weak) id<GP11in5GameTypeViewDelegate> delegate;

- (void)betTypeViewContainerTitle:(NSString *)title;

@end
