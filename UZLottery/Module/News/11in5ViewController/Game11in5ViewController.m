//
//  Game11in5ViewController.m
//  CSLCPlay
//
//  Created by liwei on 15/10/8.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "Game11in5ViewController.h"


#import "G11in5NumbersTableView.h"
#import "GP11in5GameTypeView.h"
#import "GameBetHeaderView.h"
#import "GameBetFooterView.h"

#import "ReplaceOfString.h"
#import "CombineArithmetic.h"
#import "APPFaceSharingView.h"
#import "ReplaceOfString.h"
//#import "Game11in5Draw.h"
//#import "GameDrawDao.h"
//#import "GameDrawModel.h"

#import "NavTitleButton.h"

#define DisplayBetInfo(B, M)  [NSString stringWithFormat:@"共%@注 %@元", B, M]




@interface Game11in5ViewController () <GP11in5GameTypeViewDelegate, GameNumbersTableViewDelegate, BetFooterViewDelegate, UIAlertViewDelegate>
{
    float  selectBetTypeDurationTime;
//    NSString  *openBetTypeImage;
//    NSString  *closeBetTypeImage;
}

@property (nonatomic, assign) BOOL isDanTuo;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NavTitleButton *titleButton;
@property (nonatomic, strong) G11in5NumbersTableView *g11in5View;
@property (nonatomic, strong) GP11in5GameTypeView *betTypeView;
@property (nonatomic, strong) GameBetHeaderView *gameHeaderView;
@property (nonatomic, strong) GameBetFooterView *footerView;

@property (nonatomic, strong) GP11in5Description *gameDescription;



@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, strong) NSArray   *numberArr1;
@property (nonatomic, strong) NSArray   *numberArr2;
@property (nonatomic, strong) NSArray   *numberArr3;


@property (nonatomic, assign) NSInteger betCount;

@end

@implementation Game11in5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kBackgroundGlobalDarkColor;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 54.f, 40.f);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50.f - 20.f);
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2.f, 0, 0);
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *  backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;


    selectBetTypeDurationTime = 0.2;
//    openBetTypeImage = @"prov_selcte_icon_close";
//    closeBetTypeImage = @"prov_selcte_icon";
    
    _gameDescription = [[GP11in5Description alloc] init];

    // 支持shake
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    //
    if (_isHomePush == YES) {
        [self delAllTicketInfoData];

    }
    if (_isHomePush == NO) {
       
        
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.frame = CGRectMake(0, 0, 54.f, 40.f);
//        backButton.backgroundColor = [UIColor clearColor];
//        [backButton setTitle:@"取消" forState:UIControlStateNormal];
//        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        backButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
//        [backButton addTarget:self action:@selector(backButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        self.navigationItem.leftBarButtonItem = backBarButtonItem;
    }

    
    //title 标题
    _titleButton = [NavTitleButton buttonWithType:UIButtonTypeCustom];
    [_titleButton closeButtonImage];
