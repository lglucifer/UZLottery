//
//  BetContentListViewController.m
//  CSLCPlay
//
//  Created by liwei on 15/10/13.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "BetContentListViewController.h"
#import "QRCodeViewController.h"

#import "Game11in5ViewController.h"
#import "CSLCNavigationController.h"


#import "BetFooterView.h"
#import "BetContentCell.h"


#import "TicketInfo.h"
#import "MyBetInfo.h"
#import "MyTicketInfo.h"

#import "APPFaceSharingView.h"

#import "RandomBetNubmer.h"

#import "BetContentModel.h"
#import "GP11in5Description.h"
#import "ReplaceOfString.h"
#import "CombineArithmetic.h"

#import "GameBetFormatHeader.h"




@interface BetContentListViewController ()<UITableViewDelegate, UITableViewDataSource, BetFooterViewDelegate, BetContentCellDelegate, UIAlertViewDelegate, UIActionSheetDelegate>
{
    NSInteger tempMutiple;
    NSInteger tempAppendDraw;
    
    UIView * noMatchBGV;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BetFooterView *footerView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) QRCodeViewController *qrCodeController;


@property (nonatomic, assign) NSInteger totalMoney;

@end

typedef NS_ENUM(NSInteger, kBetContentAlertTag)
{
    kBetContentAlertTagBack = 1000,
    kBetContentAlertTagClearAll = 1001,
    kBetContentAlertTagSave = 1002
};

@implementation BetContentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kBackgroundGlobalDarkColor;
   
    self.title = MyLocalizedString(@"投注确认");

    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    
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
        button.backgroundColor = [UIColor whiteColor];
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
    
    NSArray *ticketInfoArr = [TicketInfo MR_findAllSortedBy:@"createTime" ascending:NO];
    
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
        [_footerView setup11in5TextField];
    }
    _footerView.delegate = self;
    

        _footerView.maxBetCount = 999;
    
    
    tempMutiple = [_footerView.multipleTextField.text integerValue];
    tempAppendDraw = [_footerView.drawTextField.text integerValue];
    
    [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];
    
    [self.view addSubview:_footerView];
    [_tableView reloadData];
    
    
    [self ifShowNoMatchImage];

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

- (void)resetAllSelectData
{
    tempMutiple = 1;
    tempAppendDraw = 1;
    
    _footerView.multipleTextField.text = @"1";
    _footerView.drawTextField.text = @"1";
    
    [_footerView.appendButton setImage:[UIImage imageNamed:@"append_icon_unselect"] forState:UIControlStateNormal];
    _footerView.appendButton.selected = NO;
    
    [self displayMoneyTextLabelWithBet:0];
    
}


#pragma mark - 计算总的金额、注数、期数、倍数
- (void)displayMoneyTextLabelWithBet:(NSInteger)bet
{
    
    _totalMoney = bet * 2 * tempMutiple * tempAppendDraw;
    NSString *moneystr = [NSString stringWithFormat:@"%@",@(_totalMoney)];
    NSString *betStr = [NSString stringWithFormat:@"%@",@(bet)];
    [_footerView.btnView getBetText:betStr money:moneystr];
    
//    NSString *text = [NSString stringWithFormat:@"共 %@ 注 %@ 元", betStr, moneystr];
//    
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

#pragma mark - headerview button
- (void)headerButtonAction:(id)sender
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idx=%@", @([_dataArray count])];
    NSArray *allTicketArr = [TicketInfo MR_findAllWithPredicate:predicate];
    
    NSInteger tag = [sender tag];
    //自选号码
    if (tag == 0) {
        Game11in5ViewController *controller = [[Game11in5ViewController alloc] init];
        controller.isHomePush = NO;
        controller.gameNo = _gameNo;
        if ([allTicketArr count] > 0) {
            TicketInfo *ticketInfo = allTicketArr[0];
            controller.ticketInfoIdx = ticketInfo.idx;
        }
        CSLCNavigationController *navController = [[CSLCNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
    }
    //机选号码
    if (tag == 1) {
        [self randomOneGame:allTicketArr];
    }
    //清空
    if (tag == 2) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MyLocalizedString(@"alert")
                                                            message:MyLocalizedString(@"clear alert")
                                                           delegate:self
                                                  cancelButtonTitle:@"继续玩"
                                                  otherButtonTitles:MyLocalizedString(@"clear"), nil];
        alertView.tag = kBetContentAlertTagClearAll;
        [alertView show];
    }
}


