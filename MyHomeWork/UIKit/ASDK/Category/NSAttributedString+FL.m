//
//  NSAttributedString+FL.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "NSAttributedString+FL.h"

@implementation NSAttributedString (FL)

+ (NSAttributedString *)createWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color{
    return [self createWithText:text Font:font Color:color Alignmant:NSTextAlignmentLeft];
    
}

+ (NSAttributedString *)createWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color Alignmant:(NSTextAlignment)alignment {
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.alignment = alignment;
    NSDictionary *dict = @{NSFontAttributeName: font,
                           NSForegroundColorAttributeName: color,
                           NSParagraphStyleAttributeName:style};
    return [[NSAttributedString alloc] initWithString:text attributes:dict];
}


@end
