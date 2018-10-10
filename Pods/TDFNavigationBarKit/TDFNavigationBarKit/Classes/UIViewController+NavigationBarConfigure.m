//
//  TDFRootViewController+NavigationBarConfigure.m
//  Pods
//
//  Created by tripleCC on 1/16/17.
//
//
#import <objc/runtime.h>
#import "TDFAdaptation.h"
#import "UIViewController+NavigationBarConfigure.h"
#import "UIViewController+BackgroundConfigure.h"
#import "UIViewController+AlertMessage.h"
#import "UIColor+RGB.h"
#import "NSString+SizeCalculator.h"
#import "UIImage+tdf_blur.h"
#import "UIColor+tdf_standard.h"
#import "UIFont+tdf_standard.h"
#import "TDFCustomNavBarAdapter.h"

#define kTDFNBCButtonFont [UIFont systemFontOfSize:16.0f]
#define TDFCoreNaviBundleImage(key) [UIImage imageNamed:key inBundle:[NSBundle bundleForClass:[TDFCustomNavBarAdapter class]] compatibleWithTraitCollection:nil]

static const CGFloat kTDFNBCMaxButtonWidth = 150.0f;
static const CGFloat kTDFNBCMinButtonWidth = 60.0f;
static const CGFloat kTDFNBCButtonImageWidth = 25.0f;
static NSString *const kTDFNBCButtonAccessibilityValue = @"kTDFNBCButtonAccessibilityValue";

static void NBCSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UIViewController (NavigationBarConfigure)

- (void)_nbc_viewWillAppear:(BOOL)animated {
    if ([self conformsToProtocol:@protocol(TDFNavigationBarStyleInitializeProtocol)]) {
        [self tdf_updateNavigationBarWithStyle:[self tdf_navigationBarStyle]];
    }
    [self _nbc_viewWillAppear:animated];
}

- (void)_nbc_viewDidLoad {
    if ([self conformsToProtocol:@protocol(TDFNavigationBarStyleInitializeProtocol)]) {
        [self tdf_setupBackgroundField];
        [self tdf_setupNavigationBarType:TDFNavigationBarTypeNormal];
    }
    [self _nbc_viewDidLoad];
}

//- (void)_nbc_viewDidLayoutSubviews
//{
//    if ([self conformsToProtocol:@protocol(TDFNavigationBarStyleInitializeProtocol)]) {
//        [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//            if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]||[obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
//                obj.backgroundColor = [UIColor clearColor];
//            }
//        }];
//    }
//
//    [self _nbc_viewDidLayoutSubviews];
//}

- (void)nbc_viewSafeAreaInsetsDidChange
{
    if ([self conformsToProtocol:@protocol(TDFNavigationBarStyleInitializeProtocol)]) {
        if (iPhoneX && VIEWSAFEAREAINSETS(self.view).top == 0) { // 如果是X，并且用的系统导航栏，那么页面要往上提
            self.tdf_backgroundImageView.frame = (CGRect){
                .origin = CGPointMake(0, -44-44),
                .size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 44 + 44)
            };
            
            self.tdf_backgroundAlphaView.frame = self.tdf_backgroundImageView.frame;
        }
    }
    
    [self nbc_viewSafeAreaInsetsDidChange];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NBCSwizzleInstanceMethod(self, @selector(viewWillAppear:), @selector(_nbc_viewWillAppear:));
        NBCSwizzleInstanceMethod(self, @selector(viewDidLoad), @selector(_nbc_viewDidLoad));
//        NBCSwizzleInstanceMethod(self, @selector(viewDidLayoutSubviews), @selector(_nbc_viewDidLayoutSubviews));
        NBCSwizzleInstanceMethod(self, @selector(viewSafeAreaInsetsDidChange), @selector(nbc_viewSafeAreaInsetsDidChange));
    });
}

