//
//  Game11in5ViewController.h
//  CSLCPlay
//
//  Created by liwei on 15/10/8.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Game11in5ViewController : UIViewController
{
    NSString *provId;
}
@property (nonatomic, assign) BOOL isHomePush;
@property (nonatomic, strong) NSString *gameNo;
@property (nonatomic, strong) NSString *gameName;

@property (nonatomic, strong) NSString *updateNumbers;
@property (nonatomic, strong) NSNumber *ticketInfoIdx;
@property (nonatomic, assign) NSInteger ticketBet;

@end
