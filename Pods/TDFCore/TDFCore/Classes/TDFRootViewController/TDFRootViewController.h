//
//  TDFRootViewController.h
//  RestApp
//
//  Created by 於卓慧 on 16/4/14.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libextobjc/libextobjc.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <TDFNavigationBarKit/TDFNavigationBarKit.h>
#import <TDFInternationalKit/TDFInternationalKit.h>
#import <TDFFooterKit/TDFFooterKit.h>
#import <TDFAdaptationKit/TDFAdaptationKit.h>

@interface TDFRootViewController : UIViewController

// 导航栏样式，默认白色，需要在viewDidLoad里面设置
@property (nonatomic, assign) TDFNavigationBarStyle navigationBarStyle;

///将加载符号放到window上
@property (nonatomic ,strong)UIWindow *mainWindow;
/// 不与原来的hud名字重复,解决hud被导航条盖到
@property (nonatomic, strong)MBProgressHUD *progressHud;

// 临时方法.用来处理就的Navigation bar在Navigation Controller中不显示
@property (nonatomic, assign) BOOL needHideOldNavigationBar;

@property (nonatomic, assign) BOOL isPresentMode;

- (void)setRightBarButtonHidden:(BOOL)hidden;

- (BOOL)isModal;

/**
 这个方法是为了兼容 供应链 和 掌柜对于老页面背景的调整方式
 
 默认 NO （掌柜方）
 供应链需要实现一个分类重写这个方法返回 YES
 
 @return 是否在 viewWillAppear 时对背景页面进行调整
 */
- (BOOL)shouldAdjustBackgroundImageViewFrameWhenViewWillAppear;
@end

@interface TDFRootViewController (Deprecated)
- (void)rightNavigationButtonAction:(id)sender;
- (void)leftNavigationButtonAction:(id)sender;
- (void)configLeftNavigationBar;
//左上角特殊按钮   1.leftButtonImg（图片） 2.leftButtonName 按钮名字
- (void)configLeftNavigationBar:(NSString *)leftButtonImg leftButtonName:(NSString *)leftButtonName;
- (void)configRightNavigationBar:(NSString *)rightButtonType rightButtonName:(NSString *)rightButtonName;
- (void)configNavigationBar:(BOOL)isChanged;
//内容变更后，返回弹出提示消息
- (void)alertChangedMessage:(BOOL)isChange;
//处理确认后的操作，需要子类自己实现
- (void)confirmChangedMessage;
///显示加载符号
- (void)showProgressHudWithText:(NSString *)text;



@end
