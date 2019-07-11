//  CCDMessageBannerView.m
//  Pods
//
//  Created by 凤梨 on 17/3/30.
//
//

#import "CCDMessageBannerView.h"
#import "Masonry.h"
#import "CCDBaseViews.h"
#import "UIView+TDFAutolayout.h"
#import "TDFBundleHelper.h"
#import "UIColor+TDFHexColor.h"
#import "TDFFoundationMacro.h"
#import "ALView+PureLayout.h"
@import CCDCore;

typedef NS_ENUM(NSInteger, CCDMessageBannerState) {
    CCDMessageBannerStateHidden,
    CCDMessageBannerStateShowing,
    CCDMessageBannerStateGone
};

@interface CCDMessageBannerView ()

@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *iconTitleLabel;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *actionButton;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UIImageView *backgroundView;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, assign) CCDMessageBannerState state;
@property(nonatomic, strong) NSArray<__kindof NSLayoutConstraint *> *commonConstraints;
@property(nonatomic, strong) NSLayoutConstraint *hiddenConstraint;
@property(nonatomic, strong) NSLayoutConstraint *showingConstraint;
@end

@implementation CCDMessageBannerView {
    NSLayoutConstraint *_showingConstraint;
}

- (id)initWithTitle:(NSString *)title content:(NSString *)content iconTitle:(NSString *)iconTitle actionTitle:(NSString *)actionTitle type:(CCDMessageBannerType)type callback:(void (^)())callback {
    self = [super init];
    if (self) {
        _title = title;
        _content = content;
        _iconTitle = iconTitle;
        _type = type;
        _actionTitle = actionTitle;
        _callback = callback;
        [self setup];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    if (!view) {//todo 暂时不支持navigationbar上显示，等我有空了再来改
        return;
    }

    [view addSubview:self];
    [self update];
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.state = CCDMessageBannerStateShowing;
                     } completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismiss];
                });
            }];
}

- (void)update {
    switch (self.state) {
        case CCDMessageBannerStateHidden:
            self.showingConstraint.active = NO;
            self.hiddenConstraint.active = YES;
            break;
        case CCDMessageBannerStateShowing:
            self.hiddenConstraint.active = NO;
            self.showingConstraint.active = YES;
            break;
        case CCDMessageBannerStateGone:
            self.showingConstraint.active = NO;
            self.hiddenConstraint.active = NO;
            [NSLayoutConstraint deactivateConstraints:self.commonConstraints];
            break;
    }
    [self setNeedsLayout];
    [self setNeedsUpdateConstraints];
    if (SYSTEM_VERSION_GREATER_THAN(@"10.0")) {
        [self.superview layoutIfNeeded];
    } else {
        [self layoutIfNeeded];
    }
    [self updateConstraintsIfNeeded];
}

- (void)dismiss {
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.state = CCDMessageBannerStateHidden;
                     } completion:^(BOOL finished) {
                self.state = CCDMessageBannerStateGone;
                [self removeFromSuperview];
            }];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.state == CCDMessageBannerStateGone) {
        return;
    }
    NSLayoutConstraint *leadingConstraint = [self autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:25];
    NSLayoutConstraint *trailingConstraint = [self autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:25];
    self.commonConstraints = @[leadingConstraint, trailingConstraint];
    self.showingConstraint = [self autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    self.showingConstraint.active = NO;
    self.hiddenConstraint = [self autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.superview withOffset:-7];
    self.hiddenConstraint.active = NO;
};

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIfNeeded];
}


- (void)setup {
    [self setupSubViews];
    [self setupStyle];
    [self setupLayout];
}

- (void)setupSubViews {
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.contentView];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.iconTitleLabel];
    self.iconTitleLabel.text = self.iconTitle;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.text = self.title;
    [self.contentView addSubview:self.actionButton];
    [self.actionButton setTitle:self.actionTitle forState:UIControlStateNormal];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.text = self.content;
}

- (void)setupLayout {
    [self.backgroundView autoPinEdgesToSuperviewEdges];
    [self.backgroundView autoSetDimension:ALDimensionHeight toSize:66];

    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeBottom];

    [self.iconView autoSetDimensionsToSize:CGSizeMake(21, 21)];
    [self.iconView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
    [self.iconView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:10];

    [self.iconTitleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.iconView];
    [self.iconTitleLabel autoSetDimension:ALDimensionWidth toSize:32];
    [self.iconTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.iconView withOffset:9];

    [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.iconView withOffset:15];
    [self.titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.iconView];

    [self.actionButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.titleLabel withOffset:5 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.actionButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.iconView];
    [self.actionButton autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.contentView];
    [self.actionButton setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

    [self.contentLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.titleLabel];
    [self.contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:7];
    [self.contentLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:0 relation:NSLayoutRelationLessThanOrEqual];
}

- (void)setupStyle {
    _state = CCDMessageBannerStateHidden;
    //todo 根据类型设置不同的背景颜色和符号，目前只支持error一种情况
    self.backgroundView.image = [TDFImageFromCurrentBundle(@"message_banner_error_background")
            resizableImageWithCapInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
    self.iconView.image = CCDImageFromCurrentBundle(@"msg_exception");
}


#pragma mark - accessors

- (void)setState:(CCDMessageBannerState)state {
    CCDMessageBannerState oldState = _state;
    _state = state;
    if (_state != oldState) {
        [self update];
    }
}


- (UIImageView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIImageView tdf_autolayoutView];
        _backgroundView.userInteractionEnabled = YES;
    }
    return _backgroundView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView tdf_autolayoutView];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}

- (UILabel *)iconTitleLabel {
    if (!_iconTitleLabel) {
        _iconTitleLabel = [UILabel tdf_autolayoutView];
        _iconTitleLabel.font = [UIFont systemFontOfSize:10];
        _iconTitleLabel.textColor = [UIColor tdf_colorWithHexString:@"999999"];
        _iconTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _iconTitleLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel tdf_autolayoutView];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor tdf_colorWithHexString:@"333333"];
    }
    return _titleLabel;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton tdf_autolayoutView];
        [_actionButton setTitleColor:[UIColor tdf_colorWithHexString:@"006FCE"] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_actionButton addTarget:self action:@selector(actionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}


- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel tdf_autolayoutView];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor tdf_colorWithHexString:@"333333"];
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//        _contentLabel.preferredMaxLayoutWidth = self.ccd_viewWidth - 60;
    }
    return _contentLabel;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView tdf_autolayoutView];
    }
    return _contentView;
}


#pragma mark Action

- (void)actionButtonTapped:(UIButton *)actionButton {
    if (self.callback) {
        self.callback();
    }
}

@end
