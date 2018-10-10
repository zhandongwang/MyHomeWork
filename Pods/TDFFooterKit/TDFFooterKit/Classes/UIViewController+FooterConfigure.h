//
//  UIViewController+FooterConfigure.h
//  Pods
//
//  Created by tripleCC on 2017/8/19.
//
//

#import <UIKit/UIKit.h>
#import "TDFFooter.h"

////////////////////////////////////////////////////////////////////////////////
// 遵守 TDFViewControllerProtocol ，才会自动把 footer 提到界面最前端
////////////////////////////////////////////////////////////////////////////////
@interface UIViewController (FooterConfigure)
@property (strong, nonatomic, readonly) NSArray <id <TDFFooterProtocol>> *tdf_footers;

/**
 是否设置底部偏移
 兼容老页面，新页面不需要设置
 默认 YES
 */
@property (assign, nonatomic) BOOL tdf_shouldAdjustFooterBottonMargin;

/**
 设置footer

 @param footers 要设置的footer
 */
- (void)tdf_setupFooters:(NSArray <id <TDFFooterProtocol>> *)footers;
- (void)tdf_setupLiteralFooters:(id<TDFFooterProtocol>)first, ... NS_REQUIRES_NIL_TERMINATION;

/**
 清除footer

 @param footer 需要清除的footer
 */
- (void)tdf_clearFooter:(id <TDFFooterProtocol>)footer;

- (void)tdf_insertFooter:(id <TDFFooterProtocol>)footer above:(id <TDFFooterProtocol>)aboveFooter;
- (void)tdf_addFooter:(id <TDFFooterProtocol>)footer;

/**
 清除所有footer
 */
- (void)tdf_clearFooters;

- (void)tdf_updateFooterViewsFrame;

- (void)tdf_debugFooters;
#pragma mark -- 使用svg列表显示按钮列表
- (void)tdf_setupFootersUsedSvg:(NSArray<id<TDFFooterProtocol>> *)footers;

- (void)tdf_setupLiteralFootersUsedSvg:(id<TDFFooterProtocol>)first, ... NS_REQUIRES_NIL_TERMINATION;
@end
