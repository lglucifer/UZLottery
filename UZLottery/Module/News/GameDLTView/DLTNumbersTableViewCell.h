//
//  DLTNumbersTableViewCell.h
//  CSLCPlay
//
//  Created by liwei on 15/11/5.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallsCollectionViewCell.h"

@protocol  DLTNumbersTableViewCellDelegate <NSObject>

- (void)numberDidSelectAtCollectionViewCell:(BallsCollectionViewCell *)cell numbers:(NSArray *)numbers;
- (void)numberDidDeSelectAtCollectionViewCell:(BallsCollectionViewCell *)cell numbers:(NSArray *)numbers;

@end

@interface DLTNumbersTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UIView *bgView;
    UICollectionView *collectionView1;
    UICollectionView *collectionView2;
    UICollectionView *collectionView3;
}

@property (nonatomic, weak) id<DLTNumbersTableViewCellDelegate> delegate;

/** 是否胆拖 */
@property (nonatomic, assign) BOOL isDanTuo;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

/** 号码列表 */
@property (nonatomic, strong) NSArray *numberArray;
@property (nonatomic, strong) NSMutableArray *selectArray;

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)setupNumbersView;

@end