//    _titleButton.frame = CGRectMake((self.view.frame.size.width - 140.f)/2 + 10.f, 0, 140.f, 44.f);
//    _titleButton.enabled = YES;
//
//    [_titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.f];
//    _titleButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [_titleButton setImage:[UIImage imageNamed:closeBetTypeImage] forState:UIControlStateNormal];
//    _titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -55.f, 0, 0);
//    _titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 115.f, 0, 0);
    [_titleButton addTarget:self action:@selector(betTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_titleButton];
    
    //------
    _gameHeaderView = [[GameBetHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70.f)];
    [_gameHeaderView.shakeButton addTarget:self action:@selector(shakeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_gameHeaderView];

    //
    //----- 选号界面
    CGFloat tvHeight = kScreenHeight - 64.f - 50.f;
    _g11in5View = [[G11in5NumbersTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_gameHeaderView.frame), kScreenWidth, tvHeight - 70.f)];
    _g11in5View.delegate = self;
    [self.view addSubview:_g11in5View];

    //底部view，包括清空、机选、保存
    _footerView = [[GameBetFooterView alloc] initWithFrame:CGRectMake(0, tvHeight, kScreenWidth, 50.f)];
    _footerView.delegate = self;
//    [_footerView.clearButton addTarget:self action:@selector(clearButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [_footerView.betListButton addTarget:self action:@selector(betListButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_footerView];
    
    //---------------------
    NSString *title = @"";
    

    NSArray *allTicketArr = @[];
    if ([allTicketArr count] == 0) {
        _isDanTuo = NO;
        _listArray = @[@"选号"];
        _titleStr = _gameDescription.ren5Name;
        title = [NSString stringWithFormat:@"%@-普通", _titleStr];
        [_titleButton setTitle:title forState:UIControlStateNormal];
        
        [_footerView.btnView getBetText:@"0" money:@"0"];
        //_footerView.moneyLabel.text = DisplayBetInfo(@(0), @(0));
    }
    
    _g11in5View.gameType = _titleStr;
    _g11in5View.isDanTuo = _isDanTuo;
    _g11in5View.listArray = _listArray;
    
    NSRange ranges = [title rangeOfString:@"胆拖"];
    if (ranges.location != NSNotFound) {
        _gameHeaderView.introlLabel.text = [[_gameDescription danTuoDictionaryData] objectForKey:_titleStr];
    }else {
        _gameHeaderView.introlLabel.text = [[_gameDescription puTongDictionaryData] objectForKey:_titleStr];
    }
    NSString *money = [[_gameDescription moneyDic] objectForKey:_titleStr];
    [_gameHeaderView setupIntroLabelAttributedTextWithMoney:money];
    
    if ([_updateNumbers length] > 0) {
        NSRange range1 = [_updateNumbers rangeOfString:kBetNumbersSeparator2];
        if (range1.location != NSNotFound) {
            NSArray *array = [_updateNumbers componentsSeparatedByString:kBetNumbersSeparator2];
            if ([array count] == 2) {
                NSString *str1 = array[0];
                NSString *str2 = array[1];
                NSArray *array1 = [str1 componentsSeparatedByString:kBetNumbersSeparator1];
                NSArray *array2 = [str2 componentsSeparatedByString:kBetNumbersSeparator1];
                [_g11in5View.tempData1 addObjectsFromArray:array1];
                [_g11in5View.tempData2 addObjectsFromArray:array2];
                _numberArr1 = array1;
                _numberArr2 = array2;
            }
            if ([array count] == 3) {
                NSString *str1 = array[0];
                NSString *str2 = array[1];
                NSString *str3 = array[2];
                NSArray *array1 = [str1 componentsSeparatedByString:kBetNumbersSeparator1];
                NSArray *array2 = [str2 componentsSeparatedByString:kBetNumbersSeparator1];
                NSArray *array3 = [str3 componentsSeparatedByString:kBetNumbersSeparator1];
                [_g11in5View.tempData1 addObjectsFromArray:array1];
                [_g11in5View.tempData2 addObjectsFromArray:array2];
                [_g11in5View.tempData3 addObjectsFromArray:array3];
                _numberArr1 = array1;
                _numberArr2 = array2;
                _numberArr3 = array3;
            }
        }else{
            NSArray *arr = [_updateNumbers componentsSeparatedByString:kBetNumbersSeparator1];
            [_g11in5View.tempData1 addObjectsFromArray:arr];
            _numberArr1 = arr;
        }
    }
}

//让当前的View成为第一响应者;
-(BOOL)canBecomeFirstResponder
{   // 默认值是 NO
    return YES;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];

//    _contentListController = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"---------- viewWillAppear ----------");
    _titleButton.alpha = 1.f;
    
    /**奖期接口
    provId = @"";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:kLocationProvinceId] length] > 0) {
        provId = [userDefaults objectForKey:kLocationProvinceId];
    }
    [GameDrawDao get11in5GameDrawWithProvinceId:provId gameNo:_gameNo];
     */
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self resignFirstResponder];

    _titleButton.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回消息
- (void)backButtonItemAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)popToView
{
    _titleButton.alpha = 0;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backButtonAction
{
    [self popToView];
}

- (void)backAction:(UISwipeGestureRecognizer *)recognizer
{
    [self popToView];
}

- (void)delAllTicketInfoData
{
  
}

#pragma mark - 晃动
//开始晃动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

//晃动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self shakeAction];
}

