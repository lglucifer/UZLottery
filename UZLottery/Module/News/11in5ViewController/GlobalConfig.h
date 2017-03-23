//
//  Config.h
//  CSLCLottery
//
//  Created by 李伟 on 13-1-21.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//


#define kAppAdStartTime 3


#define AppDownloadURL @"http://fir.im/cslcios"//http://pre.im/cs1212


#define kRecordNewBieNumbersFid  @"01"  // 零钱购  fid=
#define kRecordLuckyNumbersFid   @"02"  //幸运购
#define kRecordDLTNumbersFid     @"04"  //大乐透
#define kRecord11in5NumbersFid   @"05"  //11选5
#define kRecordFootballNumbersFid   @"06"  //竞彩足球
#define kRecordBaskballNumbersFid   @"07"  //竞彩篮球
#define kRecordForteenNumbersFid   @"08"  //14场
#define kRecordNineNumbersFid   @"09"  //任选9
#define kRecordPoker3NumbersFid   @"10"  //快乐扑克3

//------

#define is_iPad  [[UIDevice currentDevice].model rangeOfString:@"iPad"]

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define VersionNumber_iOS_10  [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0
#define VersionNumber_iOS_8  [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define VersionNumber_iOS_7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 //floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1

#define MyLocalizedString(S)  NSLocalizedString(S, @"")

#define CurrentAppVersion   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kMaximumLeftDrawerWidth  150.f
#define kMaximumRightDrawerWidth  [[UIScreen mainScreen] bounds].size.width

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kDefalutCommodityImageDownload  @"默认下载图.png"
#define kDefalutFlagImageDownload       @"albums.png"

#define kHomePageTimeNotificationName @"HomePageTimeNotificationName"
#define kHomePageCatagoryNotificationName @"HomePageCatagoryNotificationName"




//--------登录测试
#define TestSessionKey    @"abcdefghigklmn12345678"
#define TestUserName      @"cslc"
#define TestPassword      @"123456"


//---- 投注号码的分隔符
#define kBetNumbersSeparator1            @"+"
#define kBetNumbersSeparator2            @"-"
#define kBetNumbersSeparator3            @"@"
#define kBetNumbersDisplaySeparator      @" "

//-- 投注二维码 说明
#define KQRCode11in5Title(T,S,M,A)       [NSString stringWithFormat:@"11选5(%@ %@ 倍投%d 期数%d)", T, S, M, A]
#define KQRCodeJCFootballTitle(T,F,M)    [NSString stringWithFormat:@"竞彩足球(%@ %@ 倍投%@)", T, F, M]
#define KQRCodeJCBasketballTitle(T,F,M)  [NSString stringWithFormat:@"竞彩篮球(%@ %@ 倍投%@)", T, F, M]

// -- 全局颜色
#define kBackgroundGlobalRedColor         [UIColor colorRGBWithRed:193.f green:43.f blue:53.f alpha:1.f]
#define kBackgroundGlobalDarkColor        [UIColor colorRGBWithRed:241.f green:241.f blue:241.f alpha:1.f]
#define kFotterViewBackgroundGlobalColor  [UIColor colorRGBWithRed:82.f green:82.f blue:82.f alpha:1.f]

//---红球、篮球颜色
#define kDisplayRedBallColor     [UIColor colorRGBWithRed:166.f green:0 blue:0 alpha:1.f]
#define kDisplayBlueBallColor    [UIColor colorRGBWithRed:12.f green:52.f blue:174.f alpha:1.f]

//--- 竞彩cell 颜色
#define kJCSPFCellButtonBackgroundColor [UIColor whiteColor]
//#define kJCSPFCellButtonBackgroundSelectedColor [UIColor colorRGBWithRed:193.f green:43.f blue:53.f alpha:1.f]
#define kJCSPFCellButtonTitleTextColor [UIColor colorRGBWithRed:48.f green:48.f blue:48.f alpha:1.f]
#define kJCSPFCellButtonTitleSelectedTextColor [UIColor whiteColor]

#define kFootballScoreDrawTitleBgColor  [UIColor colorRGBWithRed:40.f green:122.f blue:207.f alpha:1.f]
#define kFootballScoreLostTitleBgColor  [UIColor colorRGBWithRed:74.f green:167.f blue:66.f alpha:62.f]

#define kFootballScoreWinSelectBgColor   [UIColor colorRGBWithRed:240.f green:122.f blue:124.f alpha:1.f]
#define kFootballScoreDrawSelectBgColor  [UIColor colorRGBWithRed:122.f green:169.f blue:224.f alpha:1.f]
#define kFootballScoreLostSelectBgColor  [UIColor colorRGBWithRed:117.f green:197.f blue:116.f alpha:1.f]

#define kSPFCellRballViewBgColor1 [UIColor colorRGBWithRed:251.f green:142.f blue:70.f alpha:1.f] //+1
#define kSPFCellRballViewBgColor2 [UIColor colorRGBWithRed:112.f green:184.f blue:34.f alpha:1.f] //-1

#define kJCMatchesResultTextColor     [UIColor blackColor]
#define kJCMatchesOddsResultTextColor [UIColor darkGrayColor]
//--
#define kAreaSelect @"选择地区"

#define kLocationProvinceId @"kLocationProvinceId"

#define LocationServiceEnabled  1
#define LocationCompleted  @"locationmanegercompleted"
#define LocationResult  @"locationresult"


#define CSLCService @"cslcchinasportslotterys_90iuy"
#define LOCALRANDOMUUID  @"randomuuid"
#define MYDEVICENAME  @"mydevicename"

#define kAPPFunctionTagKey @"app_function_tag_key"
#define kAPPFunctionContentKey  @"app_function_content_key"
#define kAPPFunctionItemsKey  @"app_function_items_key"

#define kAPPFunctionJiFenTongPay  @"app_function_jifentong_pay"
#define kAPPFunctionAliPay  @"app_function_ali_pay"
#define kAPPFunctionWechatPay  @"app_function_wechat_pay"
#define kAPPFunctionLocationFlag  @"app_function_location_need_when_bet"


#define kJCFBGameTypes  @[@"胜平负", @"让球胜平负", @"比分", @"总进球数", @"半全场", @"混合过关"]
#define kJCBKGameTypes  @[@"胜负", @"让分胜负", @"胜分差", @"大小分", @"混合过关"]

#define MAXBETMONEY  50000
#define ATTENTIONBETCOUNT 200
#define MAXBETCOUNT  500

#define BETCOUNTSERVICE  @"betCountJudgeService"
#define BET_COUNT @"today_betcount"
#define BET_TIME @"lastBetTime"
#define BET_TOTAL_MONEY @"today_bet_total_money"

#define LocationDeniedTag  6574


