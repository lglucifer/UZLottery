//
//  DLTViewController.m
//  CSLCPlay
//
//  Created by liwei on 15/10/15.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "DLTViewController.h"
//#import "DLTBetListViewController.h"

#import "DLTNumbersTableView.h"
#import "GameBetHeaderView.h"
#import "GameBetFooterView.h"
#import "PreviewNumbersView.h"

#import "ReplaceOfString.h"
#import "CombineArithmetic.h"

#import "NavTitleButton.h"
#import "APPFaceSharingView.h"
//#import "TicketInfo.h"
#import "GTMBase64.h"
#define DisplayBetInfo(B, M)  [NSString stringWithFormat:@"共%@注 %@元", B, M]

@interface DLTViewController ()<GameNumbersTableViewDelegate, BetFooterViewDelegate, UIAlertViewDelegate>
{
    CGFloat tvHeight;
    float  selectBetTypeDurationTime;
//    NSString  *openBetTypeImage;
//    NSString  *closeBetTypeImage;
    NSArray *titleArray;
    NSArray *ptIntroArray;
    NSArray *dtIntroArray;
}

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NavTitleButton *titleButton;
@property (nonatomic, strong) DLTNumbersTableView *dltNumbersView;
@property (nonatomic, strong) UIView *betTypeView;
@property (nonatomic, strong) GameBetHeaderView *gameHeaderView;
@property (nonatomic, strong) GameBetFooterView *footerView;
@property (nonatomic, strong) PreviewNumbersView *previewNumView;
//
//@property (nonatomic, strong) DLTBetListViewController *contentListController;

@property (nonatomic, strong) NSArray  *frontDataArr1;
@property (nonatomic, strong) NSArray  *frontDataArr2;
@property (nonatomic, strong) NSArray  *backDataArr1;
@property (nonatomic, strong) NSArray  *backDataArr2;

@property (nonatomic, assign) NSInteger betCnt;


@end

@implementation DLTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kBackgroundGlobalDarkColor;
    //_updateNumbers = @"";
    
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

    
    
    titleArray = @[@"普通", @"胆拖"];
    ptIntroArray = @[@"请至少选择5个前区号码",
                     @"请至少选择2个后区号码"];
    dtIntroArray = @[@"前区胆码：我认为必出的红球（1-4个）",
                     @"前区拖码：我认为可能出的红球（至少2个）",
                     @"后区胆码：我认为必出的蓝球（1个）",
                     @"后区拖码：我认为可能出的蓝球（至少2个）"];
    
    selectBetTypeDurationTime = 0.2;