#pragma mark - 根据枚举设置导航栏
- (void)tdf_setupNavigationBarType:(TDFNavigationBarType)type {
    if (self.tdf_navigationBarStyle == TDFNavigationBarStyleNone) {
        self.tdf_navigationBarStyle = TDFNavigationBarStyleWhite;
    }
    
    switch (type) {
        case TDFNavigationBarTypeNormal: {
            [self tdf_setupBackItemType:TDFBackItemTypeBack];
            [self tdf_setupSureItemType:TDFSureItemTypeNone];
        } break;
        case TDFNavigationBarTypeSaved: {
            [self tdf_setupBackItemType:TDFBackItemTypeCancel];
            [self tdf_setupSureItemType:TDFSureItemTypeSaved];
        } break;
        case TDFNavigationBarTypeConfirmed: {
            [self tdf_setupBackItemType:TDFBackItemTypeCancel];
            [self tdf_setupSureItemType:TDFSureItemTypeConfirmed];
        } break;
        case TDFNavigationBarTypeSubmit: {
            [self tdf_setupBackItemType:TDFBackItemTypeCancel];
            [self tdf_setupSureItemType:TDFSureItemTypeSubmit];
        } break;
        default:
            break;
    }
}

- (void)tdf_setupBackItemType:(TDFBackItemType)type {
    [self _tdf_bindListener];
    [self _tdf_configureAlertUnsavedWhenCancel];
    
    [self _tdf_setupBackItemWithTitle:[self _tdf_backTitleWithBackItemType:type]
                                image:[self _tdf_backImageWithBackItemType:type]];
    
    self.tdf_backButton.tag = type;
}

- (void)tdf_setupBackItemWithTitle:(NSString *)title image:(UIImage *)image {
    [self _tdf_bindListener];
    
    // 兼容外部直接使用此方法，设置 title 和 image 为 nil 情况
    if (!title.length && !image) {
        self.tdf_backButton.tag = TDFBackItemTypeNone;
    }
    self.tdf_backButton.hidden = NO;
    image = [UIImage imageWithCGImage:image.CGImage scale:64.0f / 22.0f orientation:UIImageOrientationUp];
    [self _tdf_setupBackItemWithTitle:title image:image];
}

- (void)tdf_setupSureItemType:(TDFSureItemType)type {
    [self _tdf_bindListener];
    
    if (type == TDFSureItemTypeNone) {
        self.tdf_sureButton.hidden = YES;
        return;
    }
    self.tdf_sureButton.hidden = NO;
    
    [self _tdf_setupSureItemWithTitle:[self _tdf_sureTitleWithSureItemType:type]
                                image:[self _tdf_sureImageWithSureItemType:type]];
    
    
    self.tdf_sureButton.tag = type;
}

- (void)tdf_setupSureItemWithTitle:(NSString *)title image:(UIImage *)image {
    [self _tdf_bindListener];
    
    // 兼容外部直接使用此方法，设置 title 和 image 为 nil 情况
    if (!title.length && !image) {
        self.tdf_sureButton.tag = TDFBackItemTypeNone;
    }
    self.tdf_sureButton.hidden = NO;
    image = [UIImage imageWithCGImage:image.CGImage scale:64.0f / 22.0f orientation:UIImageOrientationUp];
    [self _tdf_setupSureItemWithTitle:title image:image];
}

#pragma mark - 导航栏标题/子标题设置
- (void)tdf_setupTitle:(NSString *)title subtitle:(NSString *)subtitle {
    [self _tdf_setupTitle:title subtitle:subtitle navigationBarStyle:self.tdf_navigationBarStyle];
}

- (void)_tdf_setupTitle:(NSString *)title subtitle:(NSString *)subtitle navigationBarStyle:(TDFNavigationBarStyle)navigationBarStyle {
    if (!title.length && !subtitle.length) return;
    
    self.navigationItem.titleView = [self _tdf_barTitleLabel];
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] init];
    if (title) {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:title attributes:[self _tdf_titleTextAttributesWithStyle:navigationBarStyle]];
        [mAttrStr appendAttributedString:attrStr];
    }
    
    if (subtitle) {
        subtitle = [@"\n" stringByAppendingString:subtitle];
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:subtitle attributes:[self _tdf_subtitleTextAttributesWithStyle:navigationBarStyle]];
        [mAttrStr appendAttributedString:attrStr];
    }
    
    [self _tdf_barTitleLabel].attributedText = mAttrStr;
    [self _tdf_barTitleLabel].frame = (CGRect) {
        .origin = CGPointZero,
        .size = CGSizeMake(mAttrStr.size.width, self.navigationController.navigationBar.bounds.size.height)
    };
}

