//
//  UIColor+Hex.m
//  RestApp
//
//  Created by xueyu on 16/4/12.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+(UIColor *)colorWithHeX:(long)hexColor{
    return [UIColor colorWithHeX:hexColor alpha:1.0f];
}

+(UIColor *)colorWithHeX:(long)hexColor alpha:(float)alpha{
    float red = ((float)((hexColor &0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor &0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor &0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [UIColor colorWithHexString:color alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
    
}

+ (UIColor *)colorWithARGBHexString:(NSString *)color {
    if (color.length < 6) {
        return [UIColor clearColor];
    }
    NSString *cString = [color uppercaseString];
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if (cString.length == 6 || cString.length == 8) {
        unsigned int a = 255;
        NSRange range;
        range.length = 2;
        if (cString.length == 8) {
            range.location = 0;
            NSString *aString = [cString substringWithRange:range];
            [[NSScanner scannerWithString:aString] scanHexInt:&a];
            cString = [cString substringFromIndex:2];
        }
        
        range.location = 0;
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)];
    }
    
    return [UIColor clearColor];
}


+ (UIColor *)colorWithRGBAHexString:(NSString *)color {
    if (color.length < 6) {
        return [UIColor clearColor];
    }
    NSString *cString = [color uppercaseString];
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if (cString.length == 8 || cString.length == 6) {
        NSRange range;
        range.length = 2;
        range.location = 0;
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        unsigned int a = 255;
        if (cString.length == 8) {
            range.location = 6;
            NSString *aString = [cString substringWithRange:range];
            [[NSScanner scannerWithString:aString] scanHexInt:&a];
        }
        
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)];
    }
    
    return [UIColor clearColor];
}

@end
