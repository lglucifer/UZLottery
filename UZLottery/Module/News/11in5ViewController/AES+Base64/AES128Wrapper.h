//
//  AES128Wrapper.h
//  CSLCShop
//
//  Created by liwei on 15/6/4.
//  Copyright (c) 2015年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128Wrapper : NSObject

+(NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key;
+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key;

@end
