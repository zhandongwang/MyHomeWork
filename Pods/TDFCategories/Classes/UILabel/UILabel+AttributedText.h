//
//  UILabel+AttributedText.h
//  Pods
//
//  Created by chaiweiwei on 2017/8/4.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (AttributedText)

- (void)tdf_attributedFontText:(NSString *)text attributedText:(NSString *)attributedText attributedFontSize:(CGFloat)fontSize;
- (void)tdf_attributedFontText:(NSString *)text attributedText:(NSString *)attributedText attributedFontSize:(CGFloat)fontSize bold:(BOOL)isBold;
- (void)tdf_attributedColorText:(NSString *)text attributedText:(NSString *)attributedText attributedColor:(UIColor *)color;
- (void)tdf_attributedLineSpacingText:(NSString *)text attributedSpace:(CGFloat)space;

@end
