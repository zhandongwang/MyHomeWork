//
//  NSString+AttributeString.m
//  Test
//
//  Created by 黄河 on 2017/8/25.
//  Copyright © 2017年 LearnLibrary. All rights reserved.
//

#import "NSString+AttributeString.h"

@implementation NSString (AttributeString)

- (NSAttributedString *)tdf_toAttributedStringWithRange:(NSRange)range attributes:(NSDictionary *)attributes {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self];
    if (range.location + range.length <= self.length) {
        [string addAttributes:attributes range:range];
    }
    return string;
}

- (NSAttributedString *)tdf_toAttributedStringWithPlaceHolder:(NSString *)placeholder
                                                   replaceStr:(NSString *)replaceStr
                                                   attributes:(NSDictionary *)attributes {
    if ([self containsString:placeholder]) {
        NSArray *stringArray = [self componentsSeparatedByString:placeholder];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
        for (int i = 0; i < stringArray.count ; i ++) {
            NSString *str = stringArray[i];
            [attributeString appendAttributedString:[[NSAttributedString alloc] initWithString:str]];
            
            if (i != stringArray.count - 1) {
                [attributeString appendAttributedString:[[NSAttributedString alloc] initWithString:replaceStr attributes:attributes]];
            }
        }
        return attributeString;
    }
    return [[NSAttributedString alloc] initWithString:[self stringByReplacingOccurrencesOfString:placeholder withString:replaceStr]];
}

@end
