//
//  G11in5NumbersTableView.m
//  CSLCPlay
//
//  Created by liwei on 15/10/10.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "G11in5NumbersTableView.h"
#import "GameBetContent.h"
#import "RandomBetNubmer.h"

@implementation G11in5NumbersTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _tempData1 = [[NSMutableArray alloc] init];
        _tempData2 = [[NSMutableArray alloc] init];
        _tempData3 = [[NSMutableArray alloc] init];
        
        gpDesc = [[GP11in5Description alloc] init];
        
        _isDanTuo = NO;
        
        _numbersArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 12; i++) {
            if (i<10) {
                [_numbersArray addObject:[NSString stringWithFormat:@"0%d", i]];
            }else{
                [_numbersArray addObject:[NSString stringWithFormat:@"%d", i]];
            }
        }
        _listArray = @[@"选号"];
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
    //[_delegate getBetContentNumber:@"" gameType:_gameType subType:0 bet:0];
    [_delegate get11in5BetContentArray1:nil arr2:nil arr3:nil];
    [_tableView reloadData];
}

/**
 移除号码
 */
- (void)removeAllTempObjects
{
    if ([_tempData1 count] > 0) {
        [_tempData1 removeAllObjects];
    }
    if ([_tempData2 count] > 0) {
        [_tempData2 removeAllObjects];
    }
    if ([_tempData3 count] > 0) {
        [_tempData3 removeAllObjects];
    }
}

#pragma mark - 机选一注号码球

/**
 机选号码
 */
- (void)setRandomNumbers
{
    if ([_tempData1 count] > 0) {
        [_tempData1 removeAllObjects];
    }
    if ([_tempData2 count] > 0) {
        [_tempData2 removeAllObjects];
    }
    if ([_tempData3 count] > 0) {
        [_tempData3 removeAllObjects];
    }
    
    if ([_listArray count] == 1) {
        NSInteger count = [[[gpDesc puTongVerifyData] objectForKey:_gameType] integerValue];
        
        [_tempData1 addObjectsFromArray:[RandomBetNubmer random11in5NumberCount:count betType:GameBetType11in5Putong]];
        
    }
    if ([_listArray count] == 2) {
        if (![_gameType isEqualToString:gpDesc.q2ZhiXuanName]) {
            NSInteger count = [[[gpDesc puTongVerifyData] objectForKey:_gameType] integerValue];
            NSArray *arr = [RandomBetNubmer random11in5NumberCount:count betType:GameBetType11in5Dantuo];
            [_tempData1 addObjectsFromArray:arr[0]];
            [_tempData2 addObjectsFromArray:arr[1]];
            
        }else{
            //生成2个随机数，分别代码第一个、第二个。
            NSArray *randomArray = [RandomBetNubmer random11in5NumberCount:2 betType:GameBetType11in5Putong];
            if ([randomArray count] == 2) {
                [_tempData1 addObject:randomArray[0]];
                [_tempData2 addObject:randomArray[1]];
            }
      
        }
    }
    if ([_listArray count] == 3) {

        //生成3个随机数，分别代码第一个、第二个、第三个。
        NSArray *randomArray = [RandomBetNubmer random11in5NumberCount:3 betType:GameBetType11in5Putong];
        if ([randomArray count] == 3) {
            [_tempData1 addObject:randomArray[0]];
            [_tempData2 addObject:randomArray[1]];
            [_tempData3 addObject:randomArray[2]];
        }
    }
    
    [_delegate get11in5BetContentArray1:_tempData1 arr2:_tempData2 arr3:_tempData3];

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
- (void)addNumbers:(NSArray *)numbers forRow:(NSInteger)row selectNumber:(NSString *)selectNumber
{    
    if ([_listArray count] == 1) {
        if ([_tempData1 count] > 0) {
            [_tempData1 removeAllObjects];
        }
        
        [_tempData1 addObjectsFromArray:numbers];
        if ([_gameType isEqualToString:gpDesc.ren8Name]) {
            if ([_tempData1 count] > 8) {
                [_tempData1 removeObjectAtIndex:7];
            }
            [_tableView reloadData];
        }
        
        [_tempData1 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 localizedStandardCompare:obj2];
        }];
    }
    if ([_listArray count] == 2) {
        if (row == 0) {
            if ([_tempData1 count] > 0) {
                [_tempData1 removeAllObjects];
            }
            [_tempData1 addObjectsFromArray:numbers];
            if (![_gameType isEqualToString:gpDesc.q2ZhiXuanName]) {
                NSInteger count_ = [[[gpDesc puTongVerifyData] objectForKey:_gameType] integerValue];
                NSInteger danMaxCount = count_ - 1;
                if ([_tempData1 count] > danMaxCount) {
                    [_tempData1 removeObjectAtIndex:0];
                }
            }
            [_tempData1 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 localizedStandardCompare:obj2];
            }];
            
            if ([_tempData2 containsObject:selectNumber]) {
                [_tempData2 removeObject:selectNumber];
            }
        }
        if (row == 1) {
            if ([_tempData2 count] > 0) {
                [_tempData2 removeAllObjects];
            }
            [_tempData2 addObjectsFromArray:numbers];
            [_tempData2 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 localizedStandardCompare:obj2];
            }];
            
            if ([_tempData1 containsObject:selectNumber]) {
                [_tempData1 removeObject:selectNumber];
            }
        }
        [_tableView reloadData];
    }
    if ([_listArray count] == 3) {
        if (row == 0) {
            if ([_tempData1 count] > 0) {
                [_tempData1 removeAllObjects];
            }
            [_tempData1 addObjectsFromArray:numbers];
            [_tempData1 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 localizedStandardCompare:obj2];
            }];
            if ([_tempData2 containsObject:selectNumber]) {
                [_tempData2 removeObject:selectNumber];
            }
            if ([_tempData3 containsObject:selectNumber]) {
                [_tempData3 removeObject:selectNumber];
            }
        }
        if (row == 1) {
            if ([_tempData2 count] > 0) {
                [_tempData2 removeAllObjects];
            }
            [_tempData2 addObjectsFromArray:numbers];
            [_tempData2 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 localizedStandardCompare:obj2];
            }];
            
            if ([_tempData1 containsObject:selectNumber]) {
                [_tempData1 removeObject:selectNumber];
            }
            if ([_tempData3 containsObject:selectNumber]) {
                [_tempData3 removeObject:selectNumber];
            }
        }
        if (row == 2) {
            if ([_tempData3 count] > 0) {
                [_tempData3 removeAllObjects];
            }
            [_tempData3 addObjectsFromArray:numbers];
            [_tempData3 sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 localizedStandardCompare:obj2];
            }];
            
            if ([_tempData1 containsObject:selectNumber]) {
                [_tempData1 removeObject:selectNumber];
            }
            if ([_tempData2 containsObject:selectNumber]) {
                [_tempData2 removeObject:selectNumber];
            }
        }
        [_tableView reloadData];
    }
    [_delegate get11in5BetContentArray1:_tempData1 arr2:_tempData2 arr3:_tempData3];
}
#pragma mark - G11in5NumbersTableViewCellDelegate
- (void)numberDidSelectAtCollectionViewCell:(G11in5NumbersCollectionCell *)cell numbers:(NSArray *)numbers
{
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(G11in5NumbersTableViewCell *)[[[cell superview] superview] superview]];
    }else{
        indexPath = [_tableView indexPathForCell:(G11in5NumbersTableViewCell *)[[[[cell superview] superview] superview] superview]];
    }
    [self addNumbers:numbers forRow:indexPath.row selectNumber:cell.numberLabel.text];
}

