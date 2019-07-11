//
// Created by huanghou  on 2017/5/5.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (TDFHexColor)

/**
 * 根据hex值生成颜色
 * @param hex 十六进制的颜色编码，例如0xffffff
 * @return 颜色
 */
+ (UIColor *)tdf_colorWithHex:(int)hex;

/**
 * 根据hex值和alpha值生成
 * @param hex 十六进制的颜色编码，例如0xffffff
 * @param alpha 透明度，从0到1.0f
 * @return 颜色
 */
+ (UIColor *)tdf_colorWithHex:(int)hex alpha:(CGFloat)alpha;

/**
 * 随机生成一个颜色
 * @return 颜色
 */
+ (UIColor *)tdf_random;

/**
 *
 * @param hexString 十六进制的字符串形式的颜色，例如@"0xffffff"
 * @return 颜色
 */
+ (UIColor *)tdf_colorWithHexString:(NSString *)hexString;

/**
 *
 * @param hexString 十六进制的字符串形式的颜色，例如@"0xffffff"
 * @param alpha 透明度 从0到1.0f
 * @return 颜色
 */
+ (UIColor *)tdf_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end