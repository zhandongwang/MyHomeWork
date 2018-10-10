//
//  TDFTwoDFireHTTPDNSResponseSerializer.m
//  TDFHTTPDNS
//
//  Created by 於卓慧 on 16/9/1.
//  Copyright © 2016年 Octree. All rights reserved.
//

#import "TDFTwoDFireHTTPDNSResponseSerializer.h"
#import "TDFDNSRecord.h"
#import <TDFSecurityKit/TDFSecurityKit.h>

@implementation TDFTwoDFireHTTPDNSResponseSerializer

- (NSArray<TDFDNSRecord *> *)dnsRecordsForResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error {
    
    NSData *decryptedData = [TDFSecurityCryptor decryptHTTPDNS:data error:&error];
    
    if (decryptedData) {
        NSDictionary *jsonInfo = [NSJSONSerialization JSONObjectWithData:decryptedData options:0 error:&error];
        
        if (jsonInfo) {
            // {"c":200,"ip":"120.55.199.20","host":"api.2dfire.com","ttl":300}
            int code = [jsonInfo[@"c"] intValue];
            NSString *ip = jsonInfo[@"ip"];
            NSString *host = jsonInfo[@"host"];
            int ttl = [jsonInfo[@"ttl"] intValue];
            
            if (code == 200 && ip.length > 0 && host.length > 0 && ttl > 0) {
                TDFDNSRecord *dnsRecord = [[TDFDNSRecord alloc] initWithValue:ip ttl:ttl];
                
                return @[dnsRecord];
            }
        }
    }
    
    
    return nil;
}

@end