-(void)randomOneGame:(NSArray *)allTicketArr
{
    GP11in5Description *gpDesc = [[GP11in5Description alloc] init];
    
    NSString *gameType_ = nil;
    NSString *subType_ = nil;
    if ([allTicketArr count] > 0) {
        TicketInfo *ti = allTicketArr[0];
        gameType_ = ti.gameType;
        subType_ = ti.subType;
    }else {
        gameType_ = gpDesc.ren5Name;
        subType_ = @"单式";
    }
    NSInteger groupId_ = [[[gpDesc groupIdIndex] objectForKey:gameType_] integerValue];
    NSInteger count = [[[gpDesc puTongVerifyData] objectForKey:gameType_] integerValue];
    
    NSArray *allTicket = [TicketInfo MR_findAll];
    NSInteger allCount = [allTicket count];
    TicketInfo *ticket = [TicketInfo MR_createEntity];
    
    if ([gameType_ isEqualToString:gpDesc.q2ZhiXuanName]) {
        NSArray *arr = [RandomBetNubmer random11in5NumberCount:2 betType:GameBetType11in5Putong];
        if ([arr count] == 2) {
            NSString *str1 = [ReplaceOfString betNumberByReplacingOfString:arr[0]];
            NSString *str2 = [ReplaceOfString betNumberByReplacingOfString:arr[1]];
            NSString *displayNumber = [NSString stringWithFormat:@"%@%@%@", arr[0], kBetNumbersSeparator2, arr[1]];
            NSString *betNumber = [NSString stringWithFormat:@"%@%@%@", str1, kBetNumbersSeparator1, str2];
            
            ticket.idx = @(allCount+1);
            ticket.displayDetail = displayNumber;
            ticket.betDetail = betNumber;
            ticket.pickMethod = @"1";
            ticket.betType = @"1";
            ticket.subType = @"单式";
            ticket.isDirect = @"0";
            ticket.region = @"1";
            ticket.groupIdx = [NSString stringWithFormat:@"%@", @(groupId_)];
            ticket.bet = @"1";
            ticket.money = @"2";
            ticket.gameType = gameType_;
            ticket.createTime = [NSDate date];
            [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
        }
    }else if ([gameType_ isEqualToString:gpDesc.q3ZhiXuanName]) {
        NSArray *arr = [RandomBetNubmer random11in5NumberCount:3 betType:GameBetType11in5Putong];
        if ([arr count] == 3) {
            NSString *str1 = [ReplaceOfString betNumberByReplacingOfString:arr[0]];
            NSString *str2 = [ReplaceOfString betNumberByReplacingOfString:arr[1]];
            NSString *str3 = [ReplaceOfString betNumberByReplacingOfString:arr[2]];
            NSString *displayNumber = [NSString stringWithFormat:@"%@%@%@%@%@", arr[0], kBetNumbersSeparator2, arr[1], kBetNumbersSeparator2, arr[2]];
            NSString *betNumber = [NSString stringWithFormat:@"%@%@%@%@%@", str1, kBetNumbersSeparator1, str2, kBetNumbersSeparator1, str3];
            
            ticket.idx = @(allCount+1);
            ticket.displayDetail = displayNumber;
            ticket.betDetail = betNumber;
            ticket.pickMethod = @"1";
            ticket.betType = @"1";
            ticket.subType = @"单式";
            ticket.isDirect = @"0";
            ticket.region = @"1";
            ticket.groupIdx = [NSString stringWithFormat:@"%@", @(groupId_)];
            ticket.bet = @"1";
            ticket.money = @"2";
            ticket.gameType = gameType_;
            ticket.createTime = [NSDate date];
            [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
        }
    }else{
        if ([subType_ isEqualToString:@"单式"] || [subType_ isEqualToString:@"复式"]) {
            NSArray *arr = [RandomBetNubmer random11in5NumberCount:count betType:GameBetType11in5Putong];
            NSString *displayNumber = [arr componentsJoinedByString:kBetNumbersSeparator1];
            NSString *betNumber = [ReplaceOfString betNumberByReplacingOfString:displayNumber];
            
            ticket.idx = @(allCount+1);
            ticket.displayDetail = displayNumber;
            ticket.betDetail = betNumber;
            if ([gameType_ isEqualToString:gpDesc.ren1Name]) {
                ticket.pickMethod = @"3";
                ticket.betType = @"2";
                if ([betNumber length] > 2) {
                    ticket.subType = @"复式";
                }else {
                    ticket.subType = @"单式";
                }
            }else{
                ticket.pickMethod = @"1";
                ticket.betType = @"1";
                ticket.subType = @"单式";
            }
            ticket.isDirect = @"0";
            ticket.region = @"1";
            ticket.groupIdx = [NSString stringWithFormat:@"%@", @(groupId_)];
            ticket.bet = @"1";
            ticket.money = @"2";
            ticket.gameType = gameType_;
            ticket.createTime = [NSDate date];
            [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
        }else if ([subType_ isEqualToString:@"胆拖"]) {
            NSArray *arr = [RandomBetNubmer random11in5NumberCount:count betType:GameBetType11in5Dantuo];
            if ([arr count] == 2) {
                NSArray *danArr = arr[0];
                NSArray *tuoArr = arr[1];
                NSString *dan = [danArr lastObject];
                NSString *tuo = [tuoArr componentsJoinedByString:kBetNumbersSeparator1];
                NSString *betDan = [ReplaceOfString betNumberByReplacingOfString:dan];
                NSString *betTuo = [ReplaceOfString betNumberByReplacingOfString:tuo];
                
                NSString *displayNumber = [NSString stringWithFormat:@"%@%@%@", dan, kBetNumbersSeparator2, tuo];
                NSString *betNumber = [NSString stringWithFormat:@"%@%@%@", betDan, kBetNumbersSeparator2, betTuo];
                
                NSInteger nn = count - [danArr count];
                NSInteger bet = [CombineArithmetic getCombineCountWithM:[tuoArr count] n:nn];
                
                ticket.idx = @(allCount+1);
                ticket.displayDetail = displayNumber;
                ticket.betDetail = betNumber;
                ticket.pickMethod = @"4";
                ticket.betType = @"3";
                ticket.subType = @"胆拖";
                ticket.isDirect = @"0";
                ticket.region = @"1";
                ticket.groupIdx = [NSString stringWithFormat:@"%@", @(groupId_)];
                ticket.bet = [NSString stringWithFormat:@"%@", @(bet)];
                ticket.money = [NSString stringWithFormat:@"%@", @(bet*2)];;
                ticket.gameType = gameType_;
                ticket.createTime = [NSDate date];
                [[ticket managedObjectContext] MR_saveToPersistentStoreAndWait];
                
            }
        }
        
    }
    
    [_dataArray insertObject:ticket atIndex:0];
    
    [self displayMoneyTextLabelWithBet:[self ticketTotalBetInfo]];
    
    //        [_tableView reloadData];
    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    
    [self ifShowNoMatchImage];
}

#pragma mark - BetFooterViewDelegate
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
            NSString *createTime = [dateString substringFromIndex:11];
            
            NSInteger totlaMoney = 0;
            int totalBet = 0;
            NSLog(@"createDate = %@, %@", createDate, createTime);
            for (TicketInfo *ti in _dataArray) {
                totlaMoney = totlaMoney + [ti.money integerValue];
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
                info.money = ti.money;
                info.pickMethod = ti.pickMethod;
                info.region = ti.region;
                info.subType = ti.subType;
                info.createDate = createDate;
                info.createTime = dateString;
                [[info managedObjectContext] MR_saveToPersistentStoreAndWait];
            }
            
            //省编码
            NSString *pid = [DataBaseManager findLocationProvinceCode];
            
            MyBetInfo *betInfo = [MyBetInfo MR_createEntity];
            betInfo.provid = pid;
            betInfo.fid = @"05";
            betInfo.additionId = @"0";
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
    NSLog(@"multipleTextField=%@  drawTextField=%@", _footerView.multipleTextField.text, _footerView.drawTextField.text);
    
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
    }else {
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
    Game11in5ViewController *controller = [[Game11in5ViewController alloc] init];
    controller.isHomePush = NO;
    controller.gameNo = _gameNo;
    controller.updateNumbers = ti.displayDetail;
    controller.ticketInfoIdx = ti.idx;
    controller.ticketBet = [ti.bet integerValue];
    CSLCNavigationController *navController = [[CSLCNavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];
}



- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegin");
}//开始晃动
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idx=%@", @([_dataArray count])];
    NSArray *allTicketArr = [TicketInfo MR_findAllWithPredicate:predicate];
    [self randomOneGame:allTicketArr];

    
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
