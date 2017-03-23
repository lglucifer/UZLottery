//
//  G11in5NumbersTableViewCell.h
//  CSLCPlay
//
//  Created by liwei on 15/10/8.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface G11in5NumbersCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@protocol  G11in5NumbersTableViewCellDelegate <NSObject>

- (void)numberDidSelectAtCollectionViewCell:(G11in5NumbersCollectionCell *)cell numbers:(NSArray *)numbers;
- (void)numberDidDeSelectAtCollectionViewCell:(G11in5NumbersCollectionCell *)cell numbers:(NSArray *)numbers;

@end

@interface G11in5NumbersTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UIView *bgView;
    UILabel *titleLabel;
    UICollectionView *collectionView1;
    UICollectionView *collectionView2;
    UICollectionView *collectionView3;
}

@property (nonatomic, weak) id<G11in5NumbersTableViewCellDelegate> delegate;

/** 是否胆拖 */
@property (nonatomic, assign) BOOL isDanTuo;
/** 标题 */
@property (nonatomic, strong) NSString *titleText;

/** 号码列表 */
@property (nonatomic, strong) NSArray *numberArray;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) UICollectionView *collectionView;

- (void)setupNumbersView;
//- (void)showNumbersTitle:(NSString *)title numbers:(NSArray *)numbers;

@end