- (void)numberDidDeSelectAtCollectionViewCell:(G11in5NumbersCollectionCell *)cell numbers:(NSArray *)numbers
{
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(G11in5NumbersTableViewCell *)[[[cell superview] superview] superview]];
    }else{
        indexPath = [_tableView indexPathForCell:(G11in5NumbersTableViewCell *)[[[[cell superview] superview] superview] superview]];
    }
    [self addNumbers:numbers forRow:indexPath.row selectNumber:cell.numberLabel.text];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier1 = @"MyLotteryCell1";
    
    G11in5NumbersTableViewCell *ncell = (G11in5NumbersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (ncell == nil) {
        ncell = [[G11in5NumbersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
    }
    ncell.delegate = self;
    
    ncell.isDanTuo = _isDanTuo;
    ncell.titleText = _listArray[indexPath.row];
    ncell.numberArray = [NSArray arrayWithArray:_numbersArray];
    
    [ncell setupNumbersView];
    
    if ([_listArray count] == 1) {
        [ncell.selectArray addObjectsFromArray:_tempData1];
    }
    if ([_listArray count] == 2) {
        if (indexPath.row == 0) {
            [ncell.selectArray addObjectsFromArray:_tempData1];
        }
        if (indexPath.row == 1) {
            [ncell.selectArray addObjectsFromArray:_tempData2];
        }
    }
    if ([_listArray count] == 3) {
        if (indexPath.row == 0) {
            [ncell.selectArray addObjectsFromArray:_tempData1];
        }
        if (indexPath.row == 1) {
            [ncell.selectArray addObjectsFromArray:_tempData2];
        }
        if (indexPath.row == 2) {
            [ncell.selectArray addObjectsFromArray:_tempData3];
        }
    }
    

    
    ncell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return ncell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 110.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
