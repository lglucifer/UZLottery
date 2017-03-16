//
//  DisplaySelectNumberView.h
//  CSLCPlay
//
//  Created by liwei on 15/11/23.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewNumbersView : UIView
{
    CGFloat labelHeight;
    CGFloat label1w;
    CGFloat label2w;
    CGFloat label2X;
}

/**移除号码, 返回self高度*/
- (CGFloat)removeNumbersLabel;

/**大乐透单式、复式, 返回self高度*/
- (CGFloat)displayDLTPutongFront:(NSString *)front back:(NSString *)back;

/**大乐透胆拖, 返回self高度*/
- (CGFloat)displayDLTDantuoNumbersFrontDan:(NSString *)frontDan frontTuo:(NSString *)frontTuo backDan:(NSString *)backDan backTuo:(NSString *)backTuo;

@end
