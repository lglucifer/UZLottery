//
//  BallsCollectionViewCell.m
//  CSLCPlay
//
//  Created by liwei on 15/11/3.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "BallsCollectionViewCell.h"

@implementation BallsCollectionViewCell

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
