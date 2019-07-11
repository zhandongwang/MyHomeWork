//
// Created by huanghou  on 2017/6/19.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "UITabBar+CCDBadge.h"


@implementation UITabBar (CCDBadge)
- (void)ccd_showBadgeOnItemIndex:(int)index {
    //移除之前的小红点
    [self ccd_removeBadgeOnItemIndex:index];

    //新建小红点
    UIView *badgeView = [[UIView alloc] init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;

    //确定小红点的位置
    float percentX = (index + 0.6f) / self.items.count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1f * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self addSubview:badgeView];
}

//隐藏小红点
- (void)ccd_hideBadgeOnItemIndex:(int)index {
    //移除小红点
    [self ccd_removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)ccd_removeBadgeOnItemIndex:(int)index {
    //按照tag值进行移除
    UIView *badgeView = [self viewWithTag:888 + index];
    if (badgeView) {
        [badgeView removeFromSuperview];
    }
}
@end