//
//  PlayModel.h
//  RestApp
//
//  Created by 果汁 on 15/7/21.
//  Copyright (c) 2015年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayModel : NSObject

+ (MPMoviePlayerViewController *)createVideoPlay:(NSString *)str WithVc:(UIViewController *)vc;

+ (NSString *)getCurrntNet;

@end
