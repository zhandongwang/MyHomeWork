//
//  UIViewController+FooterConfigure.m
//  Pods
//
//  Created by tripleCC on 2017/8/19.
//
//
#import <objc/runtime.h>
#import <TDFCoreProtocol/TDFCoreProtocol.h>
#import "TDFAdaptation.h"
#import "UIViewController+FooterConfigure.h"
#import "TDFFooterView.h"
#import "TDFFooterSvgView.h"

//static const CGFloat kTDFFooterButtonWH = 55.0f;
static const CGFloat kTDFFooterButtonsLeftOffset = 8.0f;
static const CGFloat kTDFFooterButtonsHorizontalOffset = 10.0f;
static const CGFloat kTDFFooterButtonsHorizontalEdgeMarginOffset = 15.0f;
__unused static const CGFloat kTDFFooterButtonsVerticalOffset = 10.0f;
static const CGFloat kTDFFooterButtonsVerticalEdgeMarginOffset = 15.0f;

static void FCSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }   
}

@implementation UIViewController (FooterConfigure)
- (void)_fc_viewWillAppear:(BOOL)animated {
    
    if ([self conformsToProtocol:@protocol(TDFViewControllerProtocol)]) {
        for (UIView *view in [self _tdf_footerViews]) {
            [[self view] bringSubviewToFront:view];
        }
    }
    [self _fc_viewWillAppear:animated];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FCSwizzleInstanceMethod(self, @selector(viewWillAppear:), @selector(_fc_viewWillAppear:));
    });
}

- (void)tdf_debugFooters {
    for (UIView *v in [self _tdf_footerViews]) {
        v.backgroundColor = [UIColor redColor];
    }
}

- (void)tdf_setupFooters:(NSArray<id<TDFFooterProtocol>> *)footers {
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:footers.count];
    NSArray *oldfooters = [self tdf_footers];
    
    for (id <TDFFooterProtocol> footer in footers) {
        if (![oldfooters containsObject:footers]) {
            TDFFooterView *view = [[TDFFooterView alloc] initWithFrame:CGRectZero];
            view.footer = footer;
            [views addObject:view];
        }
    }
    [self tdf_clearFooters];
    [self set_tdf_footerViews:[[self _tdf_footerViews] ?: @[] arrayByAddingObjectsFromArray:views]];
}

- (void)tdf_setupLiteralFooters:(id<TDFFooterProtocol>)first, ... {
    NSParameterAssert(first);
    
    NSMutableArray *footers = [NSMutableArray array];
    
    va_list args;
    va_start(args, first);
    for (id<TDFFooterProtocol> current = first; current != nil; current = va_arg(args, id<TDFFooterProtocol>)) {
        [footers addObject:current];
    }
    va_end(args);
    
    [self tdf_setupFooters:footers];
}

- (void)tdf_addFooter:(id<TDFFooterProtocol>)footer {
    if ([self.tdf_footers containsObject:footer]) {
        return;
    }
    
    NSMutableArray *footers = self.tdf_footers.mutableCopy;
    [footers addObject:footer];
    [self tdf_setupFooters:footers];
}

- (void)tdf_insertFooter:(id<TDFFooterProtocol>)footer above:(id<TDFFooterProtocol>)aboveFooter {
    if ([self.tdf_footers containsObject:footer]) {
        return;
    }
    
    NSMutableArray *footers = self.tdf_footers.mutableCopy;
    NSInteger index = [footers indexOfObject:aboveFooter];
    if (index != NSNotFound && index < footers.count) {
        [footers insertObject:footer atIndex:index + 1];
    } else {
        [footers addObject:footer];
    }
    [self tdf_setupFooters:footers];
}

- (void)tdf_clearFooter:(id<TDFFooterProtocol>)footer {
    for (TDFFooterView *view in [self _tdf_footerViews]) {
        if ([view.footer isEqual:footer]) {
            [view removeFromSuperview];
            
            NSMutableArray *mViews = [[self _tdf_footerViews] mutableCopy];
            [mViews removeObject:view];
            [self set_tdf_footerViews:mViews];
            
            return;
        }
    }
}

- (void)tdf_clearFooters {
    for (TDFFooterView *view in [self _tdf_footerViews]) {
        [view removeFromSuperview];
    }
    [self set_tdf_footerViews:@[]];
}

