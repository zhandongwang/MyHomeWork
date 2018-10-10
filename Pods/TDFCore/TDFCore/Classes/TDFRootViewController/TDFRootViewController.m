//
//  TDFRootViewController.m
//  RestApp
//
//  Created by 於卓慧 on 16/4/14.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//
#import "TDFAdaptation.h"
#import "GlobeConstants.h"
#import "TDFRootViewController.h"
#import "BackgroundHelper.h"
#import "UIImage+Resize.h"
#import "NSString+Estimate.h"
#import "RestAppConstants.h"
#import "UIFont+tdf_standard.h"
#import "UIColor+tdf_standard.h"
#import "UIColor+Hex.h"
#import "UIImage+tdf_blur.h"
#import "UIViewController+BackgroundConfigure.h"
#import "UIViewController+NavigationBarConfigure.h"
#import "TDFCustomNavBarAdapter.h"
#import "UIViewController+FooterConfigure.h"

NSString * kGYLHomeThemeChangedNotificationMsg = @"GYL_HOME_THEME_CHANGED_NOTIFICATION";
NSString * kHomeThemeChangedNotificationMsg = @"HOME_THEME_CHANGED_NOTIFICATION";

#define ProgressHudTag 1000000 //为了保证window上始终只有一个菊花
@interface TDFRootViewController () <TDFNavigationClickListenerProtocol>

@end
@implementation TDFRootViewController

//供应链
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self tdf_updateNavigationBarWithStyle:self.navigationBarStyle];

    //发送埋点通知  解决耦合问题
    NSString *ClassName = NSStringFromClass([self class]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TDFSupplychainUserStatistics" object:ClassName];
}

- (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIWindow *)mainWindow
{
    return [UIApplication sharedApplication].delegate.window;
}

- (MBProgressHUD *)progressHud
{
    if ([self.mainWindow viewWithTag:ProgressHudTag]) {
        [self.mainWindow bringSubviewToFront:[self.mainWindow viewWithTag:ProgressHudTag]];
        [self.mainWindow viewWithTag:ProgressHudTag].hidden = NO;
        return [self.mainWindow viewWithTag:ProgressHudTag];
    }
    if (!_progressHud) {
        _progressHud = [[MBProgressHUD alloc] initWithView:self.mainWindow];
        _progressHud.tag = ProgressHudTag;
        _progressHud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _progressHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _progressHud.contentColor = [UIColor whiteColor];
        [self.mainWindow addSubview:_progressHud];
    }
    return _progressHud;
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    
    CGFloat height = self.view.safeAreaInsets.top;
    
    if (iPhoneX && height == 0) { // 如果是X，并且用的系统导航栏，那么页面要往上提
        self.tdf_backgroundImageView.frame = (CGRect){
            .origin = CGPointMake(0, -44-44),
            .size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 44 + 44)
        };
        
        self.tdf_backgroundAlphaView.frame = self.tdf_backgroundImageView.frame;
    }
}

//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//
//    [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]||[obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
//            obj.backgroundColor = [UIColor clearColor];
//        }
//    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tdf_alertUnsavedWhenCancel = NO;
    [self tdf_setupBackgroundField];
    [self tdf_setupNavigationBarType:TDFNavigationBarTypeNormal];
    [self configLeftNavigationBar];
    self.isPresentMode = NO;
    ///更换背景图时对应图变化
    [self changeBackGroundNotifaction];
    //添加弹窗通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TDFShowPopuoView" object:self];
    
}

- (void)changeBackGroundNotifaction
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBgFinish:) name:kHomeThemeChangedNotificationMsg object:nil];
    //供应链中更换背景使用下边的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBgFinish:) name:kGYLHomeThemeChangedNotificationMsg object:nil];
}

- (void)loadBgFinish:(NSNotification*) notification
{
    [self tdf_setupBackgroundField];
}

- (void)configLeftNavigationBar {
    [self tdf_setupBackItemType:TDFBackItemTypeBack];
    //和交互确认，模态下左侧也是返回图标按钮
//    if ([self isModal]) {
//        [self tdf_setupBackItemType:TDFBackItemTypeCancel];
//    } else {
//        [self tdf_setupBackItemType:TDFBackItemTypeBack];
//    }
}

- (void)configLeftNavigationBar:(NSString *)leftButtonImg leftButtonName:(NSString *)leftButtonName {
    if ([leftButtonName isEqualToString:NSLocalizedString(@"返回", nil)]) {
        [self tdf_setupBackItemType:TDFBackItemTypeBack];
    } else if ([leftButtonName isEqualToString:NSLocalizedString(@"关闭", nil)]) {
        [self tdf_setupBackItemWithTitle:[[TDFCustomNavBarAdapter sharedInstance] adapterCloseTitle] image:[[TDFCustomNavBarAdapter sharedInstance] adapterCloseImageWithNavigationBarStyle:self.navigationBarStyle]];
    } else if ([leftButtonName isEqualToString:NSLocalizedString(@"取消", nil)]) {
        [self tdf_setupBackItemType:TDFBackItemTypeCancel];
    } else {
        [self tdf_setupBackItemWithTitle:leftButtonName image:[[TDFCustomNavBarAdapter sharedInstance] adapterLeftImageWithImage:[UIImage imageNamed:leftButtonImg]]];
    }
}

