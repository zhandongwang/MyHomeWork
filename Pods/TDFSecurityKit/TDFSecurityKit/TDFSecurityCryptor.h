//
//  TDFSecurityCryptor.h
//  TDFSecurityKit
//
//  Created by 於卓慧 on 16/8/30.
//  Copyright © 2016年 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDFSecurityCryptor : NSObject

+ (NSData *)decryptHTTPDNS:(NSData *)data error:(NSError **)error;

@end