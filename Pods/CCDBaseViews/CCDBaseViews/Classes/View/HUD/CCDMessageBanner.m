//
//  CCDMessageBanner.m
//  Pods
//
//  Created by 凤梨 on 17/3/30.
//
//

#import "CCDMessageBanner.h"
#import "CCDMessageBannerView.h"

@interface CCDMessageBanner ()
@end

@implementation CCDMessageBanner {
}

+ (void)showMessageBannerInView:(UIView *)view WithTitle:(NSString *)title subtitle:(NSString *)subTitle iconTitle:(NSString *)iconTitle actionTitle:(NSString *)actionTitle type:(CCDMessageBannerType)type callback:(void (^)())callback {
    CCDMessageBannerView *banner = [[CCDMessageBannerView alloc] initWithTitle:title content:subTitle iconTitle:iconTitle actionTitle:actionTitle type:type callback:callback];
    [banner showInView:view];
}
@end