- (NSDictionary <NSString *, id> *)_tdf_subtitleTextAttributesWithStyle:(TDFNavigationBarStyle)navigationBarStyle {
    NSMutableDictionary <NSString *, id> *attr = [self _tdf_titleTextAttributesWithStyle:navigationBarStyle].mutableCopy;
    attr[NSFontAttributeName] = [UIFont tdf_13];
    return attr;
}

- (NSDictionary <NSString *, id> *)_tdf_titleTextAttributesWithStyle:(TDFNavigationBarStyle)navigationBarStyle {
    switch (navigationBarStyle) {
        case TDFNavigationBarStyleWhite: {
            return @{
                     NSForegroundColorAttributeName: [[TDFCustomNavBarAdapter sharedInstance] adapterTitleColorWithDefaultColor:[UIColor tdf_hex_333333]],
                     NSFontAttributeName : [UIFont tdf_17_bold]
                     };
        } break;
        case TDFNavigationBarStyleBlack: {
            return @{
                     NSForegroundColorAttributeName: [[TDFCustomNavBarAdapter sharedInstance] adapterTitleColorWithDefaultColor:[UIColor tdf_hex_FFFFFF]],
                     NSFontAttributeName : [UIFont tdf_17_bold]
                     };
        } break;
        case TDFNavigationBarStyleNone:
        default:
            break;
    }
    return nil;
}

- (void)_tdf_setupTitleTextAttributesWithStyle:(TDFNavigationBarStyle)navigationBarStyle {
    // 如果没有设置自定义，那么采用原生titleView
    if (!self.navigationItem.titleView) {
        self.navigationController.navigationBar.titleTextAttributes = [self _tdf_titleTextAttributesWithStyle:navigationBarStyle];
    } else {
        NSArray *titles = [[self _tdf_barTitleLabel].attributedText.string componentsSeparatedByString:@"\n"];
        NSString *subtitle = [titles.firstObject isEqual:titles.lastObject] ? nil : titles.lastObject;
        [self _tdf_setupTitle:titles.firstObject subtitle:subtitle navigationBarStyle:navigationBarStyle];
    }
}

