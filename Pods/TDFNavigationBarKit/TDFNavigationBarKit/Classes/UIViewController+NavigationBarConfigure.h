//
//  TDFRootViewController+NavigationBarConfigure.h
//  Pods
//
//  Created by tripleCC on 1/16/17.
//
//

#import <UIKit/UIKit.h>
#import <TDFCoreProtocol/TDFCoreProtocol.h>

/**
 遵守此协议的控制器，在背景未设置时，会设置 TDFNavigationBarStyleWhite 背景、 TDFNavigationBarTypeNormal 的导航栏样式
 并且在 viewWillAppear 中自动更新导航栏、状态栏样式
 */
@protocol TDFNavigationBarStyleInitializeProtocol <TDFViewControllerProtocol>
@end

/**
 控制器导航栏点击回调协议
 */
@protocol TDFNavigationClickListenerProtocol <TDFViewControllerProtocol>
@optional

/**
 右侧按钮点击回调
 */
- (void)viewControllerDidTriggerRightClick:(UIViewController *)viewController;


//////////////////////////////////////////////////////////////////////////////
// 调用顺序由上往下
//////////////////////////////////////////////////////////////////////////////

/**
 左侧按钮点击回调
 默认会触发 pop / unsaved 提醒 操作
 */
- (void)viewControllerDidTriggerLeftClick:(UIViewController *)viewController;

/**
 是否要自动处理右侧点击事件
 不实现的话，默认yes
 
 @return 是否自动处理
 */
- (BOOL)viewControllerShouldAutohandleLeftClickEvent:(UIViewController *)viewController;

/**
 做 pop 相关操作，没有实现的话，默认 pop 一层
 如果要跳转多层，可以实现这个协议方法
 */
- (void)viewControllerDidTriggerPopAction:(UIViewController *)viewController;
@end

typedef NS_ENUM (NSInteger, TDFBackItemType) {
    TDFBackItemTypeNone,
    TDFBackItemTypeCancel, /// 取消
    TDFBackItemTypeBack, ///  返回
};

typedef NS_ENUM (NSInteger, TDFSureItemType) {
    TDFSureItemTypeNone,
    TDFSureItemTypeSaved, /// 保存
    TDFSureItemTypeConfirmed, /// 确定
    TDFSureItemTypeSured, /// 确认
    TDFSureItemTypeSubmit, /// 确认
    TDFSureItemTypeOperate, /// 操作
};

/**
 导航栏类型
 */
typedef NS_ENUM(NSInteger, TDFNavigationBarType) {
    TDFNavigationBarTypeNormal, /// 正常   <
    TDFNavigationBarTypeSaved, /// 保存   取消  保存
    TDFNavigationBarTypeConfirmed, /// 确定   取消  确定
    TDFNavigationBarTypeSubmit, /// 确定   取消  确定
};

/**
 导航栏风格
 */
typedef NS_ENUM(NSInteger, TDFNavigationBarStyle) {
    TDFNavigationBarStyleNone,
    TDFNavigationBarStyleWhite,
    TDFNavigationBarStyleBlack,
};

@interface UIViewController (NavigationBarConfigure) <TDFNavigationClickListenerProtocol>

/**
 取消弹出警告未保存alert
 
 默认针对 push 出来的控制器是 true，针对 present 出来的控制器是 false
 */
@property (assign, nonatomic) BOOL tdf_alertUnsavedWhenCancel;

/**
 导航点击监听者
 
 默认是self
 */
@property (weak, nonatomic) id <TDFNavigationClickListenerProtocol> tdf_listener;

/**
 tag 表示当前按钮所处类型
 */
@property (strong, nonatomic, readonly) UIButton *tdf_backButton;
@property (strong, nonatomic, readonly) UIButton *tdf_sureButton;

/**
 导航栏风格
 
 默认是 TDFNavigationBarStyleNone
 */
@property (assign, nonatomic) TDFNavigationBarStyle tdf_navigationBarStyle;

/**
 更新导航栏背景风格
 
 @param navigationBarStyle 导航栏风格
 */
- (void)tdf_updateNavigationBarWithStyle:(TDFNavigationBarStyle)navigationBarStyle;

/**
 设置导航栏类型
 
 当导航栏风格为 None 时，此方法会设置默认风格为 TDFNavigationBarStyleWhite
 
 @param type 类型
 */
- (void)tdf_setupNavigationBarType:(TDFNavigationBarType)type;

/**
 设置返回导航栏类型
 
 @param type 类型
 */
- (void)tdf_setupBackItemType:(TDFBackItemType)type;
- (void)tdf_setupBackItemWithTitle:(NSString *)title image:(UIImage *)image;

/**
 设置确定导航栏类型
 
 @param type 类型
 */
- (void)tdf_setupSureItemType:(TDFSureItemType)type;
- (void)tdf_setupSureItemWithTitle:(NSString *)title image:(UIImage *)image;

/**
 设置标题 子标题
 
 @param title 标题
 @param subtitle 子标题
 */
- (void)tdf_setupTitle:(NSString *)title subtitle:(NSString *)subtitle;
@end

////////////////////////////////////////////////////////////////
//                       用tdf_*开头的方法
@interface UIViewController (NavigationBarConfigureDeprecated)
@property (assign, nonatomic) BOOL nbc_alertUnsavedWhenCancel;
- (void)nbc_setupNavigationBarType:(TDFNavigationBarType)type;
- (void)nbc_setupSureItemWithTitle:(NSString *)title image:(UIImage *)image;
@end
////////////////////////////////////////////////////////////////
