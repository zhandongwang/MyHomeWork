//
//  HBWebDebugView.h
//  weather
//
//  Created by CaydenK on 2017/5/9.
//  Copyright © 2017年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBWebDebugView : UIView

+ (instancetype)webDebugViewWithCurrentURL:(NSString *(^)())urlHandler completion:(void(^)(NSString *url))completion;

@end
