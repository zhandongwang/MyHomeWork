//
//  FLCollectionViewWaterFallLayout.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FLCollectionViewWaterFallLayout;

@protocol FLCollectionViewWaterFallLayoutDelegate <NSObject>

- (CGFloat)waterFallLayout:(FLCollectionViewWaterFallLayout *)waterLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
                 itemWidth:(CGFloat)itemWidth;


@end




@interface FLCollectionViewWaterFallLayout : UICollectionViewLayout

@property (nonatomic, weak) id<FLCollectionViewWaterFallLayoutDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
