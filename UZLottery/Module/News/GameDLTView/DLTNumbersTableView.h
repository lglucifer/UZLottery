//
//  DLTNumbersTableView.h
//  CSLCPlay
//
//  Created by liwei on 15/11/3.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTNumbersTableViewCell.h"
//#import "GP11in5Description.h"
#import "GameNumbersTableViewDelegate.h"

@interface DLTNumbersTableView : UIView <UITableViewDataSource, UITableViewDelegate, DLTNumbersTableViewCellDelegate>
{
    NSArray *frontTitleArray;
    NSArray *backTitleArray;
}

@property (nonatomic, weak) id<GameNumbersTableViewDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isDanTuo;

@property (nonatomic, strong) NSMutableArray *frontNumbersArray;
@property (nonatomic, strong) NSMutableArray *backNumbersArray;

@property (nonatomic, strong) NSMutableArray *frontTempData1;
@property (nonatomic, strong) NSMutableArray *frontTempData2;
@property (nonatomic, strong) NSMutableArray *backTempData1;
@property (nonatomic, strong) NSMutableArray *backTempData2;

- (void)setTitleListArray:(NSArray *)listArray;
- (void)numbersViewReload;
- (void)setRandomNumbers;


@end