//    openBetTypeImage = @"prov_selcte_icon_close";
//    closeBetTypeImage = @"prov_selcte_icon";
    
    // 支持shake
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    if (_isHomePush == YES) {
        [self delAllTicketInfoData];
        
    }
    if (_isHomePush == NO) {
//        self.backBarButton = nil;
//        
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
//    _titleButton.frame = CGRectMake((self.view.frame.size.width - 140.f)/2 + 10.f, 0, 140.f, 44.f);
//    _titleButton.enabled = YES;
    NSString *title = @"";
    if (_isHomePush) {
        _isDanTuo = NO;
        _titleStr = titleArray[0];
        title = [NSString stringWithFormat:@"大乐透(%@)", _titleStr];
    }else{
        if (!_isDanTuo) {
            _titleStr = titleArray[0];
        }else{
            _titleStr = titleArray[1];
        }
        title = [NSString stringWithFormat:@"大乐透(%@)", _titleStr];
    }
    [_titleButton closeButtonImage];
    [_titleButton setTitle:title forState:UIControlStateNormal];
    [_titleButton addTarget:self action:@selector(dltbetTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_titleButton];
    
    //--- 号码预览 默认隐藏
    _previewNumView = [[PreviewNumbersView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40.f)];
    _previewNumView.alpha = 0;
    [self.view addSubview:_previewNumView];
    
    //------顶部
    _gameHeaderView = [[GameBetHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40.f)];
    [_gameHeaderView.shakeButton addTarget:self action:@selector(shakeAction) forControlEvents:UIControlEventTouchUpInside];
    _gameHeaderView.introlLabel.hidden = YES;
    [self.view addSubview:_gameHeaderView];
    
    //----- 选号界面
    tvHeight = kScreenHeight - 64.f - 40.f - 50.f;//50.f
    _dltNumbersView = [[DLTNumbersTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_gameHeaderView.frame), kScreenWidth, tvHeight)];
    _dltNumbersView.delegate = self;
    [self.view addSubview:_dltNumbersView];
    
    //底部view，包括清空、机选、保存
    CGFloat fy = kScreenHeight - 64.f - 50.f;
    _footerView = [[GameBetFooterView alloc] initWithFrame:CGRectMake(0, fy, kScreenWidth, 50.f)];
    _footerView.delegate = self;
//    [_footerView.clearButton addTarget:self action:@selector(clearButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [_footerView.betListButton addTarget:self action:@selector(betListButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_footerView];
    
    //-----
    if (!_isDanTuo) {
        [_dltNumbersView setTitleListArray:ptIntroArray];
    }else {
        [_dltNumbersView setTitleListArray:dtIntroArray];
    }
    if ([_updateNumbers length] > 0) {
        _betCnt = _ticketBet;
//        _footerView.moneyLabel.text = DisplayBetInfo(@(_ticketBet), @(_ticketBet*2));
        [_footerView.btnView getBetText:[NSString stringWithFormat:@"%@", @(_ticketBet)] money:[NSString stringWithFormat:@"%@", @(_ticketBet*2)]];
        NSRange range1 = [_updateNumbers rangeOfString:kBetNumbersDisplaySeparator];
        if (range1.location != NSNotFound) {
            NSArray *arr1 = [_updateNumbers componentsSeparatedByString:kBetNumbersDisplaySeparator];
            if ([arr1 count] == 2) {
                NSString *frontStr = arr1[0];
                NSString *backStr = arr1[1];
                NSRange range11 = [frontStr rangeOfString:@")"];
                NSRange range12 = [backStr rangeOfString:@")"];
                if (range11.location != NSNotFound && range12.location != NSNotFound) {
                    NSString *frontDan = [[frontStr substringFromIndex:1] substringToIndex:range11.location-1];
                    NSString *frontTuo = [frontStr substringFromIndex:range11.location+range11.length];
                    NSArray *frontDanArr = [frontDan componentsSeparatedByString:kBetNumbersSeparator1];
                    NSArray *frontTuoArr = [frontTuo componentsSeparatedByString:kBetNumbersSeparator1];
                    
                    NSString *backDan = [[backStr substringFromIndex:1] substringToIndex:range12.location-1];
                    NSString *backTuo = [backStr substringFromIndex:range12.location+range12.length];
                    NSArray *backTuoArr = [backTuo componentsSeparatedByString:kBetNumbersSeparator1];
                    
                    [_dltNumbersView.frontTempData1 addObjectsFromArray:frontDanArr];
                    [_dltNumbersView.frontTempData2 addObjectsFromArray:frontTuoArr];
                    [_dltNumbersView.backTempData1 addObject:backDan];
                    [_dltNumbersView.backTempData2 addObjectsFromArray:backTuoArr];
                    _frontDataArr1 = frontDanArr;
                    _frontDataArr2 = frontTuoArr;
                    _backDataArr1 = @[backDan];
                    _backDataArr2 = backTuoArr;
                }
                if (range11.location == NSNotFound && range12.location == NSNotFound) {
                    NSArray *frontTempArr = [frontStr componentsSeparatedByString:kBetNumbersSeparator1];
                    NSArray *backTempArr = [backStr componentsSeparatedByString:kBetNumbersSeparator1];
                    
                    [_dltNumbersView.frontTempData1 addObjectsFromArray:frontTempArr];
                    [_dltNumbersView.backTempData1 addObjectsFromArray:backTempArr];
                    _frontDataArr1 = frontTempArr;
                    _backDataArr1 = backTempArr;
                }
            }
        }
    }else{
//        _footerView.moneyLabel.text = DisplayBetInfo(@"0", @"0");
            [_footerView.btnView getBetText:@"0" money:@"0"];
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
    _titleButton.alpha = 1.f;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
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
//    NSArray *arr = [TicketInfo MR_findAll];
//    if ([arr count] > 0) {
//        for (TicketInfo *ti in arr) {
//            [ti MR_deleteEntity];
//            [[ti managedObjectContext] MR_saveToPersistentStoreAndWait];
//        }
//    }
}

#pragma mark - 大乐透投注方式选择
- (void)setupDLTBetTypeView
{
    if (_betTypeView) {
        [_betTypeView removeFromSuperview];
    }
    _betTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64.f)];
    _betTypeView.backgroundColor = [UIColor whiteColor];
    _betTypeView.alpha = 1.f;
    [self.view addSubview:_betTypeView];
    
    CGFloat btnWidth = 108.f;
    CGFloat btnHeight = 36.f;
    CGFloat btnY = (_betTypeView.frame.size.height - btnHeight)/2;
    CGFloat btnX = (kScreenWidth - btnWidth*2 - 10.f)/2;
    UIButton *button = nil;
    for (NSInteger i=0; i<2; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i+100;
        button.frame = CGRectMake(btnX+i*10.f+i*btnWidth, btnY, btnWidth, btnHeight);
        [button setTitle:[NSString stringWithFormat:@"%@投注",titleArray[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        button.layer.borderWidth = 0.8;
        button.layer.cornerRadius = 4.f;
        [button addTarget:self action:@selector(selectBetTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_betTypeView addSubview:button];
        
        NSRange range = [button.titleLabel.text rangeOfString:_titleStr];
        if (range.location != NSNotFound) {
            button.backgroundColor = [UIColor colorRGBWithRed:177.f green:23.f blue:42.f alpha:1.f];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            button.backgroundColor = [UIColor clearColor];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
    }
    
    UIView *typeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _betTypeView.frame.size.height-2.f, kScreenWidth, 2.f)];
    typeLineView.backgroundColor = [UIColor colorRGBWithRed:198.f green:0 blue:11.f alpha:1.f];
    [_betTypeView addSubview:typeLineView];
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

#pragma mark - 出现投注类型选择界面
/**
 *	出现投注类型选择界面
 */
- (void)dltbetTypeAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        //玩法选择
        [self setupDLTBetTypeView];
        
        //[button setImage:[UIImage imageNamed:openBetTypeImage] forState:UIControlStateNormal];
        [_titleButton openButtonImage];
    }
    if (!button.selected) {
        [self hiddenBetTypeView];
        //[button setImage:[UIImage imageNamed:closeBetTypeImage] forState:UIControlStateNormal];
        [_titleButton closeButtonImage];
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
        
        rect.origin.y = -200.f;
        _betTypeView.frame = rect;
        
        _titleButton.enabled = YES;
    } completion:^(BOOL finished) {
        _betTypeView.alpha = 0;
    }];
}

