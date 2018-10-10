//
//  TDFDataCenter.m
//  TDFDataCenterKit
//
//  Created by 於卓慧 on 6/1/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import "TDFDataCenter.h"

@implementation TDFDataCenter

static TDFDataCenter *_sharedInstance = nil;

+ (instancetype)sharedInstance {
  
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    //because has rewrited allocWithZone  use NULL avoid endless loop .
    _sharedInstance = [[super allocWithZone:NULL] init];
  });
  
  return _sharedInstance;
}
#pragma mark - rewrite
+ (id)allocWithZone:(struct _NSZone *)zone
{
  return [TDFDataCenter sharedInstance];
}

+ (instancetype)alloc
{
  return [TDFDataCenter sharedInstance];
}

- (id)copy
{
  return self;
}

- (id)mutableCopy
{
  return self;
}

- (id)copyWithZone:(struct _NSZone *)zone
{
  return self;
}

- (TDFPlatfromType)platForm {
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    if(dic[@"AppTarget"] && [dic[@"AppTarget"] isEqualToString:@"KOUBEI"]) {
        return TDFPlatfromTypeKoubei;
    }
    return TDFPlatfromType2Dfire;
}

- (NSString *)versionServiceAppCode {
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    return dic[@"VersionServiceAppCode"]?:@"APP_CATERERS";
}

@end