- (void)configRightNavigationBar:(NSString *)rightButtonType rightButtonName:(NSString *)rightButtonName {
    [self tdf_setupSureItemWithTitle:rightButtonName image:[[TDFCustomNavBarAdapter sharedInstance] adapterRightImageWithImage:[UIImage imageNamed:rightButtonType]]];
}

- (void)configNavigationBar:(BOOL)isChanged {
    
    if (self.navigationController.viewControllers.count > 1) {
        if (isChanged) {
            [self tdf_setupNavigationBarType:TDFNavigationBarTypeSaved];
        } else {
            [self tdf_setupNavigationBarType:TDFNavigationBarTypeNormal];
        }
    }
    
}

- (CGFloat)getWidthWithImageName:(NSString *)imageName buttonName:(NSString *)buttonName
{
    CGFloat imageWidth = (imageName.length == 0) ? 0 : 22.0f;
    
    CGSize size = [buttonName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
    return imageWidth + size.width;
}

- (void)setRightBarButtonHidden:(BOOL)hidden
{
    self.tdf_sureButton.hidden = hidden;
}

- (void)alertChangedMessage:(BOOL)isChange {
    
    if (isChange) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"内容有变更尚未保存,确定要退出吗?", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确认", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self confirmChangedMessage];
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:okAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else {
        [self confirmChangedMessage];
    }
}

- (void)confirmChangedMessage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNeedHideOldNavigationBar:(BOOL)needHideOldNavigationBar {
    _needHideOldNavigationBar = needHideOldNavigationBar;
    
    if (_needHideOldNavigationBar) {
        
        CGRect frame = self.view.bounds;
        CGFloat offset = 64;
        
        self.view.bounds = CGRectMake(0.0f, offset, frame.size.width, frame.size.height + offset);
        [self tdf_updateFooterViewsFrame];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for (UIView *subView in self.navigationController.view.subviews) {
        if (subView.tag == 10021 ||
            subView.tag == TAG_RATIOPICKERBOX ||
            subView.tag == TAG_NUMBERINPUTBOX ||
            subView.tag == TAG_CALENDARBOX    ||
            subView.tag == TAG_DATEPICKERBOX  ||
            subView.tag == TAG_NUMBERINPUTBOX ||
            subView.tag == TAG_OPTIONPICKERBOX ||
            subView.tag == TAG_PAIRPICKERBOX   ||
            subView.tag == TAG_RATIOPICKERBOX ||
            subView.tag == TAG_TIMEPICKERBOX) {
            subView.hidden = YES;
        }
    }
}

- (void)viewControllerDidTriggerRightClick:(UIViewController *)viewController
{
    [self rightNavigationButtonAction:self.tdf_sureButton];
}

- (void)viewControllerDidTriggerLeftClick:(UIViewController *)viewController
{
    [self leftNavigationButtonAction:self.tdf_backButton];
}

- (void)rightNavigationButtonAction:(id)sender {
    [self.tdf_sureButton setEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tdf_sureButton setEnabled:YES];
    });
    [self.view endEditing:YES];
}


- (void)leftNavigationButtonAction:(id)sender {
    
    if (self.isModal) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isModal {
    if([self presentingViewController]) {
        NSArray *viewcontrollers=self.navigationController.viewControllers;
        if (viewcontrollers.count>1) {
            if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
                return NO;
            }
        }
        else{
            return YES;
        }
    }
    if([[self presentingViewController] presentedViewController] == self)
        return YES;
    //    if([[[self navigationController] presentingViewController] presentedViewController] == [self navigationController])
    //        return YES;
    return [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]];
}

- (void)showProgressHudWithText:(NSString *)text
{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    self.progressHud.labelText = text;
    self.progressHud.square = YES;
    [self.progressHud show:YES];
#pragma GCC diagnostic pop
}

- (void)dealloc
{
    [self.progressHud hideAnimated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (BOOL)shouldAdjustBackgroundImageViewFrameWhenViewWillAppear {
    return NO;
}

- (TDFNavigationBarStyle)navigationBarStyle
{
    return self.tdf_navigationBarStyle;
}

- (void)setNavigationBarStyle:(TDFNavigationBarStyle)navigationBarStyle
{
    self.tdf_navigationBarStyle = navigationBarStyle;
}

@end

