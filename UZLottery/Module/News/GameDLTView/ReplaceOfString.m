//
//  ReplaceOfString.m
//  CSLCLottery
//
//  Created by 李伟 on 13-5-30.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import "ReplaceOfString.h"
//#import "SFHFKeychainUtils.h"




@implementation ReplaceOfString


/**
 去掉10以下数字前面的0，比如 01去掉0变为1
 @param  string：投注内容
 @return 去掉0后的投注内容
 */
+ (NSString *)betNumberByReplacingOfString:(NSString *)string
{
    NSString *result = nil;
    
    NSString *subString = [string substringWithRange:NSMakeRange(0, [string length])];
    __strong NSArray *array = [subString componentsSeparatedByString:kBetNumbersSeparator1];
    __strong NSMutableArray *mArray = nil;
    if (!mArray) {
        mArray = [NSMutableArray array];
    }
    NSString *tempStr = nil;
    for (int i=0; i<[array count]; i++) {
        if ([array[i] isEqualToString:@"01"] || [array[i] isEqualToString:@"02"] || [array[i] isEqualToString:@"03"] || [array[i] isEqualToString:@"04"] || [array[i] isEqualToString:@"05"] || [array[i] isEqualToString:@"06"] || [array[i] isEqualToString:@"07"] || [array[i] isEqualToString:@"08"] || [array[i] isEqualToString:@"09"])
        {
            tempStr = [array[i] stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }else{
            tempStr = array[i];
        }
        [mArray addObject:tempStr];
    }
    
    result = [mArray componentsJoinedByString:kBetNumbersSeparator1];
    return  result;
}

/**
 给10以下的数字加0，比如 1为01
 @param  string   获取到的号码信息
 @return 加0后的内容
 */
+ (NSString *)lottoNumberByAppendingString:(NSString *)string
{
    NSString *result = @"";
    
    int number = 0;
    NSString *numStr = nil;
    __strong  NSMutableArray *tempArray = nil;
    if (!tempArray) {
        tempArray = [NSMutableArray array];
    }
    
    __strong NSArray *arr = [string componentsSeparatedByString:kBetNumbersSeparator1];
    //DLog(@"%@", arr);
    for (int i=0; i<[arr count]; i++) {
        number = [arr[i] intValue];
        if (number < 10) {
            numStr = [NSString stringWithFormat:@"0%d", number];
        }else {
            numStr = [NSString stringWithFormat:@"%d", number];
        }
        [tempArray addObject:numStr];
    }
    
    result = [tempArray componentsJoinedByString:kBetNumbersSeparator1];
    
    return result;
}

+ (NSString *)appendingNumberZeroByString:(NSString *)string
{
    NSString *result = nil;
    
    NSRange range1 = [string rangeOfString:@"@"];
    if (range1.location != NSNotFound) {
        NSString *redStr = [string substringToIndex:range1.location];
        NSString *blueStr = [string substringFromIndex:range1.location+range1.length];
        NSString *tempRed = nil;
        NSString *tempBlue = nil;
        NSRange range11 = [redStr rangeOfString:@"-"];
        if (range11.location != NSNotFound) {
            NSString *tempStr1 = [redStr substringToIndex:range11.location];
            NSString *tempStr2 = [redStr substringFromIndex:range11.location+range11.length];
            NSString *str1 = [ReplaceOfString betNumberByReplacingOfString:tempStr1];
            NSString *str2 = [ReplaceOfString betNumberByReplacingOfString:tempStr2];
            tempRed = [NSString stringWithFormat:@"(%@)%@", str1, str2];
        }else{
            tempRed = [ReplaceOfString lottoNumberByAppendingString:redStr];
        }
        NSRange range12 = [blueStr rangeOfString:@"-"];
        if (range12.location != NSNotFound) {
            NSString *tempStr1 = [blueStr substringToIndex:range12.location];
            NSString *tempStr2 = [blueStr substringFromIndex:range12.location+range12.length];
            NSString *str1 = [ReplaceOfString betNumberByReplacingOfString:tempStr1];
            NSString *str2 = [ReplaceOfString betNumberByReplacingOfString:tempStr2];
            tempBlue = [NSString stringWithFormat:@"(%@)%@", str1, str2];
        }else{
            tempBlue = [ReplaceOfString betNumberByReplacingOfString:blueStr];
        }
        result = [NSString stringWithFormat:@"%@@%@", tempRed, tempBlue];
    }else{
        NSString *tempStr = nil;
        NSRange range2 = [string rangeOfString:@"-"];
        if (range2.location != NSNotFound) {
            NSMutableArray *tempMutableArr = [[NSMutableArray alloc] init];
            NSArray *array = [string componentsSeparatedByString:@"-"];
            for (NSString *str in array) {
                NSString *rstr = [ReplaceOfString betNumberByReplacingOfString:str];
                [tempMutableArr addObject:rstr];
            }
            tempStr = [tempMutableArr componentsJoinedByString:@"-"];
        }else{
            tempStr = [ReplaceOfString lottoNumberByAppendingString:string];
        }
        result = tempStr;
    }
    
    return result;
}

/**
 银行卡格式化 0000 1111 0000 2222 33
 @param  string   获取到的银行卡信息
 @return 格式化后的字符串
 */
+ (NSString *)myBankCardFormat:(NSString *)bankNo
{
    
    NSString *result = nil;
    
    NSString *space = @" ";
    
    if ([bankNo length] >= 16) {
        NSMutableString *bankNoString = [NSMutableString stringWithString:bankNo];
        [bankNoString insertString:space atIndex:4];
        [bankNoString insertString:space atIndex:5+4];
        [bankNoString insertString:space atIndex:10+4];
        [bankNoString insertString:space atIndex:15+4];
        result = bankNoString;
    }
    if ([bankNo length] == 0) {
        result = bankNo;
    }
    
    return result;
}

+ (NSString *)inputBankCardAndFormat:(NSString *)string
{
    NSString *result = nil;
    NSString *space = @"-";
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    [mutableString appendString:string];
    
    int stringLength = (int)[mutableString length];
    
    if (stringLength >= 4) {
        if (stringLength%5 == 0) {
            NSLog(@"%d", stringLength/4);
            
            [mutableString insertString:space atIndex:stringLength-1];
        }
        result = mutableString;
        
    }else{
        result = mutableString;
    }
    return result;
}

/**
 手机号格式化 133-8888-6666
 @param  string   获取到的银行卡信息
 @return 格式化后的字符串
 */
+ (NSString *)myMobileFormat:(NSString *)mobile
{
    NSString *result = nil;
    
    NSString *space = @"-";
    
    if ([mobile length] >= 8) {
        NSMutableString *mobileString = [NSMutableString stringWithString:mobile];
        [mobileString insertString:space atIndex:3];
        [mobileString insertString:space atIndex:4+4];
        
        result = mobileString;
    }else{
        result = mobile;
    }
    
    return result;
}

#pragma mark - 拼投注字符串
/**
 拼成普通投注的字符串
 */
+ (NSString *)setPutongBetNumbersFrontArr:(NSArray *)frontArr backArr:(NSArray *)backArr
{
    NSString *string = @"";
    NSString *frontStr = [ReplaceOfString betNumberByReplacingOfString:[frontArr componentsJoinedByString:kBetNumbersSeparator1]];
    NSString *backStr = [ReplaceOfString betNumberByReplacingOfString:[backArr componentsJoinedByString:kBetNumbersSeparator1]];
    string = [NSString stringWithFormat:@"%@%@%@", frontStr, kBetNumbersSeparator3, backStr];
    return string;
}

/**
 拼成普通投注界面显示的字符串
 */
+ (NSString *)setPutongDisplayNumbersFrontArr:(NSArray *)frontArr backArr:(NSArray *)backArr
{
    NSString *string = @"";
    NSString *frontStr = [frontArr componentsJoinedByString:kBetNumbersSeparator1];
    NSString *backStr = [backArr componentsJoinedByString:kBetNumbersSeparator1];
    string = [NSString stringWithFormat:@"%@%@%@", frontStr, kBetNumbersDisplaySeparator, backStr];
    return string;
}

/**
 拼成胆拖投注的字符串
 */
+ (NSString *)setDantuoBetNumbersFrontArr1:(NSArray *)frontArr1 frontArr2:(NSArray *)frontArr2 backArr1:(NSArray *)backArr1 backArr2:(NSArray *)backArr2
{
    NSString *string = @"";
    NSString *frontDanStr = @"";
    NSString *frontTuoStr = @"";
    NSString *backDanStr = @"";
    NSString *backTuoStr = @"";
    
    if ([frontArr1 count] > 0) {
        frontDanStr = [ReplaceOfString betNumberByReplacingOfString:[frontArr1 componentsJoinedByString:kBetNumbersSeparator1]];
    }
    if ([frontArr2 count] > 0) {
        frontTuoStr = [ReplaceOfString betNumberByReplacingOfString:[frontArr2 componentsJoinedByString:kBetNumbersSeparator1]];
    }
    if ([backArr1 count] > 0) {
        backDanStr = [ReplaceOfString betNumberByReplacingOfString:[backArr1 componentsJoinedByString:kBetNumbersSeparator1]];
    }
    if ([backArr2 count] > 0) {
        backTuoStr = [ReplaceOfString betNumberByReplacingOfString:[backArr2 componentsJoinedByString:kBetNumbersSeparator1]];
    }
    
    NSString *frontStr= [NSString stringWithFormat:@"%@%@%@", frontDanStr, kBetNumbersSeparator2, frontTuoStr];
    NSString *backStr = [NSString stringWithFormat:@"%@%@%@", backDanStr, kBetNumbersSeparator2, backTuoStr];
    string = [NSString stringWithFormat:@"%@%@%@", frontStr, kBetNumbersSeparator3, backStr];
    
    return string;
}

/**
 拼成胆拖界面显示的字符串
 */
+ (NSString *)setDantuoDisplayBetNumbersFrontArr1:(NSArray *)frontArr1 frontArr2:(NSArray *)frontArr2 backArr1:(NSArray *)backArr1 backArr2:(NSArray *)backArr2
{
    NSString *string = @"";
    NSString *frontDanStr = @"";
    NSString *frontTuoStr = @"";
    NSString *backDanStr = @"";
    NSString *backTuoStr = @"";
    
    if ([frontArr1 count] > 0) {
        frontDanStr = [frontArr1 componentsJoinedByString:kBetNumbersSeparator1];
    }
    if ([frontArr2 count] > 0) {
        frontTuoStr = [frontArr2 componentsJoinedByString:kBetNumbersSeparator1];
    }
    if ([backArr1 count] > 0) {
        backDanStr = [backArr1 componentsJoinedByString:kBetNumbersSeparator1];
    }
    if ([backArr2 count] > 0) {
        backTuoStr = [backArr2 componentsJoinedByString:kBetNumbersSeparator1];
    }
    
    NSString *frontStr= [NSString stringWithFormat:@"(%@)%@", frontDanStr, frontTuoStr];
    NSString *backStr = [NSString stringWithFormat:@"(%@)%@", backDanStr, backTuoStr];
    string = [NSString stringWithFormat:@"%@%@%@", frontStr, kBetNumbersDisplaySeparator, backStr];
    
    return string;
}

+ (NSString *)changeMonthToHanziWithStr:(NSString *)str
{
    NSString * gStr = str;
    if ([str hasPrefix:@"01"]) {
        gStr = @"一";
    }
    else if ([str hasPrefix:@"02"]) {
        gStr = @"二";
    }
    else if ([str hasPrefix:@"03"]) {
        gStr = @"三";
    }
    else if ([str hasPrefix:@"04"]) {
        gStr = @"四";
    }
    else if ([str hasPrefix:@"05"]) {
        gStr = @"五";
    }
    else if ([str hasPrefix:@"06"]) {
        gStr = @"六";
    }
    else if ([str hasPrefix:@"07"]) {
        gStr = @"七";
    }
    else if ([str hasPrefix:@"08"]) {
        gStr = @"八";
    }
    else if ([str hasPrefix:@"09"]) {
        gStr = @"九";
    }
    else if ([str hasPrefix:@"10"]) {
        gStr = @"十";
    }
    else if ([str hasPrefix:@"11"]) {
        gStr = @"十一";
    }
    else if ([str hasPrefix:@"12"]) {
        gStr = @"十二";
    }
    return gStr;
}


+(NSString *)getWeekDay:(NSDate *)datetime{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:datetime];
    switch ([comps weekday]) {
        case 1:
            return @"周日";break;
        case 2:
            return @"周一";break;
        case 3:
            return @"周二";break;
        case 4:
            return @"周三";break;
        case 5:
            return @"周四";break;
        case 6:
            return @"周五";break;
        case 7:
            return @"周六";break;
        default:
            return @"未知";break;
    }
}

