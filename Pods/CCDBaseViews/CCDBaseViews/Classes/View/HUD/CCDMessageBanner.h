//
//  CCDMessageBanner.h
//  Pods
//
//  Created by 凤梨 on 17/3/30.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCDMessageBannerType) {
    CCDMessageBannerTypeError,
    CCDMessageBannerTypeWarning,
    CCDMessageBannerTypeInfo
};

@interface CCDMessageBanner : NSObject

+ (void)showMessageBannerInView:(UIView *)view
                      WithTitle:(NSString *)title
                       subtitle:(NSString *)subTitle
                      iconTitle:(NSString *)iconTitle
                    actionTitle:(NSString *)actionTitle
                           type:(CCDMessageBannerType)type
                       callback:(void (^)(void))callback;

@end
