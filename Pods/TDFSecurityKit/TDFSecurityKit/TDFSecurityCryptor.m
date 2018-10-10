//
//  TDFSecurityCryptor.m
//  TDFSecurityKit
//
//  Created by 於卓慧 on 16/8/30.
//  Copyright © 2016年 2dfire. All rights reserved.
//

#import "TDFSecurityCryptor.h"
#import <CommonCrypto/CommonCryptor.h>

#define XOR_KEY 0xBB

void xorString(unsigned char *str, unsigned char key) {
    unsigned char *p = str;
    while( ((*p) ^=  key) != '\0')  p++;
}

unsigned char * HTTPDNSKey() {
    unsigned char str[] = {
        (XOR_KEY ^ 'E'),
        (XOR_KEY ^ 'R'),
        (XOR_KEY ^ 'I'),
        (XOR_KEY ^ 'F'),
        (XOR_KEY ^ 'D'),
        (XOR_KEY ^ 'O'),
        (XOR_KEY ^ 'U'),
        (XOR_KEY ^ 'H'),
        (XOR_KEY ^ '\0')};
    xorString(str, XOR_KEY);
    static unsigned char result[9];
    memcpy(result, str, 9);
    
    return result;
}

@implementation TDFSecurityCryptor

+ (NSData *)decryptHTTPDNS:(NSData *)data error:(NSError **)error {
    
    unsigned char * key = HTTPDNSKey();
    NSData *keyData = [[NSData alloc] initWithBytes:key length:sizeof(key)];
    
    NSParameterAssert(data);
    
    data = [[NSData alloc] initWithBase64EncodedData:data options:0];
    
    size_t outLength;
    
    NSAssert(keyData.length == kCCKeySizeDES, @"the keyData is an invalid size");
    
    NSMutableData *outputData = [NSMutableData dataWithLength:(data.length + kCCBlockSizeDES)];
    
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt,
                                     kCCAlgorithmDES,
                                     kCCOptionPKCS7Padding,
                                     keyData.bytes,
                                     keyData.length,
                                     key,
                                     data.bytes,
                                     data.length,
                                     outputData.mutableBytes,
                                     outputData.length,
                                     &outLength);
    
    if (result != kCCSuccess) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:@"com.2dfire.TDFSecurityKey.Cryptor"
                                         code:result
                                     userInfo:nil];
        }
        
        return nil;
    }
    
    [outputData setLength:outLength];
    
    return [outputData copy];
}

@end