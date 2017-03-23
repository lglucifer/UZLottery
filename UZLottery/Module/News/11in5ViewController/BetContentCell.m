//
//  BetContentCell.m
//  CSLCPlay
//
//  Created by liwei on 15/10/13.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "BetContentCell.h"

@implementation BetContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _delButton.frame = CGRectMake(25.f, (self.contentView.frame.size.height - 40.f)/2, 40.f, 40.f);
        _delButton.backgroundColor = [UIColor clearColor];
        [_delButton setImage:[UIImage imageNamed:@"bet_del"] forState:UIControlStateNormal];
        [_delButton addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_delButton];
        
        _numbersLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_delButton.frame)+10.f, 0, kScreenWidth - CGRectGetMaxX(_delButton.frame) - 30.f, self.contentView.frame.size.height/2)];
        _numbersLabel.backgroundColor = [UIColor clearColor];
        _numbersLabel.font = [UIFont systemFontOfSize:18.f];
        _numbersLabel.numberOfLines = 0;
        _numbersLabel.textColor = kDisplayRedBallColor;
        [self.contentView addSubview:_numbersLabel];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(_numbersLabel.frame.origin.x, CGRectGetMaxY(_numbersLabel.frame), _numbersLabel.frame.size.width, self.contentView.frame.size.height/2)];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.textColor = [UIColor darkGrayColor];
        _descLabel.font = [UIFont systemFontOfSize:14.f];
        _descLabel.numberOfLines = 0;
        [self.contentView addSubview:_descLabel];
        
        lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bet_cell_line"]];
        lineImageView.frame = CGRectMake(40.f, CGRectGetMaxY(_descLabel.frame), kScreenWidth-80.f, 1.f);
        [self.contentView addSubview:lineImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)delButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [_delegate delCellButton:button];
}

- (CGFloat)cellHeight
{
    [self layoutSubviews];
    
    CGFloat height = 0;
    height = self.contentView.frame.size.height + 5.f;
    
    return height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *string = _numbersLabel.text;
    NSMutableAttributedString *mutableAttrStr = [[NSMutableAttributedString alloc] initWithString:string];

    NSRange range2 = [string rangeOfString:kBetNumbersDisplaySeparator];
    if (range2.location != NSNotFound) {
        NSArray *tempArr=  [string componentsSeparatedByString:kBetNumbersDisplaySeparator];
        NSString *red = tempArr[0];
        NSString *blue = tempArr[1];
        [mutableAttrStr setAttributes:@{NSForegroundColorAttributeName: kDisplayRedBallColor} range:NSMakeRange(0, [red length])];
        [mutableAttrStr setAttributes:@{NSForegroundColorAttributeName: kDisplayBlueBallColor} range:NSMakeRange(range2.location+range2.length, [blue length])];
        _numbersLabel.attributedText = mutableAttrStr;
    }
    
    CGRect boundRect = [string boundingRectWithSize:CGSizeMake(_numbersLabel.frame.size.width, 100.f)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
                                            context:nil];
        
    CGRect numbersFrame = _numbersLabel.frame;
    if (boundRect.size.height > 30.f) {
        numbersFrame.size.height = boundRect.size.height;
    }else{
        numbersFrame.size.height = 30.f;
    }
    _numbersLabel.frame = numbersFrame;
    
    CGRect detailFrame = _descLabel.frame;
    detailFrame.origin.y = CGRectGetMaxY(numbersFrame) + 1.f;
    _descLabel.frame = detailFrame;
    
    CGRect ivRect = lineImageView.frame;
    ivRect.origin.y = CGRectGetMaxY(detailFrame) + 5.f;
    lineImageView.frame = ivRect;
    
    CGRect contentViewRect = self.contentView.frame;
    contentViewRect.size.height = _numbersLabel.frame.size.height + _descLabel.frame.size.height + 10.f;
    self.contentView.frame = contentViewRect;
    
    CGRect delRect = _delButton.frame;
    delRect.origin.y = (contentViewRect.size.height - 40.f)/2;
    _delButton.frame = delRect;
}


@end
