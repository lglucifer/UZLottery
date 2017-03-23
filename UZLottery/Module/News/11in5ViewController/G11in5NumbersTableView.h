//
//  G11in5NumbersTableView.h
//  CSLCPlay
//
//  Created by liwei on 15/10/10.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "G11in5NumbersTableViewCell.h"
#import "GP11in5Description.h"
#import "GameNumbersTableViewDelegate.h"

@interface G11in5NumbersTableView : UIView <UITableViewDataSource, UITableViewDelegate, G11in5NumbersTableViewCellDelegate>
{
    GP11in5Description *gpDesc;

}

@property (nonatomic, weak) id<GameNumbersTableViewDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *gameType;//任选一、任选二
@property (nonatomic, assign) BOOL isDanTuo;
@property (nonatomic, strong) NSMutableArray *numbersArray;
@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, strong) NSMutableArray *tempData1;
@property (nonatomic, strong) NSMutableArray *tempData2;
@property (nonatomic, strong) NSMutableArray *tempData3;


- (void)numbersViewReload;
- (void)setRandomNumbers;

@end
