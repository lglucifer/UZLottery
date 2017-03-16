//
//  DLTNumbersTableView.m
//  CSLCPlay
//
//  Created by liwei on 15/11/3.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "DLTNumbersTableView.h"
#import "GameBetContent.h"
#import "CombineArithmetic.h"
#import "RandomBetNubmer.h"

@implementation DLTNumbersTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _frontTempData1 = [[NSMutableArray alloc] init];
        _frontTempData2 = [[NSMutableArray alloc] init];
        _backTempData1 = [[NSMutableArray alloc] init];
        _backTempData2 = [[NSMutableArray alloc] init];
                
        _isDanTuo = NO;
        
        _frontNumbersArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 36; i++) {
            if (i<10) {
               [_frontNumbersArray addObject:[NSString stringWithFormat:@"0%d", i]];
            }else{
                [_frontNumbersArray addObject:[NSString stringWithFormat:@"%d", i]];
            }
        }
        
        _backNumbersArray = [[NSMutableArray alloc] init];
        for (int i = 1; i<=12; i++) {
            if (i<10) {
                [_backNumbersArray addObject:[NSString stringWithFormat:@"0%d", i]];
            }else{
                [_backNumbersArray addObject:[NSString stringWithFormat:@"%d", i]];
            }
        }
        
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return self;
}

/**
 重载页面
 */
- (void)numbersViewReload
{
    [self removeAllTempObjects];
    [_delegate getDLTBetContentFrontArray1:nil frontArray2:nil backArray1:nil backArray2:nil];
    [_tableView reloadData];
}

/**
 移除号码
 */
- (void)removeAllTempObjects
{
    if ([_frontTempData1 count] > 0) {
        [_frontTempData1 removeAllObjects];
    }
    if ([_frontTempData2 count] > 0) {
        [_frontTempData2 removeAllObjects];
    }
    if ([_backTempData1 count] > 0) {
        [_backTempData1 removeAllObjects];
    }
    if ([_backTempData2 count] > 0) {
        [_backTempData2 removeAllObjects];
    }
}

/**
 大乐透玩法说明，包括前区（胆拖）、后区（胆拖）
 */
- (void)setTitleListArray:(NSArray *)listArray
{
    if ([listArray count] == 2) {
        frontTitleArray = @[listArray[0]];
        backTitleArray = @[listArray[1]];
    }
    if ([listArray count] == 4) {
        frontTitleArray = @[listArray[0], listArray[1]];
        backTitleArray = @[listArray[2], listArray[3]];
    }
    [self.tableView reloadData];
}


#pragma mark - 机选一注号码球

/**
 机选号码
 */
- (void)setRandomNumbers
{
    [self removeAllTempObjects];
    //普通
    if ([frontTitleArray count] == 1 && [backTitleArray count] == 1) {
        NSArray *frontArr = [RandomBetNubmer randomDLTNumberCount:5 total:35 betType:GameBetTypeDLTPutong];
        NSArray *backArr = [RandomBetNubmer randomDLTNumberCount:2 total:12 betType:GameBetTypeDLTPutong];
        
        [_frontTempData1 addObjectsFromArray:frontArr];
        [_backTempData1 addObjectsFromArray:backArr];
    }
    //胆拖
    if ([frontTitleArray count] == 2 && [backTitleArray count] == 2) {
        NSArray *frontDanTuoArr = [RandomBetNubmer randomDLTNumberCount:5 total:35 betType:GameBetTypeDLTDantuo];
        NSArray *backDanTuoArr = [RandomBetNubmer randomDLTNumberCount:2 total:12 betType:GameBetTypeDLTDantuo];
        NSArray *frontDanArr = frontDanTuoArr[0];
        NSArray *frontTuoArr = frontDanTuoArr[1];
        NSArray *backDanArr = backDanTuoArr[0];
        NSArray *backTuoArr = backDanTuoArr[1];
        
        [_frontTempData1 addObjectsFromArray:frontDanArr];
        [_frontTempData2 addObjectsFromArray:frontTuoArr];
        [_backTempData1 addObjectsFromArray:backDanArr];
        [_backTempData2 addObjectsFromArray:backTuoArr];
    }
   
    [_delegate getDLTBetContentFrontArray1:_frontTempData1 frontArray2:_frontTempData2 backArray1:_backTempData1 backArray2:_backTempData2];

    [_tableView reloadData];
}

