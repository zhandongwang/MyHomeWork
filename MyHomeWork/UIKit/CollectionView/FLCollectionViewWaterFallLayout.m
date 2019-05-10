//
//  FLCollectionViewWaterFallLayout.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCollectionViewWaterFallLayout.h"

/** 默认的列数    */
static const CGFloat DefaultColunmCount = 2;
/** 每一列之间的间距    */
static const CGFloat DefaultColunmMargin = 10;

/** 每一行之间的间距    */
static const CGFloat DefaultRowMargin = 10;

/** 内边距    */
static const UIEdgeInsets DefaultEdgeInsets = {10,10,10,10};


@interface FLCollectionViewWaterFallLayout ()
@property (nonatomic, strong) NSMutableArray *attrsArr;
@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation FLCollectionViewWaterFallLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < DefaultColunmCount; ++i) {
        [self.columnHeights addObject:@(DefaultEdgeInsets.top)];
    }
    [self.attrsArr removeAllObjects];
    
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; ++i) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:path];
        [self.attrsArr addObject:attrs];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionViewW = CGRectGetWidth(self.collectionView.frame);
    CGFloat cellW = (collectionViewW - DefaultEdgeInsets.left - DefaultEdgeInsets.right - (DefaultColunmCount - 1) * DefaultColunmMargin) / DefaultColunmCount;
    CGFloat cellH = [self.delegate waterFallLayout:self heightForItemAtIndexPath:indexPath itemWidth:cellW];
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i = 1; i < DefaultColunmCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat cellX = DefaultEdgeInsets.left + destColumn *(cellW + DefaultColunmMargin);
    CGFloat cellY = minColumnHeight;
    if (cellY != DefaultEdgeInsets.top) {
        cellY += DefaultRowMargin;
    }
    
    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    CGFloat maxHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < maxHeight) {
        self.contentHeight = maxHeight;
    }
    return attrs;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArr;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + DefaultEdgeInsets.bottom);
    
}

#pragma mark - accessors

- (NSMutableArray *)attrsArr{
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    
    return _attrsArr;
}

- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    
    return _columnHeights;
}

@end
