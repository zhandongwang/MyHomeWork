//
//  DHPopSectionHeaderView.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHPopSectionHeaderView.h"

@implementation DHPopSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpStyle];
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpStyle {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setUpSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomLine];
}

- (void)updateWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - GET_PIXEL(.5))];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(GET_PIXEL(15), CGRectGetMaxY(self.bounds) - GET_PIXEL(.5), CGRectGetWidth(self.bounds) - GET_PIXEL(15), GET_PIXEL(.5))];
        _bottomLine.backgroundColor = [UIColor grayColor];
    }
    return _bottomLine;
}

@end
