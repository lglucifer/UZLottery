//
//  DisplaySelectNumberView.m
//  CSLCPlay
//
//  Created by liwei on 15/11/23.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "PreviewNumbersView.h"

static CGFloat numNameLabelFront = 13.f;
static CGFloat numLabelFront = 14.f;

@implementation PreviewNumbersView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        labelHeight = 20.f;
        label1w = 50.f;
        label2w = self.frame.size.width - 60.f;
        label2X = label1w + 2.f;
    }
    return self;
}


- (CGFloat)removeNumbersLabel
{
    for (id object in [self subviews]) {
        if ([object isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)object;
            [label removeFromSuperview];
        }
    }
    return 0;
}
#pragma mark - 显示号码球样式
/**大乐透单式、复式, 返回self高度*/
- (CGFloat)displayDLTPutongFront:(NSString *)front back:(NSString *)back
{
    for (id object in [self subviews]) {
        if ([object isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)object;
            [label removeFromSuperview];
        }
    }
    
    //-----计算label高度
    CGFloat frontTextheight = 0;
    CGRect fronTextRect = [front boundingRectWithSize:CGSizeMake(label2w, 100.f) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:numLabelFront]} context:nil];
    if (fronTextRect.size.height <= labelHeight) {
        frontTextheight = labelHeight;
    }else{
        frontTextheight = fronTextRect.size.height+2.f;
    }
    
    CGFloat backTextheight = 0;
    CGRect backTextRect = [back boundingRectWithSize:CGSizeMake(label2w, 100.f) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:numLabelFront]} context:nil];
    if (backTextRect.size.height <= labelHeight) {
        backTextheight = labelHeight;
    }else{
        backTextheight = backTextRect.size.height;
    }
    
    //----- 前区
    UILabel *frontNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, label1w, labelHeight)];
    frontNameLabel.backgroundColor = [UIColor clearColor];
    frontNameLabel.text = @"前区:";
    frontNameLabel.textColor = [UIColor blackColor];
    frontNameLabel.font = [UIFont systemFontOfSize:numNameLabelFront];
    frontNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:frontNameLabel];
    
    UILabel *frontLabel = [[UILabel alloc] initWithFrame:CGRectMake(label2X, 0, label2w, frontTextheight)];
    frontLabel.numberOfLines = 4;
    frontLabel.backgroundColor = [UIColor clearColor];
    frontLabel.textAlignment = NSTextAlignmentLeft;
    frontLabel.font = [UIFont systemFontOfSize:numLabelFront];
    frontLabel.textColor = kDisplayRedBallColor;
    frontLabel.text = front;
    [self addSubview:frontLabel];
    
    //-----后区
    UILabel *backNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frontTextheight, label1w, labelHeight)];
    backNameLabel.backgroundColor = [UIColor clearColor];
    backNameLabel.text = @"后区:";
    backNameLabel.textColor = [UIColor blackColor];
    backNameLabel.font = [UIFont systemFontOfSize:numNameLabelFront];
    backNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:backNameLabel];
    
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(label2X, frontTextheight, label2w, backTextheight)];
    backLabel.numberOfLines = 2;
    backLabel.backgroundColor = [UIColor clearColor];
    backLabel.textAlignment = NSTextAlignmentLeft;
    backLabel.font = [UIFont systemFontOfSize:numLabelFront];
    backLabel.textColor = kDisplayBlueBallColor;
    backLabel.text = back;
    [self addSubview:backLabel];
    
    //---
    CGFloat height = 0;
    height = frontTextheight + backTextheight;

    UILabel *linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 0.8)];
    linelabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:linelabel];
    
    return height;
}