//+(NSString *)getMyUUID
//{
//    NSString *uuid = [SFHFKeychainUtils getPasswordForUsername:LOCALRANDOMUUID
//                                                andServiceName:CSLCService
//                                                         error:nil];
//    if (uuid && [uuid length]>0) {
//        return uuid;
//    }
//    else
//    {
//        uuid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//        //        uuid = [SFHFKeychainUtils getPasswordForUsername:LOCALRANDOMUUID
//        //                                          andServiceName:CSLCService
//        //                                                   error:nil];
//        if (!uuid) {
//            uuid = get_random_uuid();
//            
//        }
//        [SFHFKeychainUtils storeUsername:LOCALRANDOMUUID
//                             andPassword:uuid
//                          forServiceName:CSLCService
//                          updateExisting:YES
//                                   error:nil];
//        return uuid;
//    }
//    return uuid;
//}



+(NSString *)dynamicMessageTime:(NSString *)messageTime SystemTime:(NSString *)sysTime
{
    //    NSDateFormatter * dateF= [[NSDateFormatter alloc]init];
    //    dateF.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    NSDate *date = [dateF dateFromString:messageTime];
    //    NSTimeInterval theMessageT = [date timeIntervalSince1970];
    NSTimeInterval theMessageT = [messageTime doubleValue];
    
    
    double cha = (double)[[NSDate date] timeIntervalSince1970]-[messageTime doubleValue];
    
    //    double cha = [sysTime doubleValue]-[messageTime doubleValue];
    double oneY = 24*3600*365;
    double oneD = 24*3600;
    if (cha<=0) {
        return @"刚刚";
    }
    else
    {
        if (cha>=oneY) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *messageDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:theMessageT]];
            return messageDateStr;
        }
        else
        {
            if (cha>=oneD&&cha<oneY) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM-dd"];
                NSString *messageDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:theMessageT]];
                return messageDateStr;
            }
            else if (cha>=3600&&cha<oneD) {
                int hour = cha/3600;
                return [NSString stringWithFormat:@"%d小时前",hour];
            }
            else if (cha>=60&&cha<3600){
                int minute = cha/60;
                return [NSString stringWithFormat:@"%d分钟前",minute];
            }
            else
            {
                return @"刚刚";
            }
        }
    }
    
}




@end
