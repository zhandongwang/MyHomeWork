//
//  NSBundle+LanguageWithSVG.h
//  GYLBaseModule
//
//  Created by larou on 2017/12/28.
//

#import <Foundation/Foundation.h>

#define NSLocalizedSVG [NSBundle svgFontName]
#define NSLocalizedSVGWithoutText [NSBundle svgFontNameWithoutText]

@interface NSBundle (LanguageWithSVG)


+ (NSString *)svgFontName ;

+ (NSString *)svgFontNameWithoutText;

@end