//取消晃动
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}
#pragma mark - 玩法选择
/**
 *	出现投注类型选择界面
 */
- (void)betTypeAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        //玩法选择
        _betTypeView = [[GP11in5GameTypeView alloc] init];
        _betTypeView.delegate = self;
        [_betTypeView betTypeViewContainerTitle:_titleButton.titleLabel.text];
        _betTypeView.frame = CGRectZero;
        _betTypeView.alpha = 0;
        [self.view addSubview:_betTypeView];
        
        __block CGRect rect = _betTypeView.frame;
        [UIView animateWithDuration:selectBetTypeDurationTime animations:^{
            
            rect.origin.y = 0;
            rect.origin.x = 0;
            rect.size.width = kScreenWidth;
            rect.size.height = kScreenHeight;
            _betTypeView.frame = rect;
            
            _betTypeView.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            //button.enabled = NO;
        }];
        
        //[button setImage:[UIImage imageNamed:openBetTypeImage] forState:UIControlStateNormal];
        [_titleButton openButtonImage];
    }
    if (!button.selected) {
        //[button setImage:[UIImage imageNamed:closeBetTypeImage] forState:UIControlStateNormal];
        [_titleButton closeButtonImage];
        [self hiddenBetTypeView];
    }
}

/**
 *	隐藏玩法选择页面
 */
- (void)hiddenBetTypeView
{
    //(0, -500.f, self.view.frame.size.width, 300.f)
    __block CGRect rect = _betTypeView.frame;
    [UIView animateWithDuration:selectBetTypeDurationTime animations:^{
        _betTypeView.alpha = 0;
        
        rect = CGRectZero;
        _betTypeView.frame = rect;
        
        _titleButton.enabled = YES;
    } completion:nil];
}

#pragma mark - GP11in5GameTypeViewDelegate
/**
 *	普通投注类型选择
 */
- (void)ptGameTypeSelectedButton:(UIButton *)button
{
    _isDanTuo = NO;
    
    [self hiddenBetTypeView];
    
    NSString *btnTitle = button.titleLabel.text;
    _titleStr = btnTitle;
    
    _gameHeaderView.introlLabel.text = [[_gameDescription puTongDictionaryData] objectForKey:btnTitle];
    NSString *money = [[_gameDescription moneyDic] objectForKey:_titleStr];
    [_gameHeaderView setupIntroLabelAttributedTextWithMoney:money];
    _g11in5View.gameType = btnTitle;
    
    NSString *title = [NSString stringWithFormat:@"%@-普通", btnTitle];
    [_titleButton setTitle:title forState:UIControlStateNormal];
    //[_titleButton setImage:[UIImage imageNamed:closeBetTypeImage] forState:UIControlStateNormal];
    [_titleButton closeButtonImage];
    _titleButton.selected = NO;
    
    
    if ([btnTitle isEqualToString:_gameDescription.q2ZhiXuanName]) {
        _listArray = @[@"第1位", @"第2位"];
    }else if ([btnTitle isEqualToString:_gameDescription.q3ZhiXuanName]) {
        _listArray = @[@"第1位", @"第2位", @"第3位"];
    }else {
        _listArray = @[@"选号"];
    }
    _g11in5View.listArray = _listArray;
    //    [self numbersViewWithTitle:btnTitle random:NO];
    
    [_g11in5View numbersViewReload];
}

/**
 *	胆拖投注类型选择
 
 */
- (void)dtGameTypeSelectedButton:(UIButton *)button
{
    _isDanTuo = YES;
    
    [self hiddenBetTypeView];
    
    NSString *btnTitle = button.titleLabel.text;
    _titleStr = btnTitle;
    
    _gameHeaderView.introlLabel.text = [[_gameDescription danTuoDictionaryData] objectForKey:btnTitle];
    NSString *money = [[_gameDescription moneyDic] objectForKey:_titleStr];
    [_gameHeaderView setupIntroLabelAttributedTextWithMoney:money];
    _g11in5View.gameType = btnTitle;
    
    NSString *title = [NSString stringWithFormat:@"%@-胆拖", btnTitle];
    [_titleButton setTitle:title forState:UIControlStateNormal];
    //[_titleButton setImage:[UIImage imageNamed:closeBetTypeImage] forState:UIControlStateNormal];
    [_titleButton closeButtonImage];
    _titleButton.selected = NO;
    
    _listArray = @[@"胆码", @"拖码"];
    _g11in5View.listArray = _listArray;
    //-----
    //    [self numbersViewWithTitle:btnTitle random:NO];
    
    [_g11in5View numbersViewReload];
}


