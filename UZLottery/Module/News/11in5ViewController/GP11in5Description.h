//
//  GP11in5Description.h
//  CSLCShop
//
//  Created by 李伟 on 15/2/7.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

//pickMethod
typedef NS_ENUM(NSInteger, kGame11in5SubType) {
    kGame11in5SubTypeDanShi = 1,//单式
    kGame11in5SubTypeZhi2DF = 2,//前2直选定位复式
    kGame11in5SubTypeZhi3DF = 2,//前3直选定位复式
    kGame11in5SubTypeFuShi = 3,//复式
    kGame11in5SubTypeDanTuo = 4,//胆拖
    kGame11in5SubTypeQ2ZuHZ = 16,//前2组选和值
    kGame11in5SubTypeQ2ZuKD = 17,//前2组选跨度
    kGame11in5SubTypeQ2ZhiHZ = 18,//前2直选和值
    kGame11in5SubTypeQ2ZhiKD = 19,//前2直选跨度
    kGame11in5SubTypeQ3ZuHZ = 21,//前3组选和值
    kGame11in5SubTypeQ3ZuKD = 22,//前3组选跨度
    kGame11in5SubTypeQ3ZhiHZ = 23,//前3直选和值
    kGame11in5SubTypeQ3ZhiKD = 24,//前3直选跨度
};

@interface GP11in5Description : NSObject

@property (nonatomic, strong) NSString *q2ZuXuanName;
@property (nonatomic, strong) NSString *q2ZhiXuanName;
@property (nonatomic, strong) NSString *q3ZuXuanName;
@property (nonatomic, strong) NSString *q3ZhiXuanName;
@property (nonatomic, strong) NSString *ren1Name;
@property (nonatomic, strong) NSString *ren2Name;
@property (nonatomic, strong) NSString *ren3Name;
@property (nonatomic, strong) NSString *ren4Name;
@property (nonatomic, strong) NSString *ren5Name;
@property (nonatomic, strong) NSString *ren6Name;
@property (nonatomic, strong) NSString *ren7Name;
@property (nonatomic, strong) NSString *ren8Name;

@property (nonatomic, strong) NSArray *puTongNamesArr;//普通投注
@property (nonatomic, strong) NSArray *danTuoNamesArr;//胆拖投注

- (id)init;

- (NSDictionary *)moneyDic;
- (NSDictionary *)groupIdIndex;
- (NSDictionary *)puTongVerifyData;
- (NSDictionary *)puTongDictionaryData;
- (NSDictionary *)danTuoDictionaryData;
- (NSDictionary *)payDicData;

@end
