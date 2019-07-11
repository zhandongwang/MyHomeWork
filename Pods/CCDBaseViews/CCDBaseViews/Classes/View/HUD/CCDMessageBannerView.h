//
//  CCDMessageBannerView.h
//  Pods
//
//  Created by 凤梨 on 17/3/30.
//
//

#import <UIKit/UIKit.h>
#import "CCDBaseViews.h"

@class CCDRichToastViewModel;

@interface CCDMessageBannerView : UIView {
}

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *content;

@property(nonatomic) CCDMessageBannerType type;

@property(nonatomic, copy) NSString *iconTitle;

@property(nonatomic, copy) NSString *actionTitle;

@property(nonatomic, copy) void (^callback)(void);

- (id)initWithTitle:(NSString *)title content:(NSString *)content iconTitle:(NSString *)iconTitle actionTitle:(NSString *)actionTitle type:(CCDMessageBannerType)type callback:(void (^)(void))callback;

- (void)showInView:(UIView *)view;

@end
