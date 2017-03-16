//
//  GameViewFlowLayout.m
//  CSLCPlay
//
//  Created by liwei on 15/10/9.
//  Copyright © 2015年 liwei. All rights reserved.
//

#import "GameViewFlowLayout.h"

@implementation GameViewFlowLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setSectionInset:UIEdgeInsetsMake(-65.0f, 1.0f, 0.0f, 0.0f)];
        _colNumber = 6;
    }
    return self;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *layoutAttr in attributes) {
        //NSLog(@"%@", NSStringFromCGRect([layoutAttr frame]));
        
        NSInteger section = (NSInteger)ceil((float)(layoutAttr.indexPath.row + 1)/_colNumber) - 1;
        NSInteger space = 0;
        if (layoutAttr.frame.origin.y > layoutAttr.frame.size.height) {
            space =  layoutAttr.frame.origin.y - layoutAttr.frame.size.height * section;
        }else{
            space = 0;
        }
        CGRect frame = layoutAttr.frame;
        frame.origin.y = space/4 + layoutAttr.frame.size.height* section;
        layoutAttr.frame = frame;
    }
    
    
    return attributes;
}

@end
