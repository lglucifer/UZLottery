//
//  DLTBetViewController.m
//  CSLCPlay
//
//  Created by liwei on 15/11/5.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "DLTBetListViewController.h"
#import "QRCodeViewController.h"

#import "DLTViewController.h"

#import "SVProgressHUD.h"

#import "BetFooterView.h"
#import "BetContentCell.h"


#import "TicketInfo.h"
#import "MyBetInfo.h"
#import "MyTicketInfo.h"


#import "RandomBetNubmer.h"

#import "BetContentModel.h"
#import "GP11in5Description.h"
#import "ReplaceOfString.h"
#import "CombineArithmetic.h"

#import "GameBetFormatHeader.h"

#import "CSLCNavigationController.h"
#import "APPFaceSharingView.h"



@interface DLTBetListViewController ()<UITableViewDelegate, UITableViewDataSource, BetFooterViewDelegate, BetContentCellDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
    NSInteger tempMutiple;
    NSInteger tempAppendDraw;
    
    UIView * noMatchBGV;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BetFooterView *footerView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) QRCodeViewController *qrCodeController;


@property (nonatomic, assign) NSInteger baseMutilple;
@property (nonatomic, assign) NSInteger totalMoney;

@end

typedef NS_ENUM(NSInteger, kBetContentAlertTag)
{
    kBetContentAlertTagBack = 1000,
    kBetContentAlertTagClearAll = 1001,
    kBetContentAlertTagSave = 1002
};


@implementation DLTBetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kBackgroundGlobalDarkColor;
    
    self.title = MyLocalizedString(@"投注确认");
    
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
    
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64.f)];
    headView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headView];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bet_cell_line"]];
    lineImageView.frame = CGRectMake(26.f, 64.f, kScreenWidth-26.f*2, 1.f);
    [headView addSubview:lineImageView];
    
    UIButton *button = nil;
    CGFloat btnWidth = (kScreenWidth - 20.f*2 - 10.f*2)/3;
    for (NSInteger i=0; i<3; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20.f + btnWidth *i + 10.f * i, 14.f, btnWidth, 38.f);
        button.backgroundColor = [UIColor colorRGBWithRed:255.f green:255.f blue:255.f alpha:1.f];
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        button.layer.borderWidth = 1.f;
        button.layer.cornerRadius = 4.f;
        button.tag = i;
        [button addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [headView addSubview:button];
        
        CGFloat ivx = btnWidth/9;
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ivx, (38.f-14.f)/2, 14.f, 14.f)];
        iconImageView.backgroundColor = [UIColor clearColor];
        [button addSubview:iconImageView];
        
        CGFloat lx = CGRectGetMaxX(iconImageView.frame) + 3.f;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lx, 0, btnWidth - lx - 4.f , button.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:16.f];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        
        if (i == 0) {
            iconImageView.image = [UIImage imageNamed:@"bet_add"];
            label.text = @"自选号码";
        }
        if (i == 1) {
            iconImageView.image = [UIImage imageNamed:@"bet_add"];
            label.text = @"机选一注";
        }
        if (i == 2) {
            iconImageView.image = [UIImage imageNamed:@"bet_clear_list"];
            label.text = @"清空列表";
        }
    }
    
    
    noMatchBGV = [[UIView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, 200)];
    noMatchBGV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:noMatchBGV];
    
    UIImageView * noGameV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-163)/2, 0, 163, 137)];
    noGameV.backgroundColor = [UIColor clearColor];
    [noGameV setImage:[UIImage imageNamed:@"shaketorandom"]];
    [noMatchBGV addSubview:noGameV];
    UILabel * nol = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noGameV.frame)+10, kScreenWidth, 20)];
    nol.numberOfLines = 1;
    nol.lineBreakMode = NSLineBreakByCharWrapping;
    nol.backgroundColor = [UIColor clearColor];
    nol.textColor = [UIColor lightGrayColor];
    nol.textAlignment = NSTextAlignmentCenter;
    nol.font = [UIFont systemFontOfSize:14];
    nol.text = @"摇一摇，赐福号";
    [noMatchBGV addSubview:nol];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    _qrCodeController = nil;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSArray *ticketInfoArr = [TicketInfo MR_findAllSortedBy:@"idx" ascending:NO];
    
    _dataArray = [[NSMutableArray alloc] init];
    [_dataArray  addObjectsFromArray:ticketInfoArr];
    
    //底部view，包括清空、机选、保存，生成投注二维码
    CGFloat tvHeight = kScreenHeight - 64.f - 90.f;
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 67.f, kScreenWidth, tvHeight - 64.f) style:UITableViewStylePlain];
    }
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    if (_footerView == nil) {
        _footerView = [[BetFooterView alloc] initWithFrame:CGRectMake(0, tvHeight, kScreenWidth, 90.f)];
        [_footerView setupDLTTextField];
    }
    [_footerView.appendButton addTarget:self action:@selector(appendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _footerView.delegate = self;
    

    _footerView.maxBetCount = 999;
    
    
    tempMutiple = [_footerView.multipleTextField.text integerValue];
    tempAppendDraw = [_footerView.drawTextField.text integerValue];
    
    [self.view addSubview:_footerView];
    
    
    NSString *additionid = [self readAdditionid];
    if (additionid == nil || additionid == NULL) {
        [self saveAdditionid:@"0"];
        _baseMutilple = 2;
        [_footerView.appendButton setImage:[UIImage imageNamed:@"append_icon_unselect"] forState:UIControlStateNormal];
    }else{
        NSInteger addid = [additionid integerValue];
        if (addid == 0) {
            _baseMutilple = 2;
            [_footerView.appendButton setImage:[UIImage imageNamed:@"append_icon_unselect"] forState:UIControlStateNormal];
        }
        if (addid == 1) {
            _baseMutilple = 3;
            [_footerView.appendButton setImage:[UIImage imageNamed:@"append_icon_select"] forState:UIControlStateNormal];
        }
    }
    [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];

    [_tableView reloadData];
    
    [self ifShowNoMatchImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 管理追加标志
- (void)saveAdditionid:(NSString *)additionid
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:additionid forKey:@"dlt_addition_id"];
}

- (void)removeAdditionid
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"dlt_addition_id"]) {
        [userDefaults removeObjectForKey:@"dlt_addition_id"];
    }
}

