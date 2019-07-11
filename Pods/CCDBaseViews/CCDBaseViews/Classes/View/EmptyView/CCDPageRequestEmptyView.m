//
//  CCDPageRequestEmptyView.m
//  Pods
//
//  Created by 凤梨 on 2017/8/16.
//
//

#import "CCDPageRequestEmptyView.h"
@import Masonry;
@import CCDCore;
@interface CCDPageRequestEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;
@end

@implementation CCDPageRequestEmptyView

- (instancetype)initWithFrame:(CGRect)frame image:(nullable UIImage *)image title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStyle];
        [self setupSubViews];
        [self setupLayout];
        _imageView.image = image;
        _descLabel.text = title;
    }
    return self;
}

- (void)setupStyle {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setupSubViews {
    [self addSubview:self.imageView];
    [self addSubview:self.descLabel];
}

- (void)setupLayout {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(72);
        make.bottom.equalTo(self.descLabel.mas_top).offset(-10);
        make.top.equalTo(self);
    }];
}

- (void)updateWithImage:(nullable UIImage *)image title:(nullable NSString *)title {
    if (image) {
         self.imageView.image = image;
    }
    if (title.length) {
        self.descLabel.text = title;
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView ccd_createImageViewWithContentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel ccd_createLabelWithFont:Font14Size textColor:[UIColor whiteColor] textAlign:NSTextAlignmentCenter];
    }
    return _descLabel;
}

@end
