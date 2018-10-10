//
//  UILabel+AttributedText.m
//  Pods
//
//  Created by chaiweiwei on 2017/8/4.
//
//

#import "UILabel+AttributedText.h"

@implementation UILabel (AttributedText)

- (NSMutableAttributedString *)setupAttributedStringWithText:(NSString *)text {
    
    NSAttributedString *attributedString = [self.attributedText copy];
    
    if([attributedString.string isEqualToString:text]) {
        NSMutableAttributedString *newAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedString enumerateAttributesInRange:NSMakeRange(0, attributedString.string.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            [newAttributedString addAttributes:attrs range:range];
        }];
        return newAttributedString;
    }else {
        return [[NSMutableAttributedString alloc] initWithString:text];
    }
}

- (void)tdf_attributedFontText:(NSString *)text attributedText:(NSString *)attributedText attributedFontSize:(CGFloat)fontSize {
    
    NSMutableAttributedString *attributedString = [self setupAttributedStringWithText:text];
    
    if(attributedText.length > 0) {
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:[text rangeOfString:attributedText]];
    }
    self.attributedText = attributedString;
}

- (void)tdf_attributedFontText:(NSString *)text attributedText:(NSString *)attributedText attributedFontSize:(CGFloat)fontSize bold:(BOOL)isBold{
    
    NSMutableAttributedString *attributedString = [self setupAttributedStringWithText:text];
    
    if(attributedText.length > 0) {
        [attributedString addAttribute:NSFontAttributeName value:isBold?[UIFont boldSystemFontOfSize:fontSize]:[UIFont systemFontOfSize:fontSize] range:[text rangeOfString:attributedText]];
    }
    self.attributedText = attributedString;
}

- (void)tdf_attributedColorText:(NSString *)text attributedText:(NSString *)attributedText attributedColor:(UIColor *)color {
    
    NSMutableAttributedString *attributedString = [self setupAttributedStringWithText:text];
    
    if(attributedText.length > 0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:[text rangeOfString:attributedText]];
    }
    
    self.attributedText = attributedString;
}

- (void)tdf_attributedLineSpacingText:(NSString *)text attributedSpace:(CGFloat)space {
    
    NSMutableAttributedString *attributedString = [self setupAttributedStringWithText:text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
}

@end

