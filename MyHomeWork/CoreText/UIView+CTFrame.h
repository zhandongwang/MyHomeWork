//
//  UIView+CTFrame.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CTFrame)
-(CGFloat)x;
-(void)setX:(CGFloat)x;

-(CGFloat)y;
-(void)setY:(CGFloat)y;

-(CGFloat)height;
-(void)setHeight:(CGFloat)height;

-(CGFloat)width;
-(void)setWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
