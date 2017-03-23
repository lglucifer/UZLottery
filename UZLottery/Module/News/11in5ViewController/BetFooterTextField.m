//
//  BetFooterTextField.m
//  CSLCPlay
//
//  Created by liwei on 15/12/26.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "BetFooterTextField.h"

@implementation BetFooterTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [UIColor blackColor];
        self.borderStyle = UITextBorderStyleNone;
        self.textAlignment = NSTextAlignmentCenter;
        self.adjustsFontSizeToFitWidth = YES;
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.cornerRadius = 4.f;
        
    }
    return self;
}

@end