#pragma mark - 出现号码预览
- (void)setPreviewNumbersHeight:(CGFloat)disHeight
{
    [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (disHeight == 0) {
            _previewNumView.alpha = 0;
        }else{
            _previewNumView.alpha = 1.f;
        }

        CGRect _disFrame = _previewNumView.frame;
        _disFrame.size.height = disHeight;
        _previewNumView.frame = _disFrame;
        
        CGRect headerFrame = _gameHeaderView.frame;
        headerFrame.origin.y = disHeight;
        _gameHeaderView.frame = headerFrame;
        
        CGRect numFrame = _dltNumbersView.frame;
        numFrame.origin.y = CGRectGetMaxY(headerFrame);
        numFrame.size.height = tvHeight - disHeight;
        _dltNumbersView.frame = numFrame;
        
        CGRect tableViewFrame = _dltNumbersView.tableView.frame;
        tableViewFrame.size.height = numFrame.size.height;
        _dltNumbersView.tableView.frame = tableViewFrame;

        
    } completion:^(BOOL finished) {

    }];
}

#pragma mark - 投注类型选择
/**
 *	投注类型选择
 */
- (void)selectBetTypeButtonAction:(UIButton *)button
{
    NSInteger tag = button.tag;
    if (tag == 100) {
        _isDanTuo = NO;
        _titleStr = titleArray[0];
        [self hiddenBetTypeView];
        [self setPreviewNumbersHeight:0];
        
        NSString *title = [NSString stringWithFormat:@"大乐透(%@)", titleArray[0]];
        [_titleButton setTitle:title forState:UIControlStateNormal];
        //[_titleButton setImage:[UIImage imageNamed:closeBetTypeImage] forState:UIControlStateNormal];
        [_titleButton closeButtonImage];
        _titleButton.selected = NO;
        
        [_dltNumbersView setTitleListArray:ptIntroArray];
        [_dltNumbersView numbersViewReload];
        
        
    }
    if (tag == 101) {
        _isDanTuo = YES;
        [self hiddenBetTypeView];
        [self setPreviewNumbersHeight:0];
        
        _titleStr = titleArray[1];
        NSString *title = [NSString stringWithFormat:@"大乐透(%@)", titleArray[1]];
        [_titleButton setTitle:title forState:UIControlStateNormal];
        //[_titleButton setImage:[UIImage imageNamed:closeBetTypeImage] forState:UIControlStateNormal];
        [_titleButton closeButtonImage];
        _titleButton.selected = NO;
        
        [_dltNumbersView setTitleListArray:dtIntroArray];
        [_dltNumbersView numbersViewReload];
    }
    _gameHeaderView.drawLabel.text = @"";
//    _footerView.moneyLabel.text = DisplayBetInfo(@"0", @"0");
    [_footerView.btnView getBetText:@"0" money:@"0"];
}

