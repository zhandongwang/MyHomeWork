//
// Created by huanghou  on 2017/5/18.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TDFFoundation)

- (NSString *)tdf_lowercaseFirstCharacter;

- (NSString *)tdf_uppercaseFirstCharacter;

- (BOOL)tdf_isNotEmpty;

- (NSString *)tdf_trim;

- (NSString *)tdf_trimTheExtraSpaces;

- (NSString *)tdf_escapeHTML;

- (NSString *)tdf_stringByDecodingXMLEntities;

- (NSString *)tdf_md5;

- (NSString *)tdf_md5ForUTF16;

- (NSMutableArray *)tdf_tokenizationStringByNSStringEnumerationOptions:(NSStringEnumerationOptions)opts;

- (NSString *)tdf_languageForString;

- (NSMutableArray *)tdf_analyseTextOfSentences;

+ (NSString *)tdf_formatFloatValue:(float)value;
@end