#pragma mark - 摇一摇 机选
/**
 摇一摇
 */
- (void)shakeAction
{
    [_g11in5View setRandomNumbers];
}

#pragma mark - GameNumbersTableViewDelegate
- (void)get11in5BetContentArray1:(NSArray *)arr1 arr2:(NSArray *)arr2 arr3:(NSArray *)arr3
{
    _betCount = 0;
    NSInteger count = [[[_gameDescription puTongVerifyData] objectForKey:_titleStr] integerValue];

    if ([_listArray count] == 1) {
        if ([_titleStr isEqualToString:_gameDescription.ren1Name]) {
            _betCount = (int)[arr1 count];
        }else{
            if ([arr1 count] > count) {
                _betCount = [CombineArithmetic game11in5PutongBetCountN:arr1 count:count]; //ptBetCountN:_tempData1];
            }
            if ([arr1 count] == count) {
                _betCount = 1;
            }
        }
    }
    if ([_listArray count] == 2) {
        if (![_titleStr isEqualToString:_gameDescription.q2ZhiXuanName]) {
            _betCount = [CombineArithmetic game11in5DantuoBetCountN:arr1 tuoArray:arr2 count:count];//[self dtBetCountN:arr1 tuoArray:arr2];
        }else{
            _betCount = [CombineArithmetic game11in5Zhixuan2CountN:arr1 array2:arr2];// [self zhixuan2CountN:_tempData1 array2:_tempData2];
        }
    }
    if ([_listArray count] == 3) {
        _betCount = [CombineArithmetic game11in5Zhixuan3CountN:arr1 array2:arr2 array3:arr3];
    }
    
    _numberArr1 = arr1;
    _numberArr2 = arr2;
    _numberArr3 = arr3;
    
    [_footerView.btnView getBetText:[NSString stringWithFormat:@"%@", @(_betCount)] money:[NSString stringWithFormat:@"%@", @(_betCount*2)]];
//    _footerView.moneyLabel.text = DisplayBetInfo(@(_betCount), @(_betCount * 2));
}

#pragma mark - 底部
/**
 清空
 */
- (void)leftFooterButtonAction
{
    [_g11in5View numbersViewReload];
}

/**
 选好了
 */
