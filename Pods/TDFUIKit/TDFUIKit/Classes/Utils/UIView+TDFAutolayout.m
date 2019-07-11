//
// Created by huanghou  on 2017/5/24.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "UIView+TDFAutolayout.h"


@implementation UIView (TDFAutolayout)
+ (id)tdf_autolayoutView
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}
@end