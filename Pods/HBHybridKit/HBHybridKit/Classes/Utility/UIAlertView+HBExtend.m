//
//  UIAlertView+HBExtend.m
//  weather
//
//  Created by CaydenK on 2017/3/14.
//  Copyright © 2017年 CaydenK. All rights reserved.
//

#import "UIAlertView+HBExtend.h"
#import <objc/runtime.h>

@class HBAlertDelegate;
@interface UIAlertView ()

@property (copy, nonatomic) void (^_hb_block)(UIAlertView *alertView, NSInteger buttonIndex);
@property (strong, nonatomic) HBAlertDelegate *_hb_delegate;

@end




@interface HBAlertDelegate : NSObject <UIAlertViewDelegate>

@end

@implementation HBAlertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    !alertView._hb_block ?: alertView._hb_block(alertView, buttonIndex);
}

@end

@implementation UIAlertView (HBExtend)

+ (UIAlertView*)hb_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block {
    UIAlertView *alertView = [[[self class] alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    alertView._hb_delegate = [HBAlertDelegate new];
    alertView.delegate = alertView._hb_delegate;
    // Set other buttons
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *button, NSUInteger idx, BOOL *stop) {
        [alertView addButtonWithTitle:button];
    }];
    
    if (block) alertView._hb_block = block;
    [alertView show];
    return alertView;

}


#pragma mark - Getter & Setter
- (void (^)(UIAlertView *, NSInteger))_hb_block {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)set_hb_block:(void (^)(UIAlertView *, NSInteger))_hb_block {
    objc_setAssociatedObject(self, @selector(_hb_block), _hb_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (HBAlertDelegate *)_hb_delegate {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)set_hb_delegate:(HBAlertDelegate *)_hb_delegate {
    objc_setAssociatedObject(self, @selector(_hb_delegate), _hb_delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
