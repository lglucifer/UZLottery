//
//  GP11in5Description.m
//  CSLCShop
//
//  Created by 李伟 on 15/2/7.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import "GP11in5Description.h"
//#import "DataBaseManager.h"
//#import "Province.h"
static NSString * const kQyi = @"13"; //任选一;
static NSString * const kQerZhixuan = @"130"; //前二直选
static NSString * const kQerZuxuan = @"65"; //前二组选
static NSString * const kQsanZhixuan = @"1170"; //前三直选
static NSString * const kQsanZuxuan = @"195"; //前三组选
static NSString * const kRxuaner = @"6"; //任选二
static NSString * const kRxuansan = @"19"; //任选三
static NSString * const kRxuansi = @"78"; //任选四
static NSString * const kRxuanwu = @"540"; //任选五
static NSString * const kRxuanliu = @"90"; //任选六
static NSString * const kRxuanqi = @"26"; //任选七
static NSString * const kRxuanba = @"9"; //任选八



static NSString * const HeNankQyi = @"11"; //任选一;
static NSString * const HeNankQerZhixuan = @"110"; //前二直选
static NSString * const HeNankQerZuxuan = @"55"; //前二组选
static NSString * const HeNankQsanZhixuan = @"990"; //前三直选
static NSString * const HeNankQsanZuxuan = @"165"; //前三组选
static NSString * const HeNankRxuaner = @"5"; //任选二
static NSString * const HeNankRxuansan = @"16"; //任选三
static NSString * const HeNankRxuansi = @"66"; //任选四
static NSString * const HeNankRxuanwu = @"460"; //任选五
static NSString * const HeNankRxuanliu = @"78"; //任选六
static NSString * const HeNankRxuanqi = @"22"; //任选七
static NSString * const HeNankRxuanba = @"8"; //任选八

@implementation GP11in5Description

- (id)init
{
    self = [super init];
    if (self) {
        self.ren1Name = @"任选一";
        self.q2ZhiXuanName = @"前二直选";
        self.q2ZuXuanName = @"前二组选";
        self.q3ZhiXuanName = @"前三直选";
        self.q3ZuXuanName = @"前三组选";
        self.ren2Name = @"任选二";
        self.ren3Name = @"任选三";
        self.ren4Name = @"任选四";
        self.ren5Name = @"任选五";
        self.ren6Name = @"任选六";
        self.ren7Name = @"任选七";
        self.ren8Name = @"任选八";
        
//        self.puTongNamesArr = @[self.ren1Name,
//                                self.q2ZhiXuanName,
//                                self.q2ZuXuanName,
//                                self.q3ZhiXuanName,
//                                self.q3ZuXuanName,
//                                self.ren2Name,
//                                self.ren3Name,
//                                self.ren4Name,
//                                self.ren5Name,
//                                self.ren6Name,
//                                self.ren7Name,
//                                self.ren8Name];
//        
//        self.danTuoNamesArr = @[self.q2ZuXuanName,
//                                self.q3ZuXuanName,
//                                self.ren2Name,
//                                self.ren3Name,
//                                self.ren4Name,
//                                self.ren5Name,
//                                self.ren6Name,
//                                self.ren7Name];
        
        
        
        self.puTongNamesArr = @[self.ren1Name,
                                self.ren2Name,
                                self.ren3Name,
                                self.ren4Name,
                                self.ren5Name,
                                self.ren6Name,
                                self.ren7Name,
                                self.ren8Name,
                                self.q2ZhiXuanName,
                                self.q2ZuXuanName,
                                self.q3ZhiXuanName,
                                self.q3ZuXuanName,
                                ];
        
        self.danTuoNamesArr = @[
                                self.ren2Name,
                                self.ren3Name,
                                self.ren4Name,
                                self.ren5Name,
                                self.ren6Name,
                                self.ren7Name,
                                self.q2ZuXuanName,
                                self.q3ZuXuanName,
                                ];
    }
    return self;
}

