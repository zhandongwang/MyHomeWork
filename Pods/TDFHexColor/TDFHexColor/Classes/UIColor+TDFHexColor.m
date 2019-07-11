//
// Created by huanghou  on 2017/5/5.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "UIColor+TDFHexColor.h"


@implementation UIColor (TDFHexColor)
+ (UIColor *)tdf_colorWithHex:(int)hex {
    return [self tdf_colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)tdf_colorWithHex:(int)hex alpha:(CGFloat)alpha {
    int r = (hex >> 16) & 255;
    int g = (hex >> 8) & 255;
    int b = hex & 255;

    float rf = (float) r / 255.0f;
    float gf = (float) g / 255.0f;
    float bf = (float) b / 255.0f;

    return [UIColor colorWithRed:rf green:gf blue:bf alpha:alpha];
}

+ (UIColor *)tdf_random {
    CGFloat hue = (arc4random() % 256 / 256.0);  //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 64 / 256.0);  //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *)tdf_colorWithHexString:(NSString *)hexString {
    return [self tdf_colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)tdf_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    UIColor *color = nil;

    if (hexString.length == 0) {
        return [UIColor whiteColor];
    }

    if ('#' != [hexString characterAtIndex:0]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }


    if (hexString.length == 7 || hexString.length == 4) {
        hexString = [self hexStringTransformFromThreeCharacters:hexString];

        NSString *redHex = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
        unsigned redInt = [self hexValueToUnsigned:redHex];

        NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
        unsigned greenInt = [self hexValueToUnsigned:greenHex];

        NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
        unsigned blueInt = [self hexValueToUnsigned:blueHex];

        color = [UIColor colorWithRed:redInt / 255.0 green:greenInt / 255.0 blue:blueInt / 255.0 alpha:alpha];
    } else {
        color = [UIColor whiteColor];
    }

    return color;
}


#pragma mark - private methods

+ (NSString *)hexStringTransformFromThreeCharacters:(NSString *)hexString {
    if (hexString.length == 4) {
        hexString = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                                               [hexString substringWithRange:NSMakeRange(1, 1)], [hexString substringWithRange:NSMakeRange(1, 1)],
                                               [hexString substringWithRange:NSMakeRange(2, 1)], [hexString substringWithRange:NSMakeRange(2, 1)],
                                               [hexString substringWithRange:NSMakeRange(3, 1)], [hexString substringWithRange:NSMakeRange(3, 1)]];
    }

    return hexString;
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue {
    unsigned value = 0;

    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];

    return value;
}
@end