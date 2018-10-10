//
//  BackgroundHelper.m
//  CardApp
//
//  Created by SHAOJIANQING-MAC on 13-6-25.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//
#import "GlobeConstants.h"
#import "NSString+Estimate.h"
#import "BackgroundHelper.h"
#import "BackgroundData.h"
#import "RestConstants.h"
#import <UIKit/UIKit.h>
#import "PropertyList.h"
#import "ObjectUtil.h"

@implementation BackgroundHelper

static UIImageView *backgroundView;

+ (void)initWithMain:(UIImageView *)backgroundViewP
{
    backgroundView = backgroundViewP;
    NSString *image = [PropertyList readValue:BG_FILE];
    if([NSString isBlank:image]) {
        image = @"bg_01b.jpg";
    }
    [backgroundView setImage:[UIImage imageNamed:image]];
}


+ (void)loadBackground:(BackgroundData *)backgroundData;
{
    if ([ObjectUtil isNotNull:backgroundData]) {
        [PropertyList updateValue:backgroundData.blackBgName forKey:BG_FILE];
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_BgImage__Change object:backgroundData.blackBgName];
    }
}

+ (NSString *)getBackgroundImage
{
    NSString *image = [PropertyList readValue:BG_FILE];
    if ([NSString isBlank:image]) {
        image = @"bg_01b.jpg";
    }
    return image;
}

@end
