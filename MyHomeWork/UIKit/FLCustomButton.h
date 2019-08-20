//
//  FLCustomButton.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/1.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLCustomView;
NS_ASSUME_NONNULL_BEGIN

@interface FLCustomButton : UIButton

@property (nonatomic, strong) FLCustomView *childView;

@end

NS_ASSUME_NONNULL_END
