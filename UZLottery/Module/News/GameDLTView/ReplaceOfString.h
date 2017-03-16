//
//  ReplaceOfString.h
//  CSLCLottery
//
//  Created by 李伟 on 13-5-30.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline NSString * get_random_uuid()

{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    
    CFRelease(uuid_ref);
    
    NSString *uuid =  [[NSString  alloc]initWithCString:CFStringGetCStringPtr(uuid_string_ref, 0) encoding:NSUTF8StringEncoding];
    
    //    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    CFRelease(uuid_string_ref);
    
    return uuid;
    
}

@interface ReplaceOfString : NSObject

/**
 去掉10以下数字前面的0，比如 01去掉0变为1
 */
+ (NSString *)betNumberByReplacingOfString:(NSString *)string;

/**
 给10以下的数字加0，比如 1为01
 @param  string   获取到的号码信息
 @return 加0后的内容
 */
+ (NSString *)lottoNumberByAppendingString:(NSString *)string;

/**
 给10以下的数字加0，比如 1为01
 @param  string   获取到的号码信息 胆拖-，前后区@
 @return 加0后的内容
 */
+ (NSString *)appendingNumberZeroByString:(NSString *)string;

+ (NSString *)myBankCardFormat:(NSString *)bankNo;

+ (NSString *)inputBankCardAndFormat:(NSString *)string;

+ (NSString *)myMobileFormat:(NSString *)mobile;

/**
 拼成普通投注的字符串
 */
+ (NSString *)setPutongBetNumbersFrontArr:(NSArray *)frontArr backArr:(NSArray *)backArr;
/**
 拼成普通投注界面显示的字符串
 */
+ (NSString *)setPutongDisplayNumbersFrontArr:(NSArray *)frontArr backArr:(NSArray *)backArr;
/**
 拼成胆拖投注的字符串
 */
+ (NSString *)setDantuoBetNumbersFrontArr1:(NSArray *)frontArr1 frontArr2:(NSArray *)frontArr2 backArr1:(NSArray *)backArr1 backArr2:(NSArray *)backArr2;
/**
 拼成胆拖界面显示的字符串
 */
+ (NSString *)setDantuoDisplayBetNumbersFrontArr1:(NSArray *)frontArr1 frontArr2:(NSArray *)frontArr2 backArr1:(NSArray *)backArr1 backArr2:(NSArray *)backArr2;

+ (NSString *)changeMonthToHanziWithStr:(NSString *)str;


+(NSString *)getWeekDay:(NSDate *)datetime;

+(NSString *)getMyUUID;

+(NSString *)dynamicMessageTime:(NSString *)messageTime SystemTime:(NSString *)sysTime;



@end
