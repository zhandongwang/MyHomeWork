//
//  UIButton+FRWExtend.h
//  CardApp
//
//  Created by CaydenK on 2016/10/15.
//  Copyright © 2016年 2dfire.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FRWExtend)

/**
 更改按钮的触控响应区域

 @param edge e.g. edge为UIEdgeInsetsMake(10, 10, 10, 10)时，按钮响应区域上下左右分别扩大10
 */
- (void)setTouchEdge:(UIEdgeInsets)edge;

@end