- (void)_tdf_updateFooterViews:(NSArray <TDFFooterView *> *)views {
    for (TDFFooterView *view in views) {
        [self.view addSubview:view];
    }
    [self _tdf_updateFooterViewsFrame:views];
}

- (void)tdf_updateFooterViewsFrame {
    [self _tdf_updateFooterViewsFrame:[self _tdf_footerViews]];
}

- (void)_tdf_updateFooterViewsFrame:(NSArray <TDFFooterView *> *)views {
    CGFloat RX = [UIScreen mainScreen].bounds.size.width;
    CGFloat LX = kTDFFooterButtonsHorizontalEdgeMarginOffset;
    
    for (TDFFooterView *view in views) {
        CGFloat y = [UIScreen mainScreen].bounds.size.height - view.footer.size.height - (kTDFFooterButtonsVerticalEdgeMarginOffset + (iPhoneX ? 30.0f : 0));
        
        if (self.tdf_shouldAdjustFooterBottonMargin) {
            y -= 72.0f;
        }
        
        if ([view.footer alignment] == TDFFooterAlignmentLeftForVerticalVersion) {
            y -= view.footer.size.height - kTDFFooterButtonsLeftOffset;
            view.frame = CGRectMake(kTDFFooterButtonsHorizontalEdgeMarginOffset, y, view.footer.size.width, view.footer.size.height);
        } else if ([view.footer alignment] == TDFFooterAlignmentLeft) {
            view.frame = CGRectMake(LX, y, view.footer.size.width, view.footer.size.height);
            LX += view.footer.size.width + kTDFFooterButtonsHorizontalOffset;
        } else {
            if (RX == [UIScreen mainScreen].bounds.size.width) {
                RX -= kTDFFooterButtonsHorizontalEdgeMarginOffset + view.footer.size.width;
            }
            view.frame = CGRectMake(RX, y, view.footer.size.width, view.footer.size.height);
            RX -= view.footer.size.width + kTDFFooterButtonsHorizontalOffset;
        }
    }
}


- (BOOL)tdf_shouldAdjustFooterBottonMargin {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (!number) {
        return YES;
    }
    
    return [number boolValue];
}

- (void)setTdf_shouldAdjustFooterBottonMargin:(BOOL)tdf_shouldAdjustFooterBottonMargin {
    objc_setAssociatedObject(self, @selector(tdf_shouldAdjustFooterBottonMargin), @(tdf_shouldAdjustFooterBottonMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self tdf_updateFooterViewsFrame];
}

- (NSArray <TDFFooterView *>*)_tdf_footerViews {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)set_tdf_footerViews:(NSArray *)_tdf_footerViews {
    objc_setAssociatedObject(self, @selector(_tdf_footerViews), _tdf_footerViews ?: @[], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self _tdf_updateFooterViews:_tdf_footerViews];
}

- (NSArray<id<TDFFooterProtocol>> *)tdf_footers {
    NSMutableArray *footers = [NSMutableArray arrayWithCapacity:[self _tdf_footerViews].count];
    for (TDFFooterView *view in [self _tdf_footerViews]) {
        [footers addObject:view.footer];
    }
    return footers;
}


#pragma mark -- 使用svg列表显示按钮列表
- (void)tdf_setupFootersUsedSvg:(NSArray<id<TDFFooterProtocol>> *)footers {
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:footers.count];
    NSArray *oldFooters = [self tdf_footers];
    for (id<TDFFooterProtocol> footer in footers) {
        if (![oldFooters containsObject:footers]) {
            TDFFooterSvgView *svgView = [[TDFFooterSvgView alloc] initWithFrame:CGRectZero];
            svgView.footer = footer;
            [views addObject:svgView];
        }
    }
    [self tdf_clearFooters];
    [self set_tdf_footerViews:[[self _tdf_footerViews] ?:@[] arrayByAddingObjectsFromArray:views]];
}

- (void)tdf_setupLiteralFootersUsedSvg:(id<TDFFooterProtocol>)first, ... {
    NSParameterAssert(first);
    
    NSMutableArray *footers = [NSMutableArray array];
    
    va_list args;
    va_start(args, first);
    for (id<TDFFooterProtocol> current = first; current != nil; current = va_arg(args, id<TDFFooterProtocol>)) {
        [footers addObject:current];
    }
    va_end(args);
    
    [self tdf_setupFootersUsedSvg:footers];
}

@end