- (UILabel *)_tdf_barTitleLabel {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 2;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        objc_setAssociatedObject(self, _cmd, titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - 导航栏左右按钮设置

- (void)_tdf_setupBackItemWithTitle:(NSString *)title image:(UIImage *)image {
    [self _tdf_updateNavigationButton:self.tdf_backButton withTitle:title image:image];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.tdf_backButton];
}

- (void)_tdf_setupSureItemWithTitle:(NSString *)title image:(UIImage *)image {
    [self _tdf_updateNavigationButton:self.tdf_sureButton withTitle:title image:image];
    // 如果默认给一个空的右侧 item，会造成 bar title 左移 bug，这里在两者有其中至少一个值有效时，再创建
    if (title.length > 0 || image) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.tdf_sureButton];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (UIColor *)_tdf_buttonTitleColorWithStyle:(TDFNavigationBarStyle)navigationBarStyle {
    switch (navigationBarStyle) {
        case TDFNavigationBarStyleWhite: {
            return [[TDFCustomNavBarAdapter sharedInstance] adapterButtonColorWithDefaultColor:[UIColor tdf_hex_0088FF]];
        } break;
        case TDFNavigationBarStyleBlack: {
            return [[TDFCustomNavBarAdapter sharedInstance] adapterButtonColorWithDefaultColor:[UIColor tdf_hex_FFFFFF]];
        } break;
        case TDFNavigationBarStyleNone:
        default:
            break;
    }
    return nil;
}

- (UIImage *)_tdf_backImageWithBackItemType:(TDFBackItemType)type {
    CGImageRef cgimage = nil;
    
    switch (type) {
        case TDFBackItemTypeBack: {
            switch (self.tdf_navigationBarStyle) {
                case TDFNavigationBarStyleWhite: {
                    cgimage = [[TDFCustomNavBarAdapter sharedInstance] adapterBackArrowImageWithDefaultImage:TDFCoreNaviBundleImage(@"core_icon_back_blue")].CGImage;
                } break;
                case TDFNavigationBarStyleBlack: {
                    cgimage = [[TDFCustomNavBarAdapter sharedInstance] adapterBackArrowImageWithDefaultImage:TDFCoreNaviBundleImage(@"common_nbc_back")].CGImage;
                } break;
                case TDFNavigationBarStyleNone:
                default:
                    break;
            }
        } break;
        case TDFBackItemTypeCancel: {
            cgimage = [[TDFCustomNavBarAdapter sharedInstance] adapterLeftImageWithImage:TDFCoreNaviBundleImage(@"common_nbc_cancel")].CGImage;
        } break;
        default:
            return [self.tdf_backButton imageForState:UIControlStateNormal];
    }
    
    return [UIImage imageWithCGImage:cgimage scale:64.0f / 22.0f orientation:UIImageOrientationUp];
}

- (UIImage *)_tdf_sureImageWithSureItemType:(TDFSureItemType)type {
    CGImageRef cgimage = nil;
    
    switch (type) {
        case TDFSureItemTypeSaved:
        case TDFSureItemTypeConfirmed: {
            cgimage = [[TDFCustomNavBarAdapter sharedInstance] adapterLeftImageWithImage:TDFCoreNaviBundleImage(@"common_nbc_ok")].CGImage;
        } break;
        default:
            return [self.tdf_sureButton imageForState:UIControlStateNormal];
    }
    
    
    return [UIImage imageWithCGImage:cgimage scale:64.0f / 22.0f orientation:UIImageOrientationUp];
}

- (NSString *)_tdf_backTitleWithBackItemType:(TDFBackItemType)type {
    switch (type) {
        case TDFBackItemTypeBack: {
            return [[TDFCustomNavBarAdapter sharedInstance] adapterLeftBackTitle];
        } break;
        case TDFBackItemTypeCancel: {
            return NSLocalizedString(@"取消", nil);
        } break;
        default:
            return [self.tdf_backButton titleForState:UIControlStateNormal];
    }
}

- (NSString *)_tdf_sureTitleWithSureItemType:(TDFSureItemType)type {
    switch (type) {
        case TDFSureItemTypeSaved: {
            return NSLocalizedString(@"保存", nil);
        } break;
        case TDFSureItemTypeConfirmed: {
            return NSLocalizedString(@"确定", nil);
        } break;
        case TDFSureItemTypeSured: {
            return NSLocalizedString(@"确认", nil);
        } break;
        case TDFSureItemTypeSubmit: {
            return NSLocalizedString(@"提交", nil);
        } break;
        case TDFSureItemTypeOperate: {
            return NSLocalizedString(@"操作", nil);
        } break;
        default:
            return [self.tdf_sureButton titleForState:UIControlStateNormal];
    }
}

- (void)_tdf_updateNavigationButton:(UIButton *)button withTitle:(NSString *)title image:(UIImage *)image {
    [button setTitleColor:[self _tdf_buttonTitleColorWithStyle:self.tdf_navigationBarStyle] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    CGRect frame = button.frame;
    frame.size.width = MAX(MIN(kTDFNBCMaxButtonWidth, [title tdf_sizeForFont:kTDFNBCButtonFont].width + kTDFNBCButtonImageWidth), kTDFNBCMinButtonWidth);
    button.frame = frame;
}

- (UIButton *)_tdf_generateNavigationButtonWithSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, kTDFNBCMaxButtonWidth, 40.0f);
    [button.titleLabel setFont:kTDFNBCButtonFont];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.accessibilityValue = kTDFNBCButtonAccessibilityValue;
    return button;
}

