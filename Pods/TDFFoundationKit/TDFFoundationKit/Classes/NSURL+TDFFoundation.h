//
// Created by huanghou  on 2017/8/1.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (TDFFoundation)
/**
 * 根据字符串返回对应的https连接
 * @param string url的字符串，可以是http或者https
 * @return
 */
+ (NSURL *)tdf_secureUrlWithString:(NSString *)string;
@end