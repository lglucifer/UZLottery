//
//  BetFooterView.m
//  CSLCShop
//
//  Created by 李伟 on 15/2/9.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import "BetFooterView.h"
#import "SVProgressHUD.h"

//@implementation BetFooterLabel
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor clearColor];
//        self.font = [UIFont systemFontOfSize:14.f];
//        self.textAlignment = NSTextAlignmentCenter;
//        self.textColor = [UIColor blackColor];
//        self.adjustsFontSizeToFitWidth = YES;
//    }
//    return self;
//}
//
//@end

@implementation BetFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
        
        bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(0, 0, kScreenWidth, 0);
        bgButton.backgroundColor = [UIColor darkGrayColor];
        bgButton.alpha = 0;
        [bgButton addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [window addSubview:bgButton];
        
        //----
        self.backgroundColor = [UIColor clearColor];
        viewFrame = self.frame;
        
        //--- 追号/倍投
        inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40.f)];
        inputView.backgroundColor = [UIColor colorRGBWithRed:220.f green:220.f blue:220.f alpha:1.f];
        [self addSubview:inputView];
        
        //--
        
    }
    return self;
}

- (void)setupDLTTextField
{
    CGFloat inputViewHeight = inputView.frame.size.height;
    CGFloat textFieldHeight = 30.f;
    CGFloat textFieldY = (inputViewHeight - textFieldHeight)/2;
    
    //顶部横线
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, inputView.frame.size.width, 1.f)];
    topLineView.backgroundColor = [UIColor colorRGBWithRed:199.f green:199.f blue:194.f alpha:1.f];
    [inputView addSubview:topLineView];
    
    CGFloat labelW = 22.f;
    CGFloat textWidth = (kScreenWidth-120.f-labelW*4-5)/2;
    //倍投
    BetFooterLabel *label3 = [[BetFooterLabel alloc] initWithFrame:CGRectMake(15.f, 0, labelW, inputViewHeight)];
    label3.text = @"投";
    [inputView addSubview:label3];
    
    _multipleTextField = [[BetFooterTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), textFieldY, textWidth, textFieldHeight)];
    _multipleTextField.text = @"1";
    _multipleTextField.delegate = self;
    _multipleTextField.tag = 101;
    [inputView addSubview:_multipleTextField];
    
    BetFooterLabel *label33 = [[BetFooterLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_multipleTextField.frame), 0, labelW, inputViewHeight)];
    label33.text = @"倍";
    [inputView addSubview:label33];
    
    //追号
    BetFooterLabel *label1 = [[BetFooterLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label33.frame)+4.f, 0, labelW, inputViewHeight)];
    label1.text = @"追";
    [inputView addSubview:label1];
    
    _drawTextField = [[BetFooterTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), textFieldY, textWidth, textFieldHeight)];
    _drawTextField.text = @"1";
    _drawTextField.delegate = self;
    _drawTextField.tag = 100;
    [inputView addSubview:_drawTextField];
    
    BetFooterLabel *label2 = [[BetFooterLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_drawTextField.frame), 0, labelW, inputViewHeight)];
    label2.text = @"期";
    [inputView addSubview:label2];
    
    //中间竖线
    UIView *midLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), 0, 1.f, inputViewHeight)];
    midLineView.backgroundColor = [UIColor colorRGBWithRed:199.f green:199.f blue:194.f alpha:1.f];
    [inputView addSubview:midLineView];
    
    //--追加
    _appendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _appendButton.frame = CGRectMake(kScreenWidth - 120.f, 0, 120.f, inputViewHeight);
    [_appendButton setTitle:@" 追加投注" forState:UIControlStateNormal];
    [_appendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _appendButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    _appendButton.backgroundColor = [UIColor clearColor];
    [inputView addSubview:_appendButton];
    
    [self setupButton];
}

