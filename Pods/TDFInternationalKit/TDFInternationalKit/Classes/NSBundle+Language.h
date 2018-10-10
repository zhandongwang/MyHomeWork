//
//  NSBundle+Language.h
//  RestApp
//
//  Created by Arlen on 2017/7/18.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NSLocalizedImage(a) [NSBundle imageName:a]

//语言环境
static NSString * const TDFSimplifiedChineseLanguage   =   @"zh-Hans";
static NSString * const TDFTraditionalChineseLanguage  =   @"zh-Hant";
static NSString * const TDFEnglishLanguage     = @"en";
static NSString * const TDFThaiLanguage      = @"th";

//修改语言环境后的通知
static NSString * const TDFChangeLanguageNotificationName = @"TDFChangeLanguageNotificationName";

@interface NSBundle (Language)

@property (nonatomic, strong) NSString *language;

/**
 设置语言
 
 @param language 语言类型，可以设置上面的三种。
 */
+ (void)setLanguage:(NSString *)language;


/**
 国际化获取图片。英文图片以_en结尾。中文图片以_zh-Hans结束
 
 @param name 图片的名字。_en 或 _zh-Hans 之前的部分。如果没有则本来的名字显示。实在没有那就没有了
 @return 返回的图片
 */
+ (UIImage *)imageName:(NSString *)name;



/**
 获取当前的语言
 
 @return 返回当前语言的字符串
 */
+ (NSString *)currentLanguage;


+ (NSString *)getCurrentLanguageFromLocation;

+ (BOOL)isEnglishLanguage;

@end