#pragma mark - GameNumbersTableViewDelegate
- (void)getDLTBetContentFrontArray1:(NSArray *)frontArr1 frontArray2:(NSArray *)frontArr2 backArray1:(NSArray *)backArr1 backArray2:(NSArray *)backArr2
{
    if ([frontArr1 count] > 0 || [frontArr2 count] > 0 || [backArr1 count] > 0 || [backArr2 count] > 0) {
        
        CGFloat disHeight = 0;
        if (!_isDanTuo) {
            disHeight = [_previewNumView displayDLTPutongFront:[frontArr1 componentsJoinedByString:@" "] back:[backArr1 componentsJoinedByString:@" "]];
        }else{
            disHeight = [_previewNumView displayDLTDantuoNumbersFrontDan:[frontArr1 componentsJoinedByString:@" "] frontTuo:[frontArr2 componentsJoinedByString:@" "] backDan:[backArr1 componentsJoinedByString:@" "] backTuo:[backArr2 componentsJoinedByString:@" "]];
        }
        
        [self setPreviewNumbersHeight:disHeight];
    }
    else
    {
        [self setPreviewNumbersHeight:0];
//        [_dltNumbersView numbersViewReload];
    }
    
    if ([_titleStr isEqualToString:titleArray[0]]) {
        _frontDataArr1 = frontArr1;
        _backDataArr1 = backArr1;

        NSInteger betCount = [CombineArithmetic getDLTPutongFrontCount:[frontArr1 count] backCount:[backArr1 count]];
        _betCnt = betCount;
//        _footerView.moneyLabel.text = DisplayBetInfo(@(betCount), @(betCount * 2));
                [_footerView.btnView getBetText:[NSString stringWithFormat:@"%@", @(betCount)] money:[NSString stringWithFormat:@"%@", @(betCount*2)]];
    }
    if ([_titleStr isEqualToString:titleArray[1]]) {
        _frontDataArr1 = frontArr1;
        _frontDataArr2 = frontArr2;
        _backDataArr1 = backArr1;
        _backDataArr2 = backArr2;
        
        NSInteger betCount = [CombineArithmetic getDLTDanTuoFrontDanCount:[frontArr1 count] frontTuoCount:[frontArr2 count] backTuoCount:[backArr2 count]];
        _betCnt = betCount;
//        _footerView.moneyLabel.text = DisplayBetInfo(@(betCount), @(betCount * 2));
        [_footerView.btnView getBetText:[NSString stringWithFormat:@"%@", @(betCount)] money:[NSString stringWithFormat:@"%@", @(betCount*2)]];
    }
    _gameHeaderView.drawLabel.text = [NSString stringWithFormat:@"%@%@@%@%@", [frontArr1 componentsJoinedByString:@"+"],[frontArr2 componentsJoinedByString:@"+"],[backArr1 componentsJoinedByString:@"+"],[backArr2 componentsJoinedByString:@"+"]];
}