- (NSString *)readAdditionid
{
    NSString *string = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    string = [userDefaults objectForKey:@"dlt_addition_id"];
    return string;
}

#pragma mark - 返回消息
- (void)backButtonItemAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)popToView
{
    NSArray *arr = [TicketInfo MR_findAll];
    if ([arr count] > 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"退出后，您所选号的号码将自动清空" delegate:self cancelButtonTitle:@"继续选号" destructiveButtonTitle:@"不玩了" otherButtonTitles:nil];
        [actionSheet showInView:self.view];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    NSArray *arr = [TicketInfo MR_findAll];
    if ([arr count] > 0) {
        for (TicketInfo *ti in arr) {
            [ti MR_deleteEntity];
            [[ti managedObjectContext] MR_saveToPersistentStoreAndWait];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"0");
        [self delAllTicketInfoData];
        [self removeAdditionid];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (buttonIndex == 1) {
        NSLog(@"1");
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kBetContentAlertTagClearAll) {
        if (buttonIndex == 1) {
            NSArray *ticketInfoArr = [TicketInfo MR_findAll];
            if ([ticketInfoArr count] > 0) {
                for (TicketInfo *ti in ticketInfoArr) {
                    [ti MR_deleteEntity];
                    [[ti managedObjectContext] MR_saveToPersistentStoreAndWait];
                }
            }
            if ([_dataArray count] > 0) {
                [_dataArray removeAllObjects];
            }
            [self resetAllSelectData];
            
            [_tableView reloadData];
            
            [self ifShowNoMatchImage];
        }
    }
    if (alertView.tag == kBetContentAlertTagSave) {
        if (buttonIndex == 0) {
            NSLog(@"kBetContentAlertTagSave 0");
        }
        if (buttonIndex == 1) {
          
        }
    }

}


#pragma mark - 计算总的金额、注数、期数、倍数
- (void)displayMoneyTextLabelWithBet:(NSInteger)bet
{
    _totalMoney = bet * _baseMutilple * tempMutiple * tempAppendDraw;
    NSString *moneystr = [NSString stringWithFormat:@"%@",@(_totalMoney)];
    NSString *betStr = [NSString stringWithFormat:@"%@",@(bet)];
    [_footerView.btnView getBetText:betStr money:moneystr];
    //NSString *text = [NSString stringWithFormat:@"共 %@ 注 %@ 元", betStr, moneystr];
    
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
//    if (bet > 0) {
//        NSRange range1 = [text rangeOfString:betStr];
//        NSRange range2 = [text rangeOfString:moneystr];
//        if (range1.location != NSNotFound) {
//            [attrString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:NSMakeRange(range1.location, range1.length)];
//        }
//        if (range2.location != NSNotFound) {
//            [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorRGBWithRed:215.f green:164.f blue:32.f alpha:1.f], NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:NSMakeRange(range2.location, range2.length)];
//            
//        }
//    }
//    if (bet == 0) {
//        [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorRGBWithRed:215.f green:164.f blue:32.f alpha:1.f], NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:NSMakeRange(6, 1)];
//    }
//    
//    _footerView.moneyLabel.attributedText = attrString;
    //_footerView.descLabel.text = [NSString stringWithFormat:@"公益券已抵扣%@元>>", @(tempMutiple+tempAppendDraw)];
}
- (NSInteger)ticketTotalBetInfo
{
    NSInteger total = 0;
    NSArray *arr = [TicketInfo MR_findAll];
    for (TicketInfo *ti in arr) {
        NSInteger bet = [ti.bet integerValue];
        total = bet + total;
    }
    
    return total;
}

#pragma mark - headerview button 顶部button  自选、机选、清空
- (void)headerButtonAction:(id)sender
{
    NSInteger tag = [sender tag];
    NSString *subType_ = @"";
    if ([_dataArray count] > 0) {
        TicketInfo *ti = _dataArray[0];
        subType_ = ti.subType;
    }else{
        subType_ = @"单式";
    }
    if (tag == 0) {
        DLTViewController *controller = [[DLTViewController alloc] init];
        controller.isHomePush = NO;
        controller.gameNo = _gameNo;
        if ([subType_ isEqualToString:@"胆拖"]) {
            controller.isDanTuo = YES;
        }else{
            controller.isDanTuo = NO;
        }
        CSLCNavigationController *navController = [[CSLCNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
    }
    if (tag == 1) {
        NSArray *allTicket = [TicketInfo MR_findAll];
        NSInteger allCount = [allTicket count];
        
        TicketInfo *ticket = [TicketInfo MR_createEntity];

        if ([subType_ isEqualToString:@"胆拖"]) {
            NSArray *frontDanTuoArr = [RandomBetNubmer randomDLTNumberCount:5 total:35 betType:GameBetTypeDLTDantuo];
            NSArray *backDanTuoArr = [RandomBetNubmer randomDLTNumberCount:2 total:12 betType:GameBetTypeDLTDantuo];
            NSArray *frontDanArr = frontDanTuoArr[0];
            NSArray *frontTuoArr = frontDanTuoArr[1];
            NSArray *backDanArr = backDanTuoArr[0];
            NSArray *backTuoArr = backDanTuoArr[1];
            
            NSString *betNumber = [ReplaceOfString setDantuoBetNumbersFrontArr1:frontDanArr frontArr2:frontTuoArr backArr1:backDanArr backArr2:backTuoArr];
            NSString *displayNumber = [ReplaceOfString setDantuoDisplayBetNumbersFrontArr1:frontDanArr frontArr2:frontTuoArr backArr1:backDanArr backArr2:backTuoArr];
            
            ticket.idx = @(allCount+1);
            ticket.displayDetail = displayNumber;
            ticket.betDetail = betNumber;
            ticket.subType = @"胆拖";
            ticket.pickMethod = @"4";
            ticket.betType = @"2";
            ticket.isDirect = @"0";
            ticket.region = @"2";
            ticket.groupIdx = @"0";
            ticket.bet = @"10";
            ticket.money = @"20";
            ticket.gameType = @"大乐透";
            ticket.createTime = [NSDate date];
            [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
        }else{
            NSArray *frontArr = [RandomBetNubmer randomDLTNumberCount:5 total:35 betType:GameBetTypeDLTPutong];
            NSArray *backArr = [RandomBetNubmer randomDLTNumberCount:2 total:12 betType:GameBetTypeDLTPutong];
            
            NSString *betNumber = [ReplaceOfString setPutongBetNumbersFrontArr:frontArr backArr:backArr];
            NSString *displayNumber = [ReplaceOfString setPutongDisplayNumbersFrontArr:frontArr backArr:backArr];
           
            ticket.idx = @(allCount+1);
            ticket.displayDetail = displayNumber;
            ticket.betDetail = betNumber;
            ticket.subType = @"单式";
            ticket.pickMethod = @"1";
            ticket.betType = @"1";
            ticket.isDirect = @"0";
            ticket.region = @"2";
            ticket.groupIdx = @"0";
            ticket.bet = @"1";
            ticket.money = @"2";
            ticket.gameType = @"大乐透";;
            ticket.createTime = [NSDate date];
            [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
        }
        
        [_dataArray insertObject:ticket atIndex:0];
        
        [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];
        
//        [_tableView reloadData];
        [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }
    if (tag == 2) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MyLocalizedString(@"alert")
                                                            message:MyLocalizedString(@"clear alert")
                                                           delegate:self
                                                  cancelButtonTitle:@"继续玩"
                                                  otherButtonTitles:MyLocalizedString(@"clear"), nil];
        alertView.tag = kBetContentAlertTagClearAll;
        [alertView show];
    }
    [self ifShowNoMatchImage];
}

-(void)randomOneGame
{
    NSString *subType_ = @"";
    if ([_dataArray count] > 0) {
        TicketInfo *ti = _dataArray[0];
        subType_ = ti.subType;
    }else{
        subType_ = @"单式";
    }
    
    NSArray *allTicket = [TicketInfo MR_findAll];
    NSInteger allCount = [allTicket count];
    
    TicketInfo *ticket = [TicketInfo MR_createEntity];
    
    if ([subType_ isEqualToString:@"胆拖"]) {
        NSArray *frontDanTuoArr = [RandomBetNubmer randomDLTNumberCount:5 total:35 betType:GameBetTypeDLTDantuo];
        NSArray *backDanTuoArr = [RandomBetNubmer randomDLTNumberCount:2 total:12 betType:GameBetTypeDLTDantuo];
        NSArray *frontDanArr = frontDanTuoArr[0];
        NSArray *frontTuoArr = frontDanTuoArr[1];
        NSArray *backDanArr = backDanTuoArr[0];
        NSArray *backTuoArr = backDanTuoArr[1];
        
        NSString *betNumber = [ReplaceOfString setDantuoBetNumbersFrontArr1:frontDanArr frontArr2:frontTuoArr backArr1:backDanArr backArr2:backTuoArr];
        NSString *displayNumber = [ReplaceOfString setDantuoDisplayBetNumbersFrontArr1:frontDanArr frontArr2:frontTuoArr backArr1:backDanArr backArr2:backTuoArr];
        
        ticket.idx = @(allCount+1);
        ticket.displayDetail = displayNumber;
        ticket.betDetail = betNumber;
        ticket.subType = @"胆拖";
        ticket.pickMethod = @"4";
        ticket.betType = @"2";
        ticket.isDirect = @"0";
        ticket.region = @"2";
        ticket.groupIdx = @"0";
        ticket.bet = @"10";
        ticket.money = @"20";
        ticket.gameType = @"大乐透";
        ticket.createTime = [NSDate date];
        [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
    }else{
        NSArray *frontArr = [RandomBetNubmer randomDLTNumberCount:5 total:35 betType:GameBetTypeDLTPutong];
        NSArray *backArr = [RandomBetNubmer randomDLTNumberCount:2 total:12 betType:GameBetTypeDLTPutong];
        
        NSString *betNumber = [ReplaceOfString setPutongBetNumbersFrontArr:frontArr backArr:backArr];
        NSString *displayNumber = [ReplaceOfString setPutongDisplayNumbersFrontArr:frontArr backArr:backArr];
        
        ticket.idx = @(allCount+1);
        ticket.displayDetail = displayNumber;
        ticket.betDetail = betNumber;
        ticket.subType = @"单式";
        ticket.pickMethod = @"1";
        ticket.betType = @"1";
        ticket.isDirect = @"0";
        ticket.region = @"2";
        ticket.groupIdx = @"0";
        ticket.bet = @"1";
        ticket.money = @"2";
        ticket.gameType = @"大乐透";;
        ticket.createTime = [NSDate date];
        [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
    }
    
    [_dataArray insertObject:ticket atIndex:0];
    
    [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];
    
    //        [_tableView reloadData];
    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    
    
    [self ifShowNoMatchImage];
}

#pragma mark - BetFooterViewDelegate
/**
 追加投注
 */
- (void)appendButtonAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        [self saveAdditionid:@"1"];
        _baseMutilple = 3;
        [button setImage:[UIImage imageNamed:@"append_icon_select"] forState:UIControlStateNormal];
        
        [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];
        [_tableView reloadData];
    }
    if (!button.selected) {
        [self saveAdditionid:@"0"];
        _baseMutilple = 2;
        [button setImage:[UIImage imageNamed:@"append_icon_unselect"] forState:UIControlStateNormal];
        
        [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];
        [_tableView reloadData];
    }
}

/**
 获取追号、追期
 */
- (void)getMutiple:(NSString *)mutiple appendDraw:(NSString *)draw
{
    tempMutiple = [mutiple integerValue];
    tempAppendDraw = [draw integerValue];
    
    [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];
}
/**
 保存号码
 */
- (void)leftFooterButtonAction
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MyLocalizedString(@"alert")
                                                        message:@"该功能暂未开放，请您耐心等待..."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    /**
    if ([_dataArray count] > 0) {
        NSString *accountId = [UserManager readAccount];
        if ([accountId length] == 0) {
            if (self.loginController == nil) {
                self.loginController =  [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                [self.navigationController pushViewController:self.loginController animated:YES];
            }
        }else {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:dd:ss"];
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            NSString *createDate = [dateString substringToIndex:11];
            //NSString *createTime = [dateString substringFromIndex:11];
            
            NSInteger totlaMoney = 0;
            int totalBet = 0;
            for (TicketInfo *ti in _dataArray) {
                NSInteger timoney = [ti.bet integerValue] * _baseMutilple;
                totlaMoney = totlaMoney + timoney;
                totalBet = totalBet + [ti.bet intValue];
                MyTicketInfo *info = [MyTicketInfo MR_createEntity];
                info.gameNo = _gameNo;
                info.gameName = _gameName;
                info.bet = ti.bet;
                info.betType = ti.betType;
                info.betDetail = ti.betDetail;
                info.displayDetail = ti.displayDetail;
                info.gameType = ti.gameType;
                info.groupIdx = ti.groupIdx;
                info.isDirect = ti.isDirect;
                info.money = [NSString stringWithFormat:@"%@", @(timoney)];
                info.pickMethod = ti.pickMethod;
                info.region = ti.region;
                info.subType = ti.subType;
                info.createDate = createDate;
                info.createTime = dateString;
                [[info managedObjectContext] MR_saveToPersistentStoreAndWait];
            }
            
            
            NSString *pid = [DataBaseManager findLocationProvinceCode];//省编码
            NSString *additionid_ = [self readAdditionid];//追加
            
            MyBetInfo *betInfo = [MyBetInfo MR_createEntity];
            betInfo.provid = pid;
            betInfo.fid = kRecordDLTNumbersFid;
            betInfo.additionId = additionid_;
            betInfo.gameNo = _gameNo;
            betInfo.gameName = _gameName;
            betInfo.createTime = dateString;
            betInfo.createDate = createDate;
            betInfo.totalBet = [NSString stringWithFormat:@"%d", totalBet];
            betInfo.totalMoney = [NSString stringWithFormat:@"%@", @(totlaMoney*tempAppendDraw*tempMutiple)];
            betInfo.draw = [NSString stringWithFormat:@"%@", @(tempAppendDraw)];
            betInfo.mutiple = [NSString stringWithFormat:@"%@", @(tempMutiple)];
            [[betInfo managedObjectContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                if (error == NULL) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MyLocalizedString(@"save success")
                                                                        message:MyLocalizedString(@"save success alert")
                                                                       delegate:self
                                                              cancelButtonTitle:@"继续选号"
                                                              otherButtonTitles:@"去查看", nil];
                    alertView.tag = kBetContentAlertTagSave;
                    [alertView show];
                }else {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MyLocalizedString(@"alert")
                                                                        message:@"保存失败"
                                                                       delegate:self
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:MyLocalizedString(@"OK"), nil];
                    [alertView show];
                }
            }];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MyLocalizedString(@"alert")
                                                            message:@"您的投注内容为空"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:MyLocalizedString(@"OK"), nil];
        [alertView show];
    }
     */
}

/**
 确认-生成投注二维码
 */
- (void)rightFooterButtonAction
{
    if (_totalMoney > 0) {
        NSString * n = get_random_uuid();
        
        
        NSData *nsdata = [n
                          dataUsingEncoding:NSUTF8StringEncoding];
        
        // Get NSString from NSData object in Base64
        NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
        APPFaceSharingView *share = [[APPFaceSharingView alloc] initWithTitle:@"请到附近彩票店投注" qrcodeImage:nil qrcodeImageStr:base64Encoded Desc:nil];
        
        [share show];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"还没有选择号码哦" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (void)resetAllSelectData
{
    tempMutiple = 1;
    tempAppendDraw = 1;
    
    _footerView.multipleTextField.text = @"1";
    _footerView.drawTextField.text = @"1";
    
    _baseMutilple = 2;
    [_footerView.appendButton setImage:[UIImage imageNamed:@"append_icon_unselect"] forState:UIControlStateNormal];
    _footerView.appendButton.selected = NO;
    
    [self displayMoneyTextLabelWithBet:0];
    
    [self saveAdditionid:@"0"];
}

#pragma mark - BetContentCellDelegate
- (void)delCellButton:(UIButton *)button
{
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(BetContentCell *)[[button superview] superview]];
    }else{
        indexPath = [_tableView indexPathForCell:(BetContentCell *)[[[button superview] superview] superview]];
    }
    
    TicketInfo *ti = _dataArray[indexPath.row];
    [ti MR_deleteEntity];
    [[ti managedObjectContext] MR_saveToPersistentStoreAndWait];
    
    [_dataArray removeObjectAtIndex:indexPath.row];

    if ([_dataArray count] == 0) {
        [self resetAllSelectData];
    }else{
        [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];
    }
    
//    [_tableView reloadData];
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self ifShowNoMatchImage];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell1";
    
    BetContentCell *cell = (BetContentCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[BetContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.delegate = self;
    
    TicketInfo *ti = _dataArray[indexPath.row];
    
    cell.numbersLabel.text = ti.displayDetail;
    
    cell.descLabel.text = [NSString stringWithFormat:@"%@ %@ %@注%@元", ti.gameType, ti.subType, ti.bet, ti.money];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BetContentCell *cell = (BetContentCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return [cell cellHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketInfo *ti = _dataArray[indexPath.row];
    NSLog(@"didSelectRowAtIndexPath = %@ (%@)", ti.displayDetail, ti.idx);
    DLTViewController *controller = [[DLTViewController alloc] init];
    controller.isHomePush = NO;
    controller.gameNo = _gameNo;
    controller.updateNumbers = ti.displayDetail;
    controller.ticketInfoIdx = ti.idx;
    controller.ticketBet = [ti.bet integerValue];
    if ([ti.subType isEqualToString:@"胆拖"]) {
        controller.isDanTuo = YES;
    }else{
        controller.isDanTuo = NO;
    }
    CSLCNavigationController *navController = [[CSLCNavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];
}


- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegin");
}//开始晃动
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"motionEnd");

    [self randomOneGame];
    
    
}//晃动结束
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"motionCancel");
}//取消晃动

-(void)ifShowNoMatchImage
{
    if ([_dataArray count]>0) {
        noMatchBGV.hidden = YES;
    }
    else
        noMatchBGV.hidden = NO;
}

@end
