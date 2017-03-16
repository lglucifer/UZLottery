//
//  CSLCNavigationController.h
//  ShopManager-iOS
//
//  Created by 李伟 on 14-8-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLCNavigationController : UINavigationController
{
    UIImageView *imgView;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController;

@end
