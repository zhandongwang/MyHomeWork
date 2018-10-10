//
//  SystemUtil.m
//  CardApp
//
//  Created by SHAOJIANQING-MAC on 13-6-26.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//

#import "ObjectUtil.h"
#import "SystemUtil.h"
#import "sys/utsname.h"
#import <Masonry/Masonry.h>

///屏幕宏
#define IOS_6 6
#define IOS_7 7
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation SystemUtil

+ (NSInteger)getSystemType
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return IOS_7;
    }
    return IOS_6;
}

+ (void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
+(void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if ([window viewWithTag:100101]) {
        [[window viewWithTag:100101] removeFromSuperview];
    }
    UIView *showview =  [[UIView alloc]init];
    showview.tag = 100101;
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    showview.backgroundColor = [UIColor blackColor];
    [showview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(showview.superview.mas_bottom).offset(-10);
        make.centerX.equalTo(showview.superview.mas_centerX);
        make.width.lessThanOrEqualTo(@(SCREEN_WIDTH-16));
    }];
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    [showview addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(showview).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    [UIView animateWithDuration:3 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}


+ (NSString *)getXibName:(NSString *)xibName
{
    if ([ObjectUtil isNotNull:xibName]) {
        NSString *device = [[self class]getDeviceName];
        if ([@"iPhone 5" isEqualToString:device]) {
            return [xibName stringByAppendingFormat:@"5"];
        }
    }
    return xibName;
}

+ (NSString *)getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([device hasPrefix:@"iPhone"]) {
        if ([device isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
        if ([device isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
        if ([device isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
        if ([device isEqualToString:@"iPhone4,1"])    return @"iPhone 4";
        if ([device isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone5,3"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone5,4"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone5,5"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone5,6"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone5,7"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone5,8"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone5,9"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone6,1"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone6,2"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone6,3"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone6,4"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone6,5"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone6,6"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone7,1"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone7,2"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone7,3"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone7,4"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone7,5"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone7,6"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone7,7"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone7,8"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone8,1"])    return @"iPhone 5";
        if ([device isEqualToString:@"iPhone8,2"])    return @"iPhone 5";
    } else if ([device hasPrefix:@"iPad"]) {
        return @"iPhone 4";
    }
    return @"iPhone 5";
}

@end
