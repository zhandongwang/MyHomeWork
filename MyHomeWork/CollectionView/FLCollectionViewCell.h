//
//  FLCollectionViewCell.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/29.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLCollectionViewCell : UICollectionViewCell

- (void)updateWithText:(NSString *)text bgColor:(UIColor *)bgColor;

@end

NS_ASSUME_NONNULL_END