- (UIButton *)tdf_backButton {
    UIButton *backButton = objc_getAssociatedObject(self, _cmd);
    if (!backButton || ![backButton.accessibilityValue isEqualToString:kTDFNBCButtonAccessibilityValue]) {
        backButton = [self _tdf_generateNavigationButtonWithSelector:@selector(_tdf_viewControllerDidTriggerLeftClick:)];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        objc_setAssociatedObject(self, _cmd, backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backButton;
}

- (UIButton *)tdf_sureButton {
    UIButton *sureButton = objc_getAssociatedObject(self, _cmd);
    if (!sureButton || ![sureButton.accessibilityValue isEqualToString:kTDFNBCButtonAccessibilityValue]) {
        sureButton = [self _tdf_generateNavigationButtonWithSelector:@selector(_tdf_viewControllerDidTriggerRightClick:)];
        sureButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        sureButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        objc_setAssociatedObject(self, _cmd, sureButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return sureButton;
}

#pragma mark - 导航栏背景设置
- (void)tdf_updateNavigationBarWithStyle:(TDFNavigationBarStyle)navigationBarStyle {
    self.tdf_navigationBarStyle = navigationBarStyle;
}

- (void)setTdf_navigationBarStyle:(TDFNavigationBarStyle)tdf_navigationBarStyle {
    objc_setAssociatedObject(self, @selector(tdf_navigationBarStyle), @(tdf_navigationBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self _tdf_setupNavigationBarWithStyle:tdf_navigationBarStyle];
}

- (TDFNavigationBarStyle)tdf_navigationBarStyle {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)_tdf_setupNavigationBarWithStyle:(TDFNavigationBarStyle)navigationBarStyle {
    
    //配置供应链主题风格
    [[TDFCustomNavBarAdapter sharedInstance] adapterGYLThemeStyleWithNavigationBarStyle:navigationBarStyle];
    // 更新标题和图片颜色
    [self.tdf_sureButton setTitleColor:[self _tdf_buttonTitleColorWithStyle:navigationBarStyle] forState:UIControlStateNormal];
    [self.tdf_backButton setTitleColor:[self _tdf_buttonTitleColorWithStyle:navigationBarStyle] forState:UIControlStateNormal];
    
    [self.tdf_backButton setImage:[self _tdf_backImageWithBackItemType:self.tdf_backButton.tag] forState:UIControlStateNormal];
    [self.tdf_sureButton setImage:[self _tdf_sureImageWithSureItemType:self.tdf_sureButton.tag] forState:UIControlStateNormal];

    // 更新背景萌版
    [self _tdf_setupNavigationBarBackgroundWithStyle:navigationBarStyle];
    
    // 设置标题风格
    [self _tdf_setupTitleTextAttributesWithStyle:navigationBarStyle];
}

- (void)_tdf_setupNavigationBarBackgroundWithStyle:(TDFNavigationBarStyle)navigationBarStyle {
    UIColor *barColor = nil;
    UIColor *backColor = nil;
    switch (navigationBarStyle) {
        case TDFNavigationBarStyleWhite: {
            [UIApplication sharedApplication].statusBarStyle = [[TDFCustomNavBarAdapter sharedInstance] adpterBarStyleWithDefaultStyle:UIStatusBarStyleDefault];
            barColor = [[UIColor tdf_colorWithRGB:0xF9F9F9] colorWithAlphaComponent:0.8];
            backColor = [[UIColor tdf_colorWithRGB:0xF9F9F9] colorWithAlphaComponent:0.8];
        } break;
        case TDFNavigationBarStyleBlack: {
            [UIApplication sharedApplication].statusBarStyle = [[TDFCustomNavBarAdapter sharedInstance] adpterBarStyleWithDefaultStyle:UIStatusBarStyleLightContent];
            barColor = [UIColor blackColor];
            backColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        } break;
        case TDFNavigationBarStyleNone:
        default:
            break;
    }
    self.tdf_backgroundAlphaView.backgroundColor = [[TDFCustomNavBarAdapter sharedInstance] adapterAlphaViewColorWithDefaultColor:backColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage tdf_imageWithColor:[[TDFCustomNavBarAdapter sharedInstance] adapterNavigationBarColorWithDefaultColor:barColor]] forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - 导航栏点击回调设置
- (void)_tdf_bindListener {
    if (!self.tdf_listener) {
        self.tdf_listener = self;
    }
}

- (void)_tdf_configureAlertUnsavedWhenCancel {
    if (!self.tdf_alertUnsavedWhenCancelNumber) {
        self.tdf_alertUnsavedWhenCancelNumber = [self _tdf_isModal] ? @NO : @YES;
    }
}

- (void)_tdf_viewControllerDidTriggerLeftClick:(UIViewController *)viewController {
    if ([self.tdf_listener respondsToSelector:@selector(viewControllerDidTriggerLeftClick:)]) {
        [self.tdf_listener viewControllerDidTriggerLeftClick:self];
    }
    
    BOOL autohandle = YES;
    if ([self.tdf_listener respondsToSelector:@selector(viewControllerShouldAutohandleLeftClickEvent:)]) {
        autohandle = [self.tdf_listener viewControllerShouldAutohandleLeftClickEvent:self];
    }
    
    if (autohandle) {
        if (self.tdf_alertUnsavedWhenCancel && self.tdf_backButton.tag == TDFBackItemTypeCancel) {
            [self _tdf_showUnsavedAlert];
        } else if (self.tdf_backButton.tag == TDFBackItemTypeBack) {
            [self _tdf_popViewController];
        }
    }
}

- (void)_tdf_viewControllerDidTriggerRightClick:(UIViewController *)viewController {
    if ([self.tdf_listener respondsToSelector:@selector(viewControllerDidTriggerRightClick:)]) {
        [self.tdf_listener viewControllerDidTriggerRightClick:self];
    }
    
    // 0.5s 节流阀
    self.tdf_sureButton.enabled = NO;
    __weak typeof(self) wself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wself.tdf_sureButton.enabled = YES;
    });
}

- (void)_tdf_showUnsavedAlert {
    [self showMessage:NSLocalizedString(@"内容有变更尚未保存,确定要退出吗?", nil) confirm: ^{
        [self _tdf_popViewController];
    } cancel:nil];
}

- (void)_tdf_popViewController {
    if ([self.tdf_listener respondsToSelector:@selector(viewControllerDidTriggerPopAction:)]) {
        [self.tdf_listener viewControllerDidTriggerPopAction:self];
        return;
    }
    
    if ([self _tdf_isModal]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([self.navigationController.viewControllers containsObject:self]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (BOOL)_tdf_isModal {
    if ([self presentingViewController]) {
        NSArray *viewcontrollers = self.navigationController.viewControllers;
        if (viewcontrollers.count > 1) {
            if ([[viewcontrollers objectAtIndex:viewcontrollers.count - 1] isEqual:self]) {
                return NO;
            }
        } else {
            return YES;
        }
    }
    if ([[self presentingViewController] presentedViewController] == self) {
        return YES;
    }
    return [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]];
}

- (id<TDFNavigationClickListenerProtocol>)tdf_listener {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTdf_listener:(id<TDFNavigationClickListenerProtocol>)listener {
    objc_setAssociatedObject(self, @selector(tdf_listener), listener, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)tdf_alertUnsavedWhenCancel {
    return self.tdf_alertUnsavedWhenCancelNumber.boolValue;
}

- (void)setTdf_alertUnsavedWhenCancel:(BOOL)tdf_alertUnsavedWhenCancel {
    self.tdf_alertUnsavedWhenCancelNumber = @(tdf_alertUnsavedWhenCancel);
}

- (NSNumber *)tdf_alertUnsavedWhenCancelNumber {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTdf_alertUnsavedWhenCancelNumber:(NSNumber *)tdf_alertUnsavedWhenCancelNumber {
    objc_setAssociatedObject(self, @selector(tdf_alertUnsavedWhenCancelNumber), tdf_alertUnsavedWhenCancelNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation UIViewController (NavigationBarConfigureDeprecated)

- (void)nbc_setupNavigationBarType:(TDFNavigationBarType)type {
    [self tdf_setupNavigationBarType:type];
}

- (void)nbc_setupSureItemWithTitle:(NSString *)title image:(UIImage *)image {
    [self tdf_setupSureItemWithTitle:title image:image];
}

- (BOOL)nbc_alertUnsavedWhenCancel {
    return self.tdf_alertUnsavedWhenCancel;
}

- (void)setNbc_alertUnsavedWhenCancel:(BOOL)nbc_alertUnsavedWhenCancel {
    self.tdf_alertUnsavedWhenCancel = nbc_alertUnsavedWhenCancel;
}
@end


