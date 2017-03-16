//
//  CSLCNavigationController.m
//  ShopManager-iOS
//
//  Created by 李伟 on 14-8-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CSLCNavigationController.h"

@implementation CSLCNavigationController


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
	if (self) {
        UIColor *barColor = [UIColor colorRGBWithRed:193.f green:43.f blue:53.f alpha:1.f];
        if (VersionNumber_iOS_7) {
            self.navigationBar.barTintColor = barColor;
        }else{
            self.navigationBar.tintColor = barColor;
        }
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:20.f]};
        
	}
	return self;
}



@end
