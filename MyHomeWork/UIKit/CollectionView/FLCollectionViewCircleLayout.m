//
//  FLCollectionViewCircleLayout.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCollectionViewCircleLayout.h"

static NSInteger const ItemSize = 50;

@interface FLCollectionViewCircleLayout ()

@property (nonatomic, strong) NSMutableArray *attrsArr;
@property (nonatomic, assign) NSInteger itemCount;

@end


@implementation FLCollectionViewCircleLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attrsArr removeAllObjects];
    
    //大圆半径
    CGFloat radius = MIN(CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame)) * 0.5;
    //大圆center
    CGPoint center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    for (int i = 0; i < self.itemCount; ++i) {
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attrs.size =  CGSizeMake(ItemSize, ItemSize);
        float x = center.x + cosf(2 * M_PI/_itemCount * i) * (radius - 50);
        float y = center.y + sinf(2 * M_PI/_itemCount * i) * (radius - 50);
        attrs.center = CGPointMake(x, y);
        [self.attrsArr addObject:attrs];
    }
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArr;
}

- (NSMutableArray *)attrsArr{
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    
    return _attrsArr;
}


@end