#pragma mark - 显示号码
/**
 *  显示号码
 *
 *  @param  numbers       已选择的号码
 *  @param  row           行数
 *  @param  selectNumber  当前选中的号码
 */
- (void)addNumbers:(NSArray *)numbers atIndexPath:(NSIndexPath *)indexPath selectNumber:(NSString *)selectNumber
{
    //普通
    if ([frontTitleArray count] == 1 && [backTitleArray count] == 1) {
        if (indexPath.section == 0) {
            if ([_frontTempData1 count] > 0) {
                [_frontTempData1 removeAllObjects];
            }
            [_frontTempData1 addObjectsFromArray:numbers];
            [_frontTempData1 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 localizedStandardCompare:obj2];
            }];
        }
        if (indexPath.section == 1) {
            if ([_backTempData1 count] > 0) {
                [_backTempData1 removeAllObjects];
            }
            [_backTempData1 addObjectsFromArray:numbers];
            [_backTempData1 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 localizedStandardCompare:obj2];
            }];
        }
    }
    //胆拖
    if ([frontTitleArray count] == 2 && [backTitleArray count] == 2) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                if ([_frontTempData1 count] > 0) {
                    [_frontTempData1 removeAllObjects];
                }
                [_frontTempData1 addObjectsFromArray:numbers];
                if ([_frontTempData1 count] > 4) {
                    [_frontTempData1 removeObjectAtIndex:3];
                }
                [_frontTempData1 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    return [obj1 localizedStandardCompare:obj2];
                }];
                if ([_frontTempData2 containsObject:selectNumber]) {
                    [_frontTempData2 removeObject:selectNumber];
                }
            }
            if (indexPath.row == 1) {
                if ([_frontTempData2 count] > 0) {
                    [_frontTempData2 removeAllObjects];
                }
                [_frontTempData2 addObjectsFromArray:numbers];
                [_frontTempData2 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    return [obj1 localizedStandardCompare:obj2];
                }];
                if ([_frontTempData1 containsObject:selectNumber]) {
                    [_frontTempData1 removeObject:selectNumber];
                }
            }
            
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                if ([_backTempData1 count] > 0) {
                    [_backTempData1 removeAllObjects];
                }
                [_backTempData1 addObjectsFromArray:numbers];
                if ([_backTempData1 count] > 1) {
                    [_backTempData1 removeObjectAtIndex:0];
                }
                [_backTempData1 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    return [obj1 localizedStandardCompare:obj2];
                }];
                if ([_backTempData2 containsObject:selectNumber]) {
                    [_backTempData2 removeObject:selectNumber];
                }
            }
            if (indexPath.row == 1) {
                if ([_backTempData2 count] > 0) {
                    [_backTempData2 removeAllObjects];
                }
                [_backTempData2 addObjectsFromArray:numbers];
                [_backTempData2 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    return [obj1 localizedStandardCompare:obj2];
                }];
                if ([_backTempData1 containsObject:selectNumber]) {
                    [_backTempData1 removeObject:selectNumber];
                }
            }
        }
    }
    [_delegate getDLTBetContentFrontArray1:_frontTempData1 frontArray2:_frontTempData2 backArray1:_backTempData1 backArray2:_backTempData2];
    
    [_tableView reloadData];
}
#pragma mark - DLTNumbersTableViewCellDelegate
- (void)numberDidSelectAtCollectionViewCell:(BallsCollectionViewCell *)cell numbers:(NSArray *)numbers
{
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(DLTNumbersTableViewCell *)[[[cell superview] superview] superview]];
    }else{
        indexPath = [_tableView indexPathForCell:(DLTNumbersTableViewCell *)[[[[cell superview] superview] superview] superview]];
    }
    [self addNumbers:numbers atIndexPath:indexPath selectNumber:cell.numberLabel.text];
}

