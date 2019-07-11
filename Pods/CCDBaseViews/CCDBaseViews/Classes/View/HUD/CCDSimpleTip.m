//
//  CCDSimpleTip.m
//  Pods
//
//  Created by 凤梨 on 17/2/21.
//
//

#import <TDFTopMostController/UIViewController+TDFTopMostController.h>
#import <TDFHexColor/UIColor+TDFHexColor.h>
#import "CCDSimpleTip.h"
#import "MBProgressHUD.h"
@import CCDCore;
#define MAIN_SCREEN_WIDTH       [[UIScreen mainScreen] bounds].size.width
#define MAIN_SCREEN_HEIGHT      [[UIScreen mainScreen] bounds].size.height
#define kHUDMsgFont             [UIFont boldSystemFontOfSize:14]
static const CGFloat kHUDCentralMargin           = 20.0f;
static const CGFloat kHUDMargin                  = 5.0f;
static const CGFloat kHUDImageH                  = 60.0f;
static const CGFloat kHUDCentralViewCornerRadius = 20.0f;
static const CGFloat kHUDCentralWH               = 40.0f;
static const CGFloat kHUDLabelH                  = 20.0f;
static const CGFloat kHUDLabelMargin             = 5.0f;
@interface CCDSimpleTip() {
}
@end

@implementation CCDSimpleTip

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}


+ (void)showSimpleToast:(NSString *)title inKeyWindow:(BOOL)inKeyWindow{
    [self showSimpleToast:title duration:1.5 yOffset:0 inKeyWindow:YES];
}

+ (void)showSimpleToast:(NSString *)title {
    [self showSimpleToast:title duration:1.5];
}

+ (void)showSimpleToast:(NSString *)title duration:(NSTimeInterval)duration {
    [self showSimpleToast:title duration:duration yOffset:0];
}

+ (void)showSimpleToast:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset {
    [self showSimpleToast:title duration:duration yOffset:yOffset inKeyWindow:NO];
}

+ (void)showSimpleToast:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset inKeyWindow:(BOOL)inKeyWindow {
    
    [self setBoundsAndMessage:title isCenter:NO];
}

+ (void)showSimpleToastMethod:(NSString *)title isCenter:(BOOL)isCenter {
    [self setBoundsAndMessage:title isCenter:YES];
}

+ (void)setBoundsAndMessage:(NSString *)title isCenter:(BOOL)isCenter
{
    UILabel *centralLabel = [[UILabel alloc] init];
    UIView *centralView = [[UIView alloc] init];
    UIWindow *viewWindow = [[[UIApplication sharedApplication] delegate] window];
    for (UIWindow *hudWindow in [UIApplication sharedApplication].windows) {
        if([viewWindow isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")])  {
            viewWindow = hudWindow;
        }
    }
    centralLabel.textAlignment = NSTextAlignmentCenter;
    centralLabel.numberOfLines = 0;
    centralLabel.font = kHUDMsgFont;
    centralLabel.textColor = [UIColor tdf_colorWithHexString:@"#333333"];
    if (isCenter == YES) {
        centralView.center = CGPointMake(viewWindow.bounds.size.width / 2, viewWindow.bounds.size.height / 2);
    }else {
        centralView.center = CGPointMake(viewWindow.bounds.size.width / 2, viewWindow.bounds.size.height / 2 + 230);
    }
    centralView.backgroundColor = [UIColor colorWithRed:218/255.0f green:216/255.0f blue:216/255.0f alpha:1];
    [centralView addSubview:centralLabel];
    [viewWindow addSubview:centralView];
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewWindow makeKeyWindow];
    });
    CGSize size = CGSizeZero;
    if (title) {
        size = [self sizeFromString:title];
        centralLabel.text = title;
    }
    CGFloat w = MAX(size.width, kHUDCentralWH) + kHUDLabelMargin * 2 + kHUDMargin * 2;
    CGFloat h = MAX(size.height, 10)+ kHUDLabelMargin * 2;
    centralView.bounds  = CGRectMake(0, 0, 90, 30);
    CGRect rect = centralView.bounds;
    w += kHUDCentralMargin;
    h += 10;
    rect.size.width = w;
    rect.size.height = h;
    centralLabel.frame = CGRectMake(kHUDCentralMargin / 2, 0, w - kHUDCentralMargin, h);
    centralView.bounds = rect;
    centralView.layer.cornerRadius = kHUDCentralViewCornerRadius;
    [self hideWithDelayTime:1.5 view:centralView];
}

+ (void)hideWithDelayTime:(NSTimeInterval)time view:(UIView *)view{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [weakSelf hide:view];
                   });
}

+ (void)hide:(UIView *)view {
    [view removeFromSuperview];
}

+ (CGSize)sizeFromString:(NSString *)string {
    CGSize maxSize = CGSizeMake(MAIN_SCREEN_WIDTH - kHUDCentralMargin * 2 - kHUDMargin * 2, MAIN_SCREEN_HEIGHT - kHUDImageH);
    return [string boundingRectWithSize:maxSize
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{
                                          NSFontAttributeName:kHUDMsgFont
                                          }
                                context:nil].size;
}


+ (void)showActivityIndicator {
    [self showActivityIndicatorWithSubTitle:nil];
}

+ (void)showActivityIndicatorWithSubTitle:(NSString *)subTitle {
    [self showActivityIndicator:nil subTitle:subTitle];
}

+ (void)showActivityIndicator:(NSString *)title subTitle:(NSString *)subTitle {
    [self showActivityIndicator:title subTitle:subTitle inView:[UIViewController tdf_topMostController].view];
}

+ (void)showActivityIndicator:(NSString *)title subTitle:(NSString *)subTitle inView:(UIView *)view {
    dispatch_main_async_ccdSafe(^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = title;
        hud.detailsLabelText = subTitle;
        hud.labelFont = [UIFont systemFontOfSize:13.0];
        hud.detailsLabelFont = [UIFont systemFontOfSize:12.0];
    });
}


+ (void)hideActivityIndicator {
    [self hideActivityIndicatorForView:[UIViewController tdf_topMostController].view];;
}

+ (void)hideActivityIndicatorForView:(UIView *)view {
    dispatch_main_async_ccdSafe(^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    });

}


@end