#pragma mark - 摇一摇 机选
/**
 摇一摇
 */
- (void)shakeAction
{
    [_dltNumbersView setRandomNumbers];
}

#pragma mark - 底部
/**
 清空
 */
- (void)leftFooterButtonAction
{
    [self setPreviewNumbersHeight:0];
    [_dltNumbersView numbersViewReload];
}

/**
 选定
 */
- (void)rightFooterButtonAction
{
    if (_betCnt > 10000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"单张彩票不能超过10000注"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        NSInteger picketMethod_ = 0;
        NSInteger betType_ = 0;
        NSString *subType_ = @"";
        NSString *displayNum_ = @"";
        NSString *betNum_ = @"";
        //普通
        if ([_titleStr isEqualToString:titleArray[0]]) {
            if ([_frontDataArr1 count] > 0 || [_backDataArr1 count]>0) {
                BOOL verfity = [self verfityDLTPutongBetNumbers];
                if (verfity) {
                    //复式
                    if ([_frontDataArr1 count] > 5 || [_backDataArr1 count] > 2) {
                        picketMethod_ = 4;
                        betType_ = 2;
                        subType_ = @"复式";
                    }
                    //单式
                    if ([_frontDataArr1 count] == 5 && [_backDataArr1 count] == 2) {
                        picketMethod_ = 1;
                        betType_ = 1;
                        subType_ = @"单式";
                    }
                    displayNum_ = [ReplaceOfString setPutongDisplayNumbersFrontArr:_frontDataArr1 backArr:_backDataArr1];
                    betNum_ = [ReplaceOfString setPutongBetNumbersFrontArr:_frontDataArr1 backArr:_backDataArr1];
                    [self myTicketDisplayNumber:displayNum_ betNumber:betNum_ subType:subType_ pickMethod:picketMethod_ betType:betType_];
                }
            }else{
                //机选一注
                [self shakeAction];
            }
        }
        //胆拖
        if ([_titleStr isEqualToString:titleArray[1]]) {
            if ([_frontDataArr1 count] > 0 && [_frontDataArr2 count] > 0 && [_backDataArr1 count] > 0 && [_backDataArr1 count] > 0) {
                BOOL verfity = [self verfityDLTDantuoBetNumbers];
                if (verfity) {
                    picketMethod_ = 4;
                    betType_ = 2;
                    subType_ = @"胆拖";
                    displayNum_ = [ReplaceOfString setDantuoDisplayBetNumbersFrontArr1:_frontDataArr1 frontArr2:_frontDataArr2 backArr1:_backDataArr1 backArr2:_backDataArr2];
                    betNum_ = [ReplaceOfString setDantuoBetNumbersFrontArr1:_frontDataArr1 frontArr2:_frontDataArr2 backArr1:_backDataArr1 backArr2:_backDataArr2];
                    [self myTicketDisplayNumber:displayNum_ betNumber:betNum_ subType:subType_ pickMethod:picketMethod_ betType:betType_];
                }
            }else if ([_frontDataArr1 count] == 0 && [_frontDataArr2 count] == 0 && [_backDataArr1 count] == 0 && [_backDataArr1 count] == 0) {
                //机选一注
                [self shakeAction];
            }else{
                NSString *msg = [NSString stringWithFormat:@"您选择了%@个前区胆码，%@个前区拖码，%@个后区胆码，%@个后区拖码",@([_frontDataArr1 count]),  @([_frontDataArr2 count]), @([_backDataArr1 count]), @([_backDataArr2 count])];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择一注号码"
                                                                message:msg
                                                               delegate:self
                                                      cancelButtonTitle:@"好"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}

#pragma mark - 保存/更新号码并跳转到投注确认界面
- (void)myTicketDisplayNumber:(NSString *)displayNum betNumber:(NSString *)betNum subType:(NSString *)subType pickMethod:(NSInteger)picketMethod betType:(NSInteger)betType
{
//    if ([_updateNumbers length] > 0) {
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"displayDetail=%@ AND idx=%@", _updateNumbers, _ticketInfoIdx];
//        NSArray *findAllArr = [TicketInfo MR_findAllWithPredicate:predicate];
//        if ([findAllArr count] > 0) {
//            TicketInfo *ticket = [findAllArr lastObject];
//            ticket.idx = _ticketInfoIdx;
//            ticket.displayDetail = displayNum;
//            ticket.betDetail = betNum;
//            ticket.pickMethod = [NSString stringWithFormat:@"%@", @(picketMethod)];
//            ticket.betType = [NSString stringWithFormat:@"%@", @(betType)];
//            ticket.isDirect = @"0";
//            ticket.region = @"2";
//            ticket.groupIdx = @"0";
//            ticket.gameType = @"大乐透";
//            ticket.bet = [NSString stringWithFormat:@"%@", @(_betCnt)];
//            ticket.money = [NSString stringWithFormat:@"%@",@(_betCnt * 2)];
//            ticket.subType = subType;
//            ticket.createTime = [NSDate date];
//            [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
//        }
//    }else{
//        NSArray *allTicket = [TicketInfo MR_findAll];
//        NSInteger allCount = [allTicket count];
//        
//        TicketInfo *ticket = [TicketInfo MR_createEntity];
//        ticket.idx = @(allCount + 1);
//        ticket.displayDetail = displayNum;
//        ticket.betDetail = betNum;
//        ticket.pickMethod = [NSString stringWithFormat:@"%@", @(picketMethod)];
//        ticket.betType = [NSString stringWithFormat:@"%@", @(betType)];
//        ticket.isDirect = @"0";
//        ticket.region = @"2";
//        ticket.groupIdx = @"0";
//        ticket.gameType = @"大乐透";
//        ticket.bet = [NSString stringWithFormat:@"%@", @(_betCnt)];
//        ticket.money = [NSString stringWithFormat:@"%@",@(_betCnt * 2)];
//        ticket.subType = subType;
//        ticket.createTime = [NSDate date];
//        [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
//    }
//
//    if (_contentListController == nil) {
//        _contentListController = [[DLTBetListViewController alloc] init];
//        _contentListController.gameNo = _gameNo;
//        _contentListController.gameName = _gameName;
//        if (_isHomePush) {
//            [self.navigationController pushViewController:_contentListController animated:YES];
//        }else{
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }
    
    NSString * n = get_random_uuid();
    
    NSData *nsdata = [n
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    
    
    APPFaceSharingView *share = [[APPFaceSharingView alloc] initWithTitle:@"请到附近彩票店投注" qrcodeImage:nil qrcodeImageStr:base64Encoded Desc:nil];
    
    [share show];
}

#pragma mark - 号码验证
/**
 *	普通投注的验证
 *
 *	@param 	numbers 	投注号码
 *
 *	@return	YES：进入投注界面；NO：号码球数量不足。
 */
- (BOOL)verfityDLTPutongBetNumbers
{
    BOOL result;
    if ([_frontDataArr1 count] > 4 && [_backDataArr1 count] > 1) {
        result = YES;
    }else if ([_frontDataArr1 count] < 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"前区至少选择5个号码"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        result = NO;
    }else if ([_backDataArr1 count] < 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"后区至少选择2个号码"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        result = NO;
    }else{
        result = NO;
    }
    return result;
}

/**
 *	胆拖投注的验证
 *
 *	@param 	numbers 	投注号码
 *
 *	@return	YES：进入投注界面；NO：号码球数量不足。
 */
- (BOOL)verfityDLTDantuoBetNumbers
{
    BOOL result;
    
    NSInteger frontCount = [_frontDataArr1 count] + [_frontDataArr2 count];
    NSInteger backCount = [_backDataArr1 count] + [_backDataArr2 count];
    if ([_frontDataArr1 count] < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"前区胆码最少选1个，最多选4个"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        result = NO;
    }else if ([_frontDataArr2 count] < 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"前区拖码至少选择2个号码"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
    }else if ([_backDataArr1 count] < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"后区胆码最多选1个"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
    } else if ([_backDataArr2 count] < 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"后区拖码至少选2个"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        result = NO;
    }else if (frontCount > 5 && backCount > 2) {
        result = YES;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"前区胆+拖>=6, 后区胆+拖>=2"
                                                       delegate:self
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
        result = NO;
    }
    return result;
}


@end
