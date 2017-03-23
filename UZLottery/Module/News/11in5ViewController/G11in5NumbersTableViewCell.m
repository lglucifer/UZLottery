//
//  G11in5NumbersTableViewCell.m
//  CSLCPlay
//
//  Created by liwei on 15/10/8.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "G11in5NumbersTableViewCell.h"
#import "GameViewFlowLayout.h"
#import "BallSizeConfig.h"


@implementation G11in5NumbersCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CGSize ballSize = CGSizeMake(self.frame.size.width, self.frame.size.width);
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2.f, ballSize.width, ballSize.height)];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        
        _numberLabel = [[UILabel alloc] initWithFrame:_imageView.bounds];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.adjustsFontSizeToFitWidth = YES;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.font = [UIFont systemFontOfSize:17.f];
        [_imageView addSubview:_numberLabel];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end


static NSString * const kCellReuseIdentifier = @"k11in5CellReuseIdentifier";

@implementation G11in5NumbersTableViewCell

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

    if (titleLabel) {
        [titleLabel removeFromSuperview];
    }
    if (_collectionView) {
        [_collectionView removeFromSuperview];
    }
    
    UIImage *whiteImage = [UIImage imageNamed:kWhiteBallName];
    CGSize ballSize = CGSizeMake(whiteImage.size.width, whiteImage.size.height);
    CGFloat height = 0;
    if (iPhone4 || iPhone5) {
        height = ballSize.height;
    }else if (iPhone6) {
        height = ballSize.height + 5.f;
    }else{
        height = ballSize.height + 10.f;
    }
    
    CGFloat bgHeight = height*2 + 5.f;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, (bgHeight - 24.f)/2, height, 24.f)];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.layer.borderWidth = 1.f;
    titleLabel.layer.cornerRadius = 10.f;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    titleLabel.text = _titleText;
    [self.contentView addSubview:titleLabel];
    
    //---- 显示号码
    CGFloat cx = CGRectGetMaxX(titleLabel.frame);
    CGFloat width = kScreenWidth - cx - 20.f;
    CGFloat flowWidth = width/7;
    GameViewFlowLayout *flowLayout = [[GameViewFlowLayout alloc] init];
    flowLayout.colNumber = 6;
    [flowLayout setItemSize:CGSizeMake(flowWidth, height)];//76.f
    flowLayout.minimumInteritemSpacing = 1.f;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5.f, 0, width, bgHeight)
                                         collectionViewLayout:flowLayout];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setAllowsMultipleSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.scrollEnabled = NO;
    [self.contentView addSubview:_collectionView];
    
    [_collectionView registerClass:[G11in5NumbersCollectionCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
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
    G11in5NumbersCollectionCell *cell = (G11in5NumbersCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    cell.numberLabel.text = _numberArray[indexPath.row];

    if ([_selectArray containsObject:cell.numberLabel.text]) {
//        if ([_titleText isEqualToString:@"拖码"]) {
//            cell.imageView.image = [UIImage imageNamed:kBlueBallName];
//        }else{
            cell.imageView.image = [UIImage imageNamed:kRedBallName];
//        }
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
    
    G11in5NumbersCollectionCell *cell = (G11in5NumbersCollectionCell *)[_collectionView cellForItemAtIndexPath:indexPath];    
    if (![_selectArray containsObject:cell.numberLabel.text]) {
        [_selectArray addObject:cell.numberLabel.text];
//        if ([_titleText isEqualToString:@"拖码"]) {
//            cell.imageView.image = [UIImage imageNamed:kBlueBallName];
//        }else{
            cell.imageView.image = [UIImage imageNamed:kRedBallName];
//        }
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
    G11in5NumbersCollectionCell *cell = (G11in5NumbersCollectionCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    if (![_selectArray containsObject:cell.numberLabel.text]) {
        [_selectArray addObject:cell.numberLabel.text];
//        if ([_titleText isEqualToString:@"拖码"]) {
//            cell.imageView.image = [UIImage imageNamed:kBlueBallName];
//        }else{
            cell.imageView.image = [UIImage imageNamed:kRedBallName];
//        }
    cell.numberLabel.textColor = [UIColor whiteColor];
    }else {
        [_selectArray removeObject:cell.numberLabel.text];
        cell.imageView.image = [UIImage imageNamed:kWhiteBallName];
        cell.numberLabel.textColor = [UIColor blackColor];
    }
    [_delegate numberDidDeSelectAtCollectionViewCell:cell numbers:_selectArray];
}


@end
