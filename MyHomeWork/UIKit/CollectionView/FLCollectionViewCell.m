//
//  FLCollectionViewCell.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/29.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCollectionViewCell.h"
#import <Masonry.h>

@interface FLCollectionViewCell()

@property (nonatomic, strong) UILabel *descLabel;

@end


@implementation FLCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
}

- (void)updateWithText:(NSString *)text bgColor:(UIColor *)bgColor {
    self.descLabel.text = text;
    self.contentView.backgroundColor = bgColor;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.font = [UIFont systemFontOfSize:15];
    }
    return _descLabel;
}
@end
