//
// Created by huanghou  on 2017/8/1.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "NSURL+TDFFoundation.h"


@implementation NSURL (TDFFoundation)
+ (NSURL *)tdf_secureUrlWithString:(NSString *)string {
    if (!string) {
        return nil;
    }
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:string] resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    return components.URL;
}


@end