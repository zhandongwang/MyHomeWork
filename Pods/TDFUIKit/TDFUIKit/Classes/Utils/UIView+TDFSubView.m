//
// Created by huanghou  on 2017/5/31.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "UIView+TDFSubView.h"


@implementation UIView (TDFSubView)
- (void)tdf_removeAllSubViews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end
