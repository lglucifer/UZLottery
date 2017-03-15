//
//  UZSessionManager.m
//  UZLottery
//
//  Created by Xiaoyu Liu on 17/3/13.
//  Copyright © 2017年 com.uzero. All rights reserved.
//

#import "UZSessionManager.h"

NSInteger kUZAppDefaultErrorCode    = 9999;
NSInteger kUZAppRequestCancelCode   = -999;

@implementation UZSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 15.f;
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/plain", @"text/json",nil];
    }
    return self;
}

- (BOOL)inner_CheckResponseObjectValid:(id)responseObject {
    BOOL valid = NO;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSString *code = [NSString stringWithFormat:@"%@", responseObject[@"error"]];
        if ([code isEqualToString:@"0"]) {
            valid = YES;
        }
    }
    return valid;
}

- (NSError *)inner_CreateResponseObjectError:(id)responseObject {
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseObjectDict = (NSDictionary *)responseObject;
        NSInteger errorCode = kUZAppDefaultErrorCode;
        if ([responseObjectDict.allKeys containsObject:@"code"]) {
            errorCode = [responseObject[@"code"] integerValue];
        }
        NSString *message = @"";
        if ([responseObjectDict.allKeys containsObject:@"message"]) {
            message = responseObjectDict[@"message"];
        }
        if ((errorCode != kUZAppDefaultErrorCode) &&
            message.length > 0) {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:errorCode
                                             userInfo:@{NSLocalizedDescriptionKey: message}];
            return error;
        }
    }
    return [NSError errorWithDomain:NSCocoaErrorDomain
                               code:kUZAppDefaultErrorCode
                           userInfo:@{NSLocalizedDescriptionKey: @"返回数据出错"}];
}

- (NSURLSessionDataTask *)uz_POST:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error, BOOL needsShowHUD))failure {
    __weak __typeof(self) weakSelf = self;
    return
    [self POST:URLString
    parameters:parameters
      progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           BOOL validResponseObject = [weakSelf inner_CheckResponseObjectValid:responseObject];
           if (validResponseObject) {
               id validResponseValue = responseObject[@"data"];
               success(task, validResponseValue);
           } else {
               NSError *invalidResponseObjectError = [weakSelf inner_CreateResponseObjectError:responseObject];
               if (invalidResponseObjectError.code != kUZAppRequestCancelCode) {
                   failure(task, invalidResponseObjectError, YES);
               } else {
                   //                   failure(task, invalidResponseObjectError, NO);
               }
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           if (error.code != kUZAppRequestCancelCode) {
               failure(task, error, YES);
           } else {
               //               failure(task, error, NO);
           }
       }];
}

- (NSURLSessionDataTask *)requestLotteryInfoSuccess:(void(^)(UZLotteryAppLaunch *appLaunch, NSURLSessionDataTask *dataTask))success
                                            failure:(void(^)(NSError *error, NSURLSessionDataTask *dataTask))failure {
    return
    [self uz_POST:@"http://ningweb.com/lottery/api/index.php/nightkiss/getAppDetail/?id=1445"
       parameters:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
              UZLotteryAppLaunch *appLaunch = [[UZLotteryAppLaunch alloc] initWithDictionary:responseObject
                                                                                       error:nil];
              success(appLaunch, task);
          } failure:^(NSURLSessionDataTask *task, NSError *error, BOOL needsShowHUD) {
              failure(error, task);
          }];
}

- (NSURLSessionDataTask *)requestLotteryNewsWithPageType:(NSInteger)pageType
                                                 Success:(void(^)(NSArray *news, NSURLSessionDataTask *dataTask))success
                                                 failure:(void(^)(NSError *error, NSURLSessionDataTask *dataTask))failure {
    NSString *URLPath = @"";
    if (pageType == 0) {
        URLPath = @"http://ningweb.com/lottery/api/index.php/nightkiss/getAllNews?page=0";
    } else if (pageType == 1) {
        URLPath = @"http://ningweb.com/lottery/api/index.php/nightkiss/getAllNews?page=1";
    }
    return
    [self uz_POST:URLPath
       parameters:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSArray *items = [UZLotteryNews arrayOfModelsFromDictionaries:responseObject
                                                                      error:nil];
              success(items, task);
          } failure:^(NSURLSessionDataTask *task, NSError *error, BOOL needsShowHUD) {
              failure(error, task);
          }];
}

@end
