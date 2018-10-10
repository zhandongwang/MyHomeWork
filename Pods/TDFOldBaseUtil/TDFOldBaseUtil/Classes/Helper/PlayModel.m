//
//  PlayModel.m
//  RestApp
//
//  Created by 果汁 on 15/7/21.
//  Copyright (c) 2015年 杭州迪火科技有限公司. All rights reserved.
//

#import "PlayModel.h"
#import "XHAnimalUtil.h"
#import "AFNetworkReachabilityManager.h"

@implementation PlayModel

+ (NSString *)getCurrntNet
{
    NSString *result ;
    switch ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus]) {
        case AFNetworkReachabilityStatusUnknown:
            result = NSLocalizedString(@"未知", nil);
            break;
        case AFNetworkReachabilityStatusNotReachable:
            result = NSLocalizedString(@"无网络", nil);
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            result = @"3g";
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            result = @"Wi-Fi";
            break;
        default:
            break;
    }
    return result;
}

+ (MPMoviePlayerViewController *)createVideoPlay:(NSString *)str WithVc:(UIViewController *)vc
{
    MPMoviePlayerViewController *playerController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:str]];
    [playerController.moviePlayer play];
    playerController.moviePlayer.controlStyle =  MPMovieControlStyleFullscreen;
    [XHAnimalUtil animal:vc type:kCATransitionPush direct:kCATransitionFromRight];
    playerController.view.backgroundColor = [UIColor clearColor];
    playerController.view.frame = [UIScreen mainScreen].bounds;
    
    int i = 10000;
    for (id view1 in playerController.view.subviews) {
        for (id view2 in [view1 subviews]) {
            for (id view3 in [view2 subviews]) {
                for (id view4 in [view3 subviews]) {
                    for (id view5 in [view4 subviews]) {
                        for (id view6 in [view5 subviews]) {
                            if ([view6 isKindOfClass:[UIButton class]]) {
                                UIButton *btn = (UIButton *)view6;
                                btn.tag = i;
                                if (btn.tag == 10001 || btn.tag ==10002) {
                                    btn.hidden = YES;
                                }
                                i++;
                            }
                        }
                    }
                }
            }
        }
        return playerController;
    }
    return nil;
}
@end