- (void)numberDidDeSelectAtCollectionViewCell:(BallsCollectionViewCell *)cell numbers:(NSArray *)numbers
{
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(DLTNumbersTableViewCell *)[[[cell superview] superview] superview]];
    }else{
        indexPath = [_tableView indexPathForCell:(DLTNumbersTableViewCell *)[[[[cell superview] superview] superview] superview]];
    }
    [self addNumbers:numbers atIndexPath:indexPath selectNumber:cell.numberLabel.text];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if ([frontTitleArray count] == 1 && [backTitleArray count] == 1) {
        count = 1;
    }
    if ([frontTitleArray count] == 2 && [backTitleArray count] == 2) {
        count = 2;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier1 = @"dltLotteryCell1";
    static NSString *cellIdentifier2 = @"dltLotteryCell2";
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        DLTNumbersTableViewCell *frontCell = (DLTNumbersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (frontCell == nil) {
            frontCell = [[DLTNumbersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        }
        
        frontCell.delegate = self;
        
        frontCell.isDanTuo = _isDanTuo;
        frontCell.numberArray = [NSArray arrayWithArray:_frontNumbersArray];
        [frontCell setupNumbersView];
        frontCell.titleLabel.textColor = [UIColor grayColor];

        if ([frontTitleArray count] == 1) {
            frontCell.titleLabel.text = [frontTitleArray componentsJoinedByString:@""];
            [frontCell.selectArray addObjectsFromArray:_frontTempData1];
        }
        if ([frontTitleArray count] == 2) {
            if (indexPath.row == 0) {
                frontCell.titleLabel.text = frontTitleArray[0];
                [frontCell.selectArray addObjectsFromArray:_frontTempData1];
            }
            if (indexPath.row == 1) {
                frontCell.titleLabel.text = frontTitleArray[1];
                [frontCell.selectArray addObjectsFromArray:_frontTempData2];
            }
        }
        
        frontCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell = frontCell;
    }
    if (indexPath.section == 1) {
        DLTNumbersTableViewCell *backCell = (DLTNumbersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (backCell == nil) {
            backCell = [[DLTNumbersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
        }
        backCell.delegate = self;
        
        backCell.isDanTuo = _isDanTuo;
        backCell.numberArray = [NSArray arrayWithArray:_backNumbersArray];
        [backCell setupNumbersView];
        backCell.titleLabel.textColor = [UIColor grayColor];

        if ([backTitleArray count] == 1) {
            backCell.titleLabel.text = backTitleArray[0];
            [backCell.selectArray addObjectsFromArray:_backTempData1];
        }
        if ([backTitleArray count] == 2) {
            if (indexPath.row == 0) {
                backCell.titleLabel.text = backTitleArray[0];
                [backCell.selectArray addObjectsFromArray:_backTempData1];
            }
            if (indexPath.row == 1) {
                backCell.titleLabel.text = backTitleArray[1];
                [backCell.selectArray addObjectsFromArray:_backTempData2];
            }
        }
        backCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell = backCell;
    }
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == 0) {
        height = 0;
    }
    if (section == 1) {
        if (iPhone5 || iPhone4) {
            height = 4.f;
        }else{
            height = 10.f;
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        if (iPhone5 || iPhone4) {
            height = 256.f;
        }else{
            height = 306.f;
        }
    }else{
        if (iPhone5 || iPhone4) {
            height = 122.f;
        }else{
            height = 140.f;
        }
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (iPhone5 || iPhone4) {
        height = 4.f;
    }else{
        height = 10.f;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    view.backgroundColor = [UIColor clearColor];
    if (section == 1) {
        return view;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
