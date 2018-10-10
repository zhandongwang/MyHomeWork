//
//  NSBundle+HBHybridKit.m
//  weather
//
//  Created by infiq on 2017/3/31.
//  Copyright © 2017年 CaydenK. All rights reserved.
//

#import "NSBundle+HBHybridKit.h"
#import "HBWebEngine.h"

@implementation NSBundle (HBHybridKit)

+ (NSString *)hb_localizedStringForKey:(NSString *)key {
    return [self hb_localizedStringForKey:key value:@""];
}

+ (NSString *)hb_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = nil;
        if ([HBWebEngine appLanguageFetchBlock]) {
            NSDictionary *appLanguageInfo = HBWebEngine.appLanguageFetchBlock();
            language = appLanguageInfo[HBLanugageBundleKey];
        }
        if (language.length == 0) {
            language = [NSLocale preferredLanguages].firstObject;
        }

        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }

        // 从MJRefresh.bundle中查找资源
        bundle = [NSBundle bundleWithPath:[[NSBundle hb_bundle] pathForResource:language ofType:@"lproj"]];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

+ (instancetype)hb_bundle {
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[HBWebEngine class]] pathForResource:@"Resource" ofType:@"bundle"]];
    }
    return refreshBundle;
}

@end
