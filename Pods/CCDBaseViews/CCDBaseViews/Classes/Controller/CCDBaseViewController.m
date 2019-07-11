//
//  CCDBaseViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/13.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <TDFTopMostController/UIViewController+TDFTopMostController.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD.h"
#import "CCDSimpleTip.h"
#import "CCDBaseViewController.h"
#import "TDFBundleHelper.h"
#import "NSObject+TDFObserver.h"
#import "UIBarButtonItem+SXCreate.h"
#import "CCDBaseViewsConst.h"
#import <TDFTalkingDataSDK/TalkingData.h>
@import Masonry;

@interface CCDBaseViewController ()
@property(nonatomic, assign) BOOL didFirstAppear;
@property(nonatomic, assign) BOOL willFirstAppear;
@property(nonatomic, assign) BOOL didDisappear;

@property(nonatomic, strong, readwrite) UIImageView *bgImageView;

@end

@implementation CCDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.bgImageView setImage:TDFImageFromBundle(@"viewController_Bg", [CCDBaseViewsConst class])];
    [self.view addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self setupBackButton];

}

- (void)setIsViewAppeared:(BOOL)isViewAppeared {
    _isViewAppeared = isViewAppeared;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isViewAppeared = NO;
    if (!_willFirstAppear) {
        _willFirstAppear = YES;
        [self viewWillFirstAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isViewAppeared = YES;
    if (!_didFirstAppear) {
        _didFirstAppear = YES;
        [self viewDidFirstAppear:animated];
    }
    if (self.didDisappear) {
        [self viewDidReappear:animated];
        self.didDisappear = NO;
    }
#if defined(DAILY) || defined(RELEASE)
    [TalkingData trackPageBegin:NSStringFromClass([self class])];
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.didDisappear = YES;
#if defined(DAILY) || defined(RELEASE)
    [TalkingData trackPageEnd:NSStringFromClass([self class])];
#endif
}

- (void)viewWillFirstAppear:(BOOL)animated {

}

- (void)viewDidFirstAppear:(BOOL)animated {

}

- (void)viewDidReappear:(BOOL)animated {

}


#pragma mark - Config

- (void)setupBackButton {
    UIBarButtonItem *item       = [UIBarButtonItem itemWithTarget:self action:@selector(popBackAction) title:@""];
    self.navigationItem.backBarButtonItem = item;

    if (self.navigationController.childViewControllers.count > 1) {
        UIBarButtonItem *backItem = [UIBarButtonItem itemWithTarget:self
                                                             action:@selector(backButtonAction)
                                                              image:TDFImageFromBundle(@"navigator_back_white", [CCDBaseViewsConst class])];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}

#pragma mark Actions

- (void)popBackAction {
    if (self.isViewAppeared) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)backButtonAction {
    if (self.backButtonBlock) {
        self.backButtonBlock();
    }
    if (!self.notPopWhenBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dismissWithAction {
    if (self.backButtonBlock) {
        self.backButtonBlock();
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark 属性

- (void)setShowCancelButton:(BOOL)showCancelButton {
    if (_showCancelButton == showCancelButton) {
        return;
    } else {
        _showCancelButton = showCancelButton;
        if (_showCancelButton) {
            UIBarButtonItem *cancelButtonItem = [UIBarButtonItem itemWithTarget:self
                                                                        action:@selector(cancelAction:)
                                                                         image:TDFImageFromBundle(@"navigator_icon_cancel", [CCDBaseViewsConst class])];
            self.navigationItem.leftBarButtonItem = cancelButtonItem;
        } else {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

- (MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    if (_hud && ![self.view.subviews containsObject:_hud]) {
        [self.view addSubview:_hud];
    }
    return _hud;
}

- (void)cancelAction:(UIButton *)cancelButton {
    if (self.cancelBlock) {
        self.cancelBlock();
    } else {
        [self.view endEditing:YES];
        [self dismissWithAction];
    }
}

- (void)dealloc {
    [self tdf_stopObserveAll];
}
@end