- (void)rightFooterButtonAction
{  NSInteger picketMethod_ = 0;
    NSInteger betType_ = 0;
    NSInteger isDirect_ = 0;
    NSString *subTypeName_ = @"";
    NSString *betDetail_ = @"";
    NSString *displayDetail_ = @"";
    NSInteger groupId_ = [[[_gameDescription groupIdIndex] objectForKey:_titleStr] integerValue];
    NSInteger count_ = [[[_gameDescription puTongVerifyData] objectForKey:_titleStr] integerValue];
    
    BOOL verfity = NO;
    
    if ([_listArray count] == 1) {
        if ([_numberArr1 count] > 0) {
            displayDetail_ = [_numberArr1 componentsJoinedByString:kBetNumbersSeparator1];
            betDetail_ = [ReplaceOfString betNumberByReplacingOfString:displayDetail_];
            
            if ([_titleStr isEqualToString:_gameDescription.ren1Name]) {
                picketMethod_ = 3;
                betType_ = 2;
                if ([betDetail_ length] > 2) {
                    subTypeName_ = @"复式";
                }else {
                    subTypeName_ = @"单式";
                }
            }else{
                
                NSArray *numArr = [displayDetail_ componentsSeparatedByString:kBetNumbersSeparator1];
                if ([numArr count] > count_) {
                    subTypeName_ = @"复式";
                    betType_ = 2;
                    picketMethod_ = 4;
                }
                if ([numArr count] == count_) {
                    subTypeName_ = @"单式";
                    betType_ = 1;
                    picketMethod_ = 1;
                }
            }
            verfity = [self verfityPtBetNumbers:_numberArr1 count:count_];
        }else{
            [self shakeAction];
        }
    }
    if ([_listArray count] == 2) {
        if (([_numberArr1 count] > 0 && [_numberArr2 count] == 0)||([_numberArr1 count] == 0 && [_numberArr2 count] > 0)||([_numberArr1 count] > 0 && [_numberArr2 count] > 0)) {
            NSString *str1 = [_numberArr1 componentsJoinedByString:kBetNumbersSeparator1];
            NSString *str2 = [_numberArr2 componentsJoinedByString:kBetNumbersSeparator1];
            NSString *betStr1 = [ReplaceOfString betNumberByReplacingOfString:str1];
            NSString *betStr2 = [ReplaceOfString betNumberByReplacingOfString:str2];
            
            displayDetail_ = [NSString stringWithFormat:@"%@%@%@", str1, kBetNumbersSeparator2, str2];
            
            if (_isDanTuo) {
                picketMethod_ = 4;
                isDirect_ = 0;
                betType_ = 3;
                subTypeName_ = @"胆拖";
                
                betDetail_ = [NSString stringWithFormat:@"%@%@%@", betStr1, kBetNumbersSeparator2, betStr2];
                
                verfity = [self verfityDtBetNumbers:_numberArr1 tuoArray:_numberArr2 count:count_];
            }else{
                if ([_numberArr1 count] == 1 && [_numberArr2 count] == 1) {
                    picketMethod_ = 1;
                    isDirect_ = 0;
                    betType_ = 1;
                    subTypeName_ = @"单式";
                    betDetail_ = [NSString stringWithFormat:@"%@%@%@", str1, kBetNumbersSeparator1, str2];
                }else{
                    picketMethod_ = 2;
                    isDirect_ = 1;
                    betType_ = 2;
                    subTypeName_ = @"定位复式";
                    betDetail_ = [NSString stringWithFormat:@"%@%@%@", str1, kBetNumbersSeparator2, str2];
                }
                verfity = [self verfityZhiXuan2BetNumbers:_numberArr1 array2:_numberArr2];
            }
        }
        else{
            [self shakeAction];
        }
    }
    if ([_listArray count] == 3) {
        if ([_numberArr1 count] > 0 || [_numberArr2 count] > 0 || [_numberArr3 count] > 0) {
            NSString *str1 = [_numberArr1 componentsJoinedByString:kBetNumbersSeparator1];
            NSString *str2 = [_numberArr2 componentsJoinedByString:kBetNumbersSeparator1];
            NSString *str3 = [_numberArr3 componentsJoinedByString:kBetNumbersSeparator1];
            
            NSString *betStr1 = [ReplaceOfString betNumberByReplacingOfString:str1];
            NSString *betStr2 = [ReplaceOfString betNumberByReplacingOfString:str2];
            NSString *betStr3 = [ReplaceOfString betNumberByReplacingOfString:str3];
            
            displayDetail_ = [NSString stringWithFormat:@"%@%@%@%@%@", str1, kBetNumbersSeparator2, str2, kBetNumbersSeparator2, str3];
            
            if ([_numberArr1 count] == 1 && [_numberArr2 count] == 1 && [_numberArr3 count] == 1) {
                picketMethod_ = 1;
                isDirect_ = 0;
                betType_ = 1;
                subTypeName_ = @"单式";
                betDetail_ = [NSString stringWithFormat:@"%@%@%@%@%@", betStr1, kBetNumbersSeparator1, betStr2, kBetNumbersSeparator1, betStr3];
            }else{
                picketMethod_ = 2;
                isDirect_ = 1;
                betType_ = 2;
                subTypeName_ = @"定位复式";
                betDetail_ = [NSString stringWithFormat:@"%@%@%@%@%@", betStr1, kBetNumbersSeparator2, betStr2, kBetNumbersSeparator2, betStr3];
            }
            verfity = [self verfityZhiXuan3BetNumbers:_numberArr1 array2:_numberArr2 array3:_numberArr3];
        }else{
            [self shakeAction];
        }
    }
    
    //投注票内容
    if (verfity) {
        NSString * n = get_random_uuid();

        
        NSData *nsdata = [n
                          dataUsingEncoding:NSUTF8StringEncoding];
        
        // Get NSString from NSData object in Base64
        NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
        APPFaceSharingView *share = [[APPFaceSharingView alloc] initWithTitle:@"请到附近彩票店投注" qrcodeImage:nil qrcodeImageStr:base64Encoded Desc:nil];
        
        [share show];
    }
    
    
    
    
}



