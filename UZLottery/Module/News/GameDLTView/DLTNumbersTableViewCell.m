//
//  DLTNumbersTableViewCell.m
//  CSLCPlay
//
//  Created by liwei on 15/11/5.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "DLTNumbersTableViewCell.h"
#import "GameViewFlowLayout.h"
#import "BallSizeConfig.h"

static NSString * const kCellReuseIdentifier = @"kdltBackCellReuseIdentifier";

@implementation DLTNumbersTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _isDanTuo = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setupNumbersView
{
    _selectArray = [[NSMutableArray alloc] init];
    
    if (_titleLabel) {
        [_titleLabel removeFromSuperview];
    }
    if (_collectionView) {
        [_collectionView removeFromSuperview];
    }
    
    UIImage *whiteImage = [UIImage imageNamed:kWhiteBallName];
    CGSize ballSize = CGSizeMake(whiteImage.size.width, whiteImage.size.height);
    CGFloat height = 0;
    if (iPhone4 || iPhone5) {
        height = ballSize.height + 2.f;
    }else if (iPhone6) {
        height = ballSize.height + 7.f;
    }else{
        height = ballSize.height + 12.f;
    }
    
    CGFloat bgHeight = height*[_numberArray count] + 5.f;
    
    CGFloat cx = 10.f;
    CGFloat width = kScreenWidth - cx*2 ;
    
    //---游戏说明
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(cx, 0, width, 30.f)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:14.f];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_titleLabel];
    
    //---- 显示号码
    CGFloat flowWidth = width/8;
    GameViewFlowLayout *flowLayout = [[GameViewFlowLayout alloc] init];
    flowLayout.colNumber = 7;
    [flowLayout setItemSize:CGSizeMake(flowWidth, height)];//76.f
    flowLayout.minimumInteritemSpacing = 1.f;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(cx, CGRectGetMaxY(_titleLabel.frame), width, bgHeight)
                                         collectionViewLayout:flowLayout];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setAllowsMultipleSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.scrollEnabled = NO;
    [self.contentView addSubview:_collectionView];
    
    [_collectionView registerClass:[BallsCollectionViewCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_numberArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BallsCollectionViewCell *cell = (BallsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    cell.numberLabel.text = _numberArray[indexPath.row];
    
    if ([_selectArray containsObject:cell.numberLabel.text]) {
        NSRange range = [_titleLabel.text rangeOfString:@"后区"];
        if (range.location != NSNotFound) {
            cell.imageView.image = [UIImage imageNamed:kBlueBallName];
        }else{
            cell.imageView.image = [UIImage imageNamed:kRedBallName];
        }
        cell.numberLabel.textColor = [UIColor whiteColor];
    }else{
        cell.imageView.image = [UIImage imageNamed:kWhiteBallName];
    }
    return cell;
}

#pragma mark - delegate methods
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BallsCollectionViewCell *cell = (BallsCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    
    if (![_selectArray containsObject:cell.numberLabel.text]) {
        [_selectArray addObject:cell.numberLabel.text];
        
        NSRange range = [_titleLabel.text rangeOfString:@"后区"];
        if (range.location != NSNotFound) {
            cell.imageView.image = [UIImage imageNamed:kBlueBallName];
        }else{
            cell.imageView.image = [UIImage imageNamed:kRedBallName];
        }
        cell.numberLabel.textColor = [UIColor whiteColor];
        
        
    }else {
        [_selectArray removeObject:cell.numberLabel.text];
        cell.imageView.image = [UIImage imageNamed:kWhiteBallName];
        cell.numberLabel.textColor = [UIColor blackColor];
    }
    
    [_delegate numberDidSelectAtCollectionViewCell:cell numbers:_selectArray];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BallsCollectionViewCell *cell = (BallsCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    if (![_selectArray containsObject:cell.numberLabel.text]) {
        [_selectArray addObject:cell.numberLabel.text];
        NSRange range = [_titleLabel.text rangeOfString:@"后区"];
        if (range.location != NSNotFound) {
            cell.imageView.image = [UIImage imageNamed:kBlueBallName];
        }else{
            cell.imageView.image = [UIImage imageNamed:kRedBallName];
        }
        cell.numberLabel.textColor = [UIColor whiteColor];
    }else {
        [_selectArray removeObject:cell.numberLabel.text];
        cell.imageView.image = [UIImage imageNamed:kWhiteBallName];
        cell.numberLabel.textColor = [UIColor blackColor];
    }
    [_delegate numberDidDeSelectAtCollectionViewCell:cell numbers:_selectArray];
}



@end
