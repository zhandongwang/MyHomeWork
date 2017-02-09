//
//  DHPopTableView.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/9.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHPopTableView.h"


@interface DHPopTableView ()

@property (nonatomic, strong) UIView *maskBgView;
@property (nonatomic, strong) UIButton *edgeButton;
@property (nonatomic, strong) UIView *contentTableView;
@property (nonatomic, assign) CGRect tableViewFrame;

@end

@implementation DHPopTableView

- (instancetype)initWithTableViewFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        _tableViewFrame = frame;
        _bgAlpha = 0.7;
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.maskBgView];
    [self addSubview:self.contentTableView];
    if (self.edgeButtonImage) {
        [self addSubview:self.edgeButton];
        [self.edgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentTableView.mas_left).offset(GET_PIXEL(0.3));
            make.centerY.equalTo(self.mas_centerY);
        }];

    }
}

- (void)dealloc {
}

#pragma mark - event handle

- (void)maskBgViewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self hide];
}

- (void)edgeButtonTapped {
    [self hide];
}

#pragma mark - methods 

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.25
     animations:^{
         CGRect rect = self.tableViewFrame;
         self.contentTableView.frame = rect;
         self.maskBgView.alpha = self.bgAlpha;
         [self layoutIfNeeded];
     }];
}

- (void)hide {
    [UIView animateWithDuration:0.25
                     animations:^{
                         CGRect rect = self.tableViewFrame;
                         rect.origin.x = SCREEN_WIDTH;
                         self.contentTableView.frame = rect;
                         self.maskBgView.alpha = 0;
                         [self layoutIfNeeded];
                     }completion:^(BOOL finished) {
                         self.hidden = YES;
                         if (self.hiddenBlock) {
                             self.hiddenBlock();
                         }
                     }];
}

#pragma mark - accessors

- (UIView *)maskBgView {
    if (!_maskBgView) {
        _maskBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskBgView.backgroundColor = [UIColor blackColor];
        _maskBgView.alpha = self.bgAlpha;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskBgViewTapped:)];
        [_maskBgView addGestureRecognizer:tap];
    }
    return _maskBgView;
}

- (UIView *)contentTableView {
    if (!_contentTableView) {
        CGRect rect = self.tableViewFrame;
        rect.origin.x = SCREEN_WIDTH;
        _contentTableView = [[UIView alloc] initWithFrame:rect];
        _contentTableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _contentTableView;
}

- (UIButton *)edgeButton {
    if (!_edgeButton) {
        _edgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_edgeButton setImage:self.edgeButtonImage forState:UIControlStateNormal];
        [_edgeButton addTarget:self action:@selector(edgeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edgeButton;
}
@end
