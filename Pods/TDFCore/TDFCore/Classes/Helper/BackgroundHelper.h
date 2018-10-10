//
//  BackgroundHelper.h
//  CardApp
//
//  Created by SHAOJIANQING-MAC on 13-6-25.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BackgroundData;
@interface BackgroundHelper : NSObject


+ (void)initWithMain:(UIImageView *)backgroundViewP;
+ (void)loadBackground:(BackgroundData *)image;

+ (NSString *)getBackgroundImage;

@end
