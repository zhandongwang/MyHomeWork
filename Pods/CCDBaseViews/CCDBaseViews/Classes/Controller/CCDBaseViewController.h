//
//  CCDBaseViewController.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/13.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface CCDBaseViewController : UIViewController

@property(nonatomic, strong, nonnull) MBProgressHUD *hud;

@property(nonatomic, assign, getter = isShowingCancelButton) BOOL showCancelButton;

@property(nonatomic, copy, nullable) void (^cancelBlock)(void);

@property(nonatomic, copy, nullable) void (^backButtonBlock)(void);

/**
 * 页面已经展示
 */
@property(nonatomic, assign) BOOL isViewAppeared;

@property(nonatomic, assign) BOOL notPopWhenBack;

/**
 ViewController的背景图
 */
@property(nonatomic, strong, readonly, nullable) UIImageView *bgImageView;

/**
 NavigationBar返回按钮按下事件，子类可重写
 */
- (void)backButtonAction;
- (void)setupBackButton;

//view的展示方法
- (void)viewWillFirstAppear:(BOOL)animated;

- (void)viewDidFirstAppear:(BOOL)animated;

- (void)viewDidReappear:(BOOL)animated;

@end
