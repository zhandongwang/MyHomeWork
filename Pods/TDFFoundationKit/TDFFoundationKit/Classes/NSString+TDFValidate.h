//
// Created by huanghou  on 2017/6/27.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TDFValidate)
- (BOOL)tdf_isMobile;

- (BOOL)tdf_isNumeric;

- (BOOL)tdf_isAlpha;

- (BOOL)tdf_isAlphaOrNumeric;

-(BOOL)tdf_isIPAddress;
@end