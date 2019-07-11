//
// Created by huanghou  on 2017/5/18.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "NSString+TDFFoundation.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSString (TDFFoundation)
#pragma mark - 转换string大小写

- (NSString *)tdf_lowercaseFirstCharacter {
    NSRange  range                = NSMakeRange(0, 1);
    NSString *lowerFirstCharacter = [[self substringToIndex:1] lowercaseString];
    return [self stringByReplacingCharactersInRange:range withString:lowerFirstCharacter];
}

- (NSString *)tdf_uppercaseFirstCharacter {
    NSRange  range                = NSMakeRange(0, 1);
    NSString *upperFirstCharacter = [[self substringToIndex:1] uppercaseString];
    return [self stringByReplacingCharactersInRange:range withString:upperFirstCharacter];
}

#pragma mark - trim string

- (NSString *)tdf_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)tdf_trimTheExtraSpaces {
    NSCharacterSet *whitespaces    = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate    *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];

    NSArray *parts         = [self componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    return [filteredArray componentsJoinedByString:@" "];
}


//替换HTML代码
- (NSString *)tdf_escapeHTML {
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    [result replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'" withString:@"&#39;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    return result;
}

// implementation by Daniel Dickison and Walty
// http://stackoverflow.com/questions/1105169/html-character-decoding-in-objective-c-cocoa-touch
- (NSString *)tdf_stringByDecodingXMLEntities {
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;

    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];

    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];

    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];

    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL     gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";

            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            } else {
                gotNumber = [scanner scanInt:(int *) &charCode];
            }

            if (gotNumber) {
                [result appendFormat:@"%C", charCode];
                [scanner scanString:@";" intoString:NULL];
            } else {
                NSString *unknownEntity = @"";
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
        } else {
            NSString *amp;
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
        }
    } while (![scanner isAtEnd]);

    finish:
    return result;
}

//普通的MD5加密
- (NSString *)tdf_md5 {
    const char    *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

//UTF16的MD5加密
- (NSString *)tdf_md5ForUTF16 {
    NSData *temp = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding];

    UInt8 *cStr = (UInt8 *) [temp bytes];

    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, [temp length], result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}


#pragma mark - tokeniztion string

/**
 根据设定参数进行字符串拆分
 NSStringEnumerationByComposedCharacterSequences,根据字母
 NSStringEnumerationByWords，根据单词
 NSStringEnumerationBySentences，根据句子
 这3个比较常用
 */
- (NSMutableArray *)tdf_tokenizationStringByNSStringEnumerationOptions:(NSStringEnumerationOptions)opts {
    NSMutableArray *splitArray = [NSMutableArray array];
    NSRange        range       = NSMakeRange(0, [self length]);
    [self enumerateSubstringsInRange:range options:opts usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [splitArray addObject:substring];
    }];

    return splitArray;
}

//detect string language，对于句子相对准确，单词不是很准确
- (NSString *)tdf_languageForString {
    return (__bridge NSString *) CFStringTokenizerCopyBestStringLanguage((__bridge CFStringRef) self, CFRangeMake(0, (CFIndex) MIN(self.length, 400)));
}

+ (NSString *)tdf_formatFloatValue:(float)value {
    if (fmodf(value, 1) == 0) {
        return [@(value) stringValue];
    } else if (fmodf(value * 10, 1) == 0) {
        return [NSString stringWithFormat:@"%.1f", value];
    } else {
        return [NSString stringWithFormat:@"%.2f", value];
    }
}
@end

@implementation NSObject (TDFFoundation)
//是否是空字符串
- (BOOL)tdf_isNotEmpty {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    } else if ([self isKindOfClass:[NSString class]]) {
        NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString       *trimmed = [(NSString *) self stringByTrimmingCharactersInSet:charSet];
        return ![trimmed isEqualToString:@""];
    }
    return NO;
}
@end