- (void)setup11in5TextField
{
    CGFloat filedWidth = kScreenWidth/2;
    
    //顶部横线
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, inputView.frame.size.width, 1.f)];
    topLineView.backgroundColor = [UIColor colorRGBWithRed:199.f green:199.f blue:194.f alpha:1.f];
    [inputView addSubview:topLineView];
    
    //中间竖线
    UIView *midLineView = [[UIView alloc] initWithFrame:CGRectMake(filedWidth-1.f, 0, 1.f, inputView.frame.size.height)];
    midLineView.backgroundColor = [UIColor colorRGBWithRed:199.f green:199.f blue:194.f alpha:1.f];
    [inputView addSubview:midLineView];
    
    CGFloat labelW = 18.f;
    
    //倍投
    BetFooterLabel *label3 = [[BetFooterLabel alloc] initWithFrame:CGRectMake(15.f, 0, labelW, inputView.frame.size.height)];
    label3.text = @"投";
    [inputView addSubview:label3];
    
    _multipleTextField = [[BetFooterTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), 5.f, filedWidth - 56.f, 30.f)];
    _multipleTextField.text = @"1";
    _multipleTextField.delegate = self;
    _multipleTextField.tag = 101;
    [inputView addSubview:_multipleTextField];
    
    BetFooterLabel *label33 = [[BetFooterLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_multipleTextField.frame), 0, labelW, inputView.frame.size.height)];
    label33.text = @"倍";
    [inputView addSubview:label33];
    
    //追号
    BetFooterLabel *label1 = [[BetFooterLabel alloc] initWithFrame:CGRectMake(filedWidth+4.f, 0, labelW, inputView.frame.size.height)];
    label1.text = @"追";
    [inputView addSubview:label1];
    
    _drawTextField = [[BetFooterTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 5.f, filedWidth - 56.f, 30.f)];
    _drawTextField.text = @"1";
    _drawTextField.delegate = self;
    _drawTextField.tag = 100;
    [inputView addSubview:_drawTextField];
    
    BetFooterLabel *label2 = [[BetFooterLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_drawTextField.frame), 0, labelW, inputView.frame.size.height)];
    label2.text = @"期";
    [inputView addSubview:label2];

    [self setupButton];
}

- (void)setupButton
{
    //---
    
    _btnView =  [[BetFooterButtonView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(inputView.frame), kScreenWidth, 50.f)];
    [self addSubview:_btnView];
    
    [_btnView.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_btnView.saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnView.qrCodeButton setTitle:@"去扫码" forState:UIControlStateNormal];
    [_btnView.qrCodeButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
//    CGFloat btnW = 50.f;
//    if (iPhone6) {
//        btnW = 50.f * 1.5;
//    }
//    if (iPhone6Plus) {
//        btnW = 50.f * 1.5;
//    }
//    
//    CGFloat btnY = 7.f;
//    CGFloat btnHeight = 36.f;
//    
//    //---- 保存
//    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    saveButton.frame = CGRectMake(15.f, btnY, btnW, btnHeight);
//    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
//    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    saveButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
//    saveButton.backgroundColor = [UIColor colorRGBWithRed:106.f green:106.f blue:106.f alpha:1.f];
//    saveButton.layer.cornerRadius = 4;
//    [saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [btnView addSubview:saveButton];
//    
//    //---- 生成二维码
//    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    sureButton.frame = CGRectMake(self.frame.size.width - btnW - 25.f, btnY, btnW+15.f, btnHeight);
//    [sureButton setTitle:MyLocalizedString(@"去扫码") forState:UIControlStateNormal];
//    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    sureButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
//    sureButton.backgroundColor = [UIColor colorRGBWithRed:189.f green:40.f blue:57.f alpha:1.f];
//    sureButton.layer.cornerRadius = 4;
//    [sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [btnView addSubview:sureButton];
//    
//    //金额/注数
//    CGFloat moneyLW = kScreenWidth - (CGRectGetMaxX(saveButton.frame) + btnW + 50.f);
//    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-moneyLW)/2, 3.f, moneyLW, btnView.frame.size.height-6.f)];
//    _moneyLabel.backgroundColor = [UIColor clearColor];
//    _moneyLabel.textColor = [UIColor whiteColor];
//    _moneyLabel.font = [UIFont systemFontOfSize:16.f];
//    _moneyLabel.textAlignment = NSTextAlignmentCenter;
//    _moneyLabel.adjustsFontSizeToFitWidth = YES;
//    [btnView addSubview:_moneyLabel];
//    
//    //公益券
//    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(_moneyLabel.frame.origin.x, CGRectGetMaxY(_moneyLabel.frame), _moneyLabel.frame.size.width, btnView.frame.size.height/2 - 10.f)];
//    _descLabel.backgroundColor = [UIColor clearColor];
//    _descLabel.textColor = [UIColor whiteColor];
//    _descLabel.font = [UIFont systemFontOfSize:12.f];
//    _descLabel.textAlignment = NSTextAlignmentCenter;
//    _descLabel.adjustsFontSizeToFitWidth = YES;
//    //[btnView addSubview:_descLabel];
}

- (void)saveButtonAction
{
    [_delegate leftFooterButtonAction];
}

- (void)sureButtonAction
{
    [_delegate rightFooterButtonAction];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if (range.location >= 3) {
//        return NO;
//    }
    return YES;
}

- (void)doneButtonAction
{
    NSString *mutiple = _multipleTextField.text;
    NSString *draw = _drawTextField.text;
    if ([_multipleTextField.text intValue] == 0) {
        _multipleTextField.text = @"1";
    }else{
        _multipleTextField.text = mutiple;
    }
    if ([_drawTextField.text intValue] == 0) {
        _drawTextField.text = @"1";
    }else{
        _drawTextField.text = draw;
    }
    
    if (!self.maxBetCount || self.maxBetCount==0) {
        self.maxBetCount = 999;
    }
    
    if ([_multipleTextField.text intValue]>self.maxBetCount) {
        _multipleTextField.text = [NSString stringWithFormat:@"%d",(int)self.maxBetCount];
        //            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"最大允许投注%d倍",(int)self.maxBetCount] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        //            [alert show];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最大允许投注%d倍",(int)self.maxBetCount]];
    }
    
    [_delegate getMutiple:_multipleTextField.text appendDraw:_drawTextField.text];
    
    [self closeKeyboard];
}

/**
 *	显示键盘
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    NSDictionary *dic = [note userInfo];
    CGRect keyRect = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    [UIView animateWithDuration:0.1
//                     animations:^{
                         CGFloat bgHeight = kScreenHeight - keyRect.size.height - viewFrame.size.height + 50.f;
                         CGRect rect = self.frame;
                         rect.origin.y = bgHeight - 64.f;
                         self.frame = rect;
                         
//                         CGRect bRect = bgButton.frame;
//                         bRect.size.height = bgHeight;
//                         bgButton.frame = bRect;
//                         
//                         bgButton.alpha = 0.5;
//                     }];
}

-(void)keyboardDidShow:(NSNotification *)note
{
    NSDictionary *dic = [note userInfo];
    CGRect keyRect = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat bgHeight = kScreenHeight - keyRect.size.height - viewFrame.size.height + 50.f;
    CGRect bRect = bgButton.frame;
    bRect.size.height = bgHeight;
    bgButton.frame = bRect;
    [UIView animateWithDuration:0.1 animations:^{
        bgButton.alpha = 0.5;
    }];
    
}


/**
 *	隐藏键盘
 */
- (void)closeKeyboard
{
    for (id object in [inputView subviews]) {
        if ([object isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)object;
            [textField resignFirstResponder];
        }
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        CGRect rect = self.frame;
        rect.origin.y =  viewFrame.origin.y;
        self.frame = rect;
        
        bgButton.alpha = 0;
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }];
    
    //
}


@end