#pragma mark - 号码验证
/**
 普通投注的验证
 
 @param    array 	投注号码
 @param    count_ 选号数量
 @returnYES：进入投注界面；NO：号码球数量不足。
 */
- (BOOL)verfityPtBetNumbers:(NSArray *)array count:(NSInteger)count_
{
    BOOL result;
    if ([array count] < count_) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                           message:[NSString stringWithFormat:@"至少选择%@个号码", @(count_)]
                                          delegate:self
                                 cancelButtonTitle:@"好"
                                 otherButtonTitles:nil];
        [alert show];
        
        result = NO;
    }else{
        result = YES;
    }
    return result;
}

/**
 直选2的验证
 
 @param 	numbers 	投注号码
 
 @return	YES：进入投注界面；NO：号码球数量不足。
 */
- (BOOL)verfityZhiXuan2BetNumbers:(NSArray *)array1 array2:(NSArray *)array2
{
    BOOL result = NO;

    if ([array1 count]>0 && [array2 count]>0) {
        result = YES;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"每位至少选择1个号码"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        result = NO;
    }
    return result;
}

/**
 直选3的验证
 
 @param 	numbers 	投注号码
 
 @return	YES：进入投注界面；NO：号码球数量不足。
 */
- (BOOL)verfityZhiXuan3BetNumbers:(NSArray *)array1 array2:(NSArray *)array2 array3:(NSArray *)array3
{
    BOOL result = NO;
    if ([array1 count]>0 && [array2 count]>0 && [array3 count]>0) {
        result = YES;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"每位至少选择1个号码"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        result = NO;
    }
    return result;
}


/**
 胆拖投注的验证
 
 @param     numbers 	投注号码
 @param     count_ 选号数量
 
 @return	YES：进入投注界面；NO：号码球数量不足。
 */
- (BOOL)verfityDtBetNumbers:(NSArray *)danArray tuoArray:(NSArray *)tuoArray count:(NSInteger)count_
{
    BOOL result = NO;
    NSInteger danMaxCount = count_ - 1;
    
    UIAlertView *alert = nil;
    if ([danArray count] > 0 && [tuoArray count] > 0) {
        
        if ([tuoArray count] ==1) {
            result = NO;
            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"请至少选择2个拖码"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
        }else if ([tuoArray count] > 10)
        {
            result = NO;
            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"拖码数量2-10个"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
        }
        else {
            if ([danArray count] > danMaxCount) {
                result = NO;
                alert = [[UIAlertView alloc] initWithTitle:nil
                                                   message:[NSString stringWithFormat:@"胆码数量1-%@", @(danMaxCount)]
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
                [alert show];
            }else {
                if ([danArray count] + [tuoArray count] >= danMaxCount + 2) {
                    result = YES;
                }else {
                    result = NO;
                    alert = [[UIAlertView alloc] initWithTitle:nil
                                                       message:[NSString stringWithFormat:@"胆码加拖码至少选%@个", @(danMaxCount + 2)]
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
    }
    else if([danArray count] == 0 && [tuoArray count] > 0)
    {
        if (count_==2) {
            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"请选1个胆码"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"请至少选1个胆码"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
        }
    }
    else if([danArray count] > 0 && [tuoArray count] == 0)
    {
        alert = [[UIAlertView alloc] initWithTitle:nil
                                           message:@"请至少选择2个拖码"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    }
    else {
        alert = [[UIAlertView alloc] initWithTitle:nil
                                           message:@"胆码、拖码不能为空"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    }
    

    return result;
}

@end
