//
//  CCDPageRequestErrorView.m
//  Pods
//
//  Created by 凤梨 on 17/3/10.
//
//

#import "CCDPageRequestErrorView.h"
#import "Masonry.h"
@import CCDCore;
@interface CCDPageRequestErrorView ()

@property (nonatomic, strong, readwrite) UIButton *actionButton;
@property (nonatomic, strong, readwrite) UILabel *tipLabel;
@property (nonatomic, strong, readwrite) UIImageView *iconImageView;

@end

@implementation CCDPageRequestErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStyle];
        [self setupSubViews];
        [self setupLayout];
    }
    return self;
}

- (void)setupStyle {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setupSubViews {
    [self addSubview:self.actionButton];
    [self addSubview:self.tipLabel];
    [self addSubview:self.iconImageView];
}

- (void)setupLayout {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.actionButton.mas_top).offset(-52 * SCREEN_HEIGHT_SCALE);
        make.left.lessThanOrEqualTo(self.mas_left).offset(30);
        
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.tipLabel.mas_top).offset(-26 * SCREEN_HEIGHT_SCALE);
        make.top.equalTo(self);
    }];
}

- (void)actionButtonTapped:(UIButton *)sender {
    if (self.actionButtonTappedBlock) {
        self.actionButtonTappedBlock();
    }
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.backgroundColor = [UIColor clearColor];
        _actionButton.titleLabel.textColor = [UIColor whiteColor];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _actionButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _actionButton.layer.borderWidth = 1;
        _actionButton.layer.cornerRadius = 6;
        [_actionButton setTitle:CCDLocalizedString(@"retry",@"重试") forState:UIControlStateNormal];
        [_actionButton addTarget:self action:@selector(actionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:15] ;
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = CCDLocalizedString(@"serverError",@"");
    }
    return _tipLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView ccd_createImageViewWithContentMode:UIViewContentModeScaleAspectFit];
    }
    return _iconImageView;
}

@end
