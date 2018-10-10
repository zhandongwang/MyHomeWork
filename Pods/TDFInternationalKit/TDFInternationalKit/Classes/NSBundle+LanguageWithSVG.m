//
//  NSBundle+LanguageWithSVG.m
//  GYLBaseModule
//
//  Created by larou on 2017/12/28.
//

#import "NSBundle+LanguageWithSVG.h"
#import "NSBundle+Language.h"


@implementation NSBundle (LanguageWithSVG)
+ (NSString *)svgFontName {
    NSString *language = [self currentLanguage];
    if ([TDFEnglishLanguage isEqualToString:language] ) {
        return @"icomoon_en";
    } else if ([TDFTraditionalChineseLanguage isEqualToString:language]) {
        return @"icomoon_tw";
    } else {
        return @"icomoon_zh";
    }
}

+ (NSString *)svgFontNameWithoutText {
    return @"icomoon";
}

@end