- (NSDictionary *)moneyDic
{
    NSDictionary *dic = [GP11in5Description HeNanProv] ?
    @{self.ren1Name: HeNankQyi,
      self.q2ZhiXuanName: HeNankQerZhixuan,
      self.q3ZhiXuanName: HeNankQsanZhixuan,
      self.q2ZuXuanName: HeNankQerZuxuan,
      self.q3ZuXuanName: HeNankQsanZuxuan,
      self.ren2Name: HeNankRxuaner,
      self.ren3Name: HeNankRxuansan,
      self.ren4Name: HeNankRxuansi,
      self.ren5Name: HeNankRxuanwu,
      self.ren6Name: HeNankRxuanliu,
      self.ren7Name: HeNankRxuanqi,
      self.ren8Name: HeNankRxuanba} :
                        @{self.ren1Name: kQyi,
                          self.q2ZhiXuanName: kQerZhixuan,
                          self.q3ZhiXuanName: kQsanZhixuan,
                          self.q2ZuXuanName: kQerZuxuan,
                          self.q3ZuXuanName: kQsanZuxuan,
                          self.ren2Name: kRxuaner,
                          self.ren3Name: kRxuansan,
                          self.ren4Name: kRxuansi,
                          self.ren5Name: kRxuanwu,
                          self.ren6Name: kRxuanliu,
                          self.ren7Name: kRxuanqi,
                          self.ren8Name: kRxuanba};
    return dic;
}

- (NSDictionary *)groupIdIndex
{
    NSDictionary *dic = @{self.ren1Name: @"1",
                          self.q2ZhiXuanName:@"4",
                          self.q3ZhiXuanName:@"7",
                          self.q2ZuXuanName: @"3",
                          self.q3ZuXuanName: @"6",
                          self.ren2Name: @"2",
                          self.ren3Name: @"5",
                          self.ren4Name: @"8",
                          self.ren5Name: @"9",
                          self.ren6Name: @"10",
                          self.ren7Name: @"11",
                          self.ren8Name: @"12"};
    return dic;
}

- (NSDictionary *)puTongVerifyData
{
    NSDictionary *dic = @{self.ren1Name: @"1",
                          self.q2ZhiXuanName: @"2",
                          self.q3ZhiXuanName: @"3",
                          self.q2ZuXuanName: @"2",
                          self.q3ZuXuanName: @"3",
                          self.ren2Name: @"2",
                          self.ren3Name: @"3",
                          self.ren4Name: @"4",
                          self.ren5Name: @"5",
                          self.ren6Name: @"6",
                          self.ren7Name: @"7",
                          self.ren8Name: @"8"};
    return dic;
}

