//
//  BetFooterViewDelegate.h
//  CSLCPlay
//
//  Created by liwei on 15/12/28.
//  Copyright © 2015年 liwei. All rights reserved.
//

#ifndef BetFooterViewDelegate_h
#define BetFooterViewDelegate_h


@protocol BetFooterViewDelegate <NSObject>

@optional

/**左侧按钮事件*/
- (void)leftFooterButtonAction;

/**右侧按钮事件*/
- (void)rightFooterButtonAction;

/**获取倍数、追期*/
- (void)getMutiple:(NSString *)mutiple appendDraw:(NSString *)draw;

/**获取倍数、过关方式*/
- (void)getMutiple:(NSString *)mutiple formula:(NSString *)formula;

@end

#endif /* BetFooterViewDelegate_h */
