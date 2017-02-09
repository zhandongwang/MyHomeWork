//
//  DHPopTableView.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/9.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHPopTableView : UIView

@property (nonatomic, assign) CGFloat bgAlpha;

- (instancetype)initWithTableViewFrame:(CGRect)frame;
- (void)show;

@end