//普通投注说明
- (NSDictionary *)puTongDictionaryData
{
    NSDictionary *ptDic = @{self.ren1Name: [NSString stringWithFormat:@"至少选1个号码，猜中第1个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankQyi : kQyi],
                            self.q2ZhiXuanName: [NSString stringWithFormat:@"每位至少选1个号码，按位猜中前2个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankQerZhixuan : kQerZhixuan],
                            self.q3ZhiXuanName: [NSString stringWithFormat:@"每位至少选1个号码，按位猜中前3个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankQsanZhixuan : kQsanZhixuan],
                            self.q2ZuXuanName: [NSString stringWithFormat:@"至少选2个号码，猜中前2个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankQerZuxuan : kQerZuxuan],
                            self.q3ZuXuanName: [NSString stringWithFormat:@"至少选3个号码，猜中前3个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankQsanZuxuan : kQsanZuxuan],
                            self.ren2Name: [NSString stringWithFormat:@"至少选2个号码，猜中任意2个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankRxuaner : kRxuaner],
                            self.ren3Name: [NSString stringWithFormat:@"至少选3个号码，猜中任意3个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankRxuansan : kRxuansan],
                            self.ren4Name: [NSString stringWithFormat:@"至少选4个号码，猜中任意4个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankRxuansi : kRxuansi],
                            self.ren5Name: [NSString stringWithFormat:@"至少选5个号码，猜中全部5个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankRxuanwu : kRxuanwu],
                            self.ren6Name: [NSString stringWithFormat:@"至少选6个号码，选号包含5个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankRxuanliu : kRxuanliu],
                            self.ren7Name: [NSString stringWithFormat:@"至少选7个号码，选号包含5个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankRxuanqi : kRxuanqi],
                            self.ren8Name: [NSString stringWithFormat:@"选8个号码，选号包含5个开奖号即中%@元", [GP11in5Description HeNanProv] ? HeNankRxuanba : kRxuanba]};
    return ptDic;
}

//胆拖投注说明
- (NSDictionary *)danTuoDictionaryData
{
    NSDictionary *dtDic = @{self.q2ZuXuanName: [NSString stringWithFormat:@"选1个胆码，2~10个拖码，胆码+拖码≥3个，单注奖金%@元", [GP11in5Description HeNanProv] ? HeNankQerZuxuan : kQerZuxuan],
                            self.q3ZuXuanName: [NSString stringWithFormat:@"选1~2个胆码，2~10个拖码，胆码+拖码≥4个，单注奖金%@元", [GP11in5Description HeNanProv] ? HeNankQsanZuxuan : kQsanZuxuan],
                            self.ren2Name: [NSString stringWithFormat:@"选1个胆码，2~10个拖码，胆码+拖码≥3，单注奖金%@元", [GP11in5Description HeNanProv] ? HeNankRxuaner : kRxuaner],
                            self.ren3Name: [NSString stringWithFormat:@"选1~2个胆码，2~10个拖码，胆码+拖码≥4个，单注奖金%@元", [GP11in5Description HeNanProv] ? HeNankRxuansan : kRxuansan],
                            self.ren4Name: [NSString stringWithFormat:@"选1~3个胆码，2~10个拖码，胆码+拖码≥5个，单注奖金%@元", [GP11in5Description HeNanProv] ? HeNankRxuansi : kRxuansi],
                            self.ren5Name: [NSString stringWithFormat:@"选1~4个胆码，2~10个拖码，胆码+拖码≥6个，单注奖金%@元", [GP11in5Description HeNanProv] ? HeNankRxuanwu : kRxuanwu],
                            self.ren6Name: [NSString stringWithFormat:@"选1~5个胆码，2~10个拖码，胆码+拖码≥7个，单注奖金%@元", [GP11in5Description HeNanProv] ? HeNankRxuanliu : kRxuanliu],
                            self.ren7Name: [NSString stringWithFormat:@"选1~6个胆码，2~10个拖码，胆码+拖码≥8个，单注奖金%@元", [GP11in5Description HeNanProv] ? HeNankRxuanqi : kRxuanqi]
                            };
    return dtDic;
}

//金额
- (NSDictionary *)payDicData
{
    NSDictionary *payDic = [GP11in5Description HeNanProv] ?
                            @{self.ren1Name:  HeNankQyi,
                             self.q2ZhiXuanName: HeNankQerZhixuan,
                             self.q3ZhiXuanName: HeNankQsanZhixuan,
                             self.q2ZuXuanName: HeNankQerZuxuan,
                             self.q3ZuXuanName: HeNankQsanZuxuan,
                             self.ren2Name: HeNankRxuaner,
                             self.ren3Name: HeNankRxuansan,
                             self.ren4Name: HeNankRxuansi,
                             self.ren5Name: HeNankRxuanwu,
                             self.ren6Name: HeNankRxuanliu,
                             self.ren7Name: HeNankRxuanqi,
                             self.ren8Name: HeNankRxuanba}
                            :
                            @{self.ren1Name:  kQyi,
                              self.q2ZhiXuanName: kQerZhixuan,
                              self.q3ZhiXuanName: kQsanZhixuan,
                              self.q2ZuXuanName: kQerZuxuan,
                              self.q3ZuXuanName: kQsanZuxuan,
                              self.ren2Name: kRxuaner,
                              self.ren3Name: kRxuansan,
                              self.ren4Name: kRxuansi,
                              self.ren5Name: kRxuanwu,
                              self.ren6Name: kRxuanliu,
                              self.ren7Name: kRxuanqi,
                              self.ren8Name: kRxuanba};
    return payDic;
}

+(BOOL)HeNanProv
{

    return NO;
}


@end
