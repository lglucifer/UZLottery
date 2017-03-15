//
//  UZSessionManager.h
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface UZSessionManager : AFHTTPSessionManager

- (NSURLSessionDataTask *)requestLotteryNewsWithPageType:(NSInteger)pageType
                                                 Success:(void(^)(NSArray *news, NSURLSessionDataTask *dataTask))success
                                                 failure:(void(^)(NSError *error, NSURLSessionDataTask *dataTask))failure;

@end
