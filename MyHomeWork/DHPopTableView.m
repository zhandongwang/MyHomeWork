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
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIView *contentTableView;
@property (nonatomic, assign) CGRect contentTableViewFrame;

@end

@implementation DHPopTableView

- (instancetype)initWithTableViewFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        _contentTableViewFrame = frame;
        [self addSubview:self.maskBgView];
        [self addSubview:self.contentTableView];
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark - event handle

- (void)maskBgViewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self hide];
}

#pragma mark - methods 

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.25
     animations:^{
         CGRect rect = self.contentTableViewFrame;
         self.contentTableView.frame = rect;
         self.maskBgView.alpha = self.bgAlpha;
     }];
}

- (void)hide {
    [UIView animateWithDuration:0.25
                     animations:^{
                         CGRect rect = self.contentTableViewFrame;
                         rect.origin.x = SCREEN_WIDTH;
                         self.contentTableView.frame = rect;
                         self.maskBgView.alpha = 0;
                     }completion:^(BOOL finished) {
                         self.hidden = YES;
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
        CGRect rect = self.contentTableViewFrame;
        rect.origin.x = SCREEN_WIDTH;
        _contentTableView = [[UIView alloc] initWithFrame:rect];
        _contentTableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _contentTableView;
}

@end
