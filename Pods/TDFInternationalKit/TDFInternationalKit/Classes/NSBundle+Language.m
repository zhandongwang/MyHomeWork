//
//  NSBundle+Language.m
//  RestApp
//
//  Created by Arlen on 2017/7/18.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import "NSBundle+Language.h"
#import <objc/runtime.h>
#import "TDFDataCenter.h"
//#import "TDFHTTPClient.h"

#define LANGUAGE_KEY @"LANGUAGE_KEY"
#define LANGUAGE    @"LANGUAGE"

static const char kBundleKey = 0;

static NSString *__currentLanguage = nil;

@implementation NSBundle (Language)

@dynamic language;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originSelector = NSSelectorFromString(@"localizedStringForKey:value:table:");
        SEL newSelector = NSSelectorFromString(@"tdf_localizedStringForKey:value:table:");
        Method originMethod = class_getInstanceMethod(class, originSelector);
        Method newMethod = class_getInstanceMethod(class, newSelector);
        
        BOOL addMethodSuccess = class_addMethod(class, originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (addMethodSuccess) {
            class_replaceMethod(class, newSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, newMethod);
        }
    });
}

- (NSString *)tdf_localizedStringForKey:(NSString *)key value:(nullable NSString *)value table:(nullable NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &kBundleKey);
    if (bundle) {
        NSString *string =  [bundle tdf_localizedStringForKey:key value:value table:tableName];
        if (!string) {
            string =    [self tdf_localizedStringForKey:key value:value table:tableName];
        }
        return string;
    }
    
    return [self tdf_localizedStringForKey:key value:value table:tableName];
}


+ (void)initialize {
    NSString *language = [self getCurrentLanguageFromLocation];
    __currentLanguage = language;
    [self setCurrentBundleByLanguage:language]; //设置当期语言的bundle
    [self setServiceLanguage:language];         //设置服务端header
}


//设置语言
+ (void)setLanguage:(NSString *)language {
    if (![__currentLanguage isEqualToString:language] && language != nil) {
        __currentLanguage = language;
        [self setServiceLanguage:language];         //设置服务器请求时的语言
        [self saveLnaguage:language];               //把语言保存到本地
        [self setCurrentBundleByLanguage:language]; //设置当前语言的bundle
        
        //修改完bundle后，发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:TDFChangeLanguageNotificationName object:nil];
    }
}


//设置服务器的语言
+ (void)setServiceLanguage:(NSString *)language {
    NSString *serviceLanguage = language;
    if ([language isEqualToString:TDFEnglishLanguage]) {
        serviceLanguage = @"en_US";
    } else if ([language isEqualToString:TDFSimplifiedChineseLanguage]) {
        serviceLanguage = @"zh_CN";
    } else if ([language isEqualToString:TDFTraditionalChineseLanguage]) {
        serviceLanguage = @"zh_TW";
    }
    else if ([language isEqualToString:TDFThaiLanguage]){
        serviceLanguage = @"th_TH";
    }
    
    [TDFDataCenter sharedInstance].language = serviceLanguage;
//    [[TDFHTTPClient sharedInstance].requestSerializer setValue:serviceLanguage forHTTPHeaderField:@"lang"];
}




//保存语言到本地
+ (void)saveLnaguage:(NSString *)language {
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:LANGUAGE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//设置当前语言的bundle
+ (void)setCurrentBundleByLanguage:(NSString *)language {
    NSBundle *bundel = language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil;
    if (bundel) {
        objc_setAssociatedObject([NSBundle mainBundle], &kBundleKey, bundel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


//从本地获取存储的语言、如果本地没有存储。则默认为使用简体中文。
+ (NSString *)getCurrentLanguageFromLocation {
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_KEY];
    if (currentLanguage) {
        return currentLanguage;
    }
    
    NSString *languageName = [[NSLocale preferredLanguages] firstObject];
    if ([languageName containsString:@"zh-Hans"]) {
        languageName = TDFSimplifiedChineseLanguage;
    }
    else if ([languageName containsString:@"zh-Hant"]) {
        languageName = TDFTraditionalChineseLanguage;
    }
    else if([languageName containsString:@"th"]) {
        languageName = TDFThaiLanguage;
    }
    else if ([languageName containsString:@"en"]) {
        languageName = TDFEnglishLanguage;
    }
    else {
        languageName = TDFEnglishLanguage;
    }
    currentLanguage = languageName;
    [self saveLnaguage:currentLanguage];    //保存到本地
    
    return currentLanguage;
}


+ (UIImage *)imageName:(NSString *)name {
    NSString *selectedLanguage = __currentLanguage;
    if ([selectedLanguage isEqualToString:@"th"]) {
        selectedLanguage = @"en";
    }
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",name,selectedLanguage]];
    if (!image) {
        image = [UIImage imageNamed:name];
    }
    return image;
}



+ (NSString *)currentLanguage {
    return __currentLanguage;
}

+ (BOOL)isEnglishLanguage {
    return [__currentLanguage isEqualToString:TDFEnglishLanguage];
}

- (void)setLanguage:(NSString *)language {
    __currentLanguage = language;
}
- (NSString *)language {
    return __currentLanguage;
}







@end










