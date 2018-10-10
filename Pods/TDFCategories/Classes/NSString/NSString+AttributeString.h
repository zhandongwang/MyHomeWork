//
//  NSString+AttributeString.h
//  Test
//
//  Created by 黄河 on 2017/8/25.
//  Copyright © 2017年 LearnLibrary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributeString)

- (NSAttributedString *)tdf_toAttributedStringWithRange:(NSRange)range attributes:(NSDictionary *)attributes;

- (NSAttributedString *)tdf_toAttributedStringWithPlaceHolder:(NSString *)placeholder
                                                   replaceStr:(NSString *)replaceStr
                                                   attributes:(NSDictionary *)attributes;

@end