/**大乐透胆拖, 返回self高度*/
- (CGFloat)displayDLTDantuoNumbersFrontDan:(NSString *)frontDan frontTuo:(NSString *)frontTuo backDan:(NSString *)backDan backTuo:(NSString *)backTuo
{
    for (id object in [self subviews]) {
        if ([object isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)object;
            [label removeFromSuperview];
        }
    }
    //-----计算拖码高度
    CGFloat frontTextheight = 0;
    CGRect fronTextRect = [frontTuo boundingRectWithSize:CGSizeMake(label2w, 100.f) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:numLabelFront]} context:nil];
    if (fronTextRect.size.height <= labelHeight) {
        frontTextheight = labelHeight;
    }else{
        frontTextheight = fronTextRect.size.height;
    }
    
    CGFloat backTextheight = 0;
    CGRect backTextRect = [backTuo boundingRectWithSize:CGSizeMake(label2w, 100.f) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:numLabelFront]} context:nil];
    if (backTextRect.size.height <= labelHeight) {
        backTextheight = labelHeight;
    }else{
        backTextheight = backTextRect.size.height;
    }
    
    //-----前区胆
    UILabel *frontDanNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, label1w, labelHeight)];
    frontDanNameLabel.backgroundColor = [UIColor clearColor];
    frontDanNameLabel.text = @"前区胆:";
    frontDanNameLabel.textColor = [UIColor blackColor];
    frontDanNameLabel.font = [UIFont systemFontOfSize:numNameLabelFront];
    frontDanNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:frontDanNameLabel];
    
    UILabel *frontDanLabel = [[UILabel alloc] initWithFrame:CGRectMake(label2X, 0, label2w, labelHeight)];
    frontDanLabel.numberOfLines = 4;
    frontDanLabel.backgroundColor = [UIColor clearColor];
    frontDanLabel.textAlignment = NSTextAlignmentLeft;
    frontDanLabel.font = [UIFont systemFontOfSize:numLabelFront];
    frontDanLabel.textColor = kDisplayRedBallColor;
    frontDanLabel.text = frontDan;
    [self addSubview:frontDanLabel];
    
    //-----前区拖
    UILabel *frontNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, labelHeight, label1w, labelHeight)];
    frontNameLabel.backgroundColor = [UIColor clearColor];
    frontNameLabel.text = @"前区拖:";
    frontNameLabel.textColor = [UIColor blackColor];
    frontNameLabel.font = [UIFont systemFontOfSize:numNameLabelFront];
    frontNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:frontNameLabel];
    
    UILabel *frontLabel = [[UILabel alloc] initWithFrame:CGRectMake(label2X, labelHeight, label2w, frontTextheight)];
    frontLabel.numberOfLines = 6;
    frontLabel.backgroundColor = [UIColor clearColor];
    frontLabel.textAlignment = NSTextAlignmentLeft;
    frontLabel.font = [UIFont systemFontOfSize:numLabelFront];
    frontLabel.textColor = kDisplayRedBallColor;
    frontLabel.text = frontTuo;
    [self addSubview:frontLabel];
    
    //-----后区胆
    CGFloat backDanLY = labelHeight + frontTextheight;
    UILabel *backDanNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, backDanLY, label1w, labelHeight)];
    backDanNameLabel.backgroundColor = [UIColor clearColor];
    backDanNameLabel.text = @"后区胆:";
    backDanNameLabel.textColor = [UIColor blackColor];
    backDanNameLabel.font = [UIFont systemFontOfSize:numNameLabelFront];
    backDanNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:backDanNameLabel];
    
    UILabel *backDanLabel = [[UILabel alloc] initWithFrame:CGRectMake(label2X, backDanLY, label2w, labelHeight)];
    backDanLabel.numberOfLines = 2;
    backDanLabel.backgroundColor = [UIColor clearColor];
    backDanLabel.textAlignment = NSTextAlignmentLeft;
    backDanLabel.font = [UIFont systemFontOfSize:numLabelFront];
    backDanLabel.textColor = kDisplayBlueBallColor;
    backDanLabel.text = backDan;
    [self addSubview:backDanLabel];
    
    //-----后区拖
    CGFloat backTuoLY = labelHeight + frontTextheight + labelHeight;
    UILabel *backNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, backTuoLY, label1w, labelHeight)];
    backNameLabel.backgroundColor = [UIColor clearColor];
    backNameLabel.text = @"后区拖:";
    backNameLabel.textColor = [UIColor blackColor];
    backNameLabel.font = [UIFont systemFontOfSize:numNameLabelFront];
    backNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:backNameLabel];
    
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(label2X, backTuoLY, label2w, backTextheight)];
    backLabel.numberOfLines = 2;
    backLabel.backgroundColor = [UIColor clearColor];
    backLabel.textAlignment = NSTextAlignmentLeft;
    backLabel.font = [UIFont systemFontOfSize:numLabelFront];
    backLabel.textColor = kDisplayBlueBallColor;
    backLabel.text = backTuo;
    [self addSubview:backLabel];
    
    //---
    CGFloat height = 0;
    height = frontTextheight + backTextheight + labelHeight*2;
    
    UILabel *linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 0.8)];
    linelabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:linelabel];
    
    return height;
}

@end
