//
//  TDFDNSPodResponseSerializer.m
//  TDFHTTPDNS
//
//  Created by Octree on 9/8/16.
//  Copyright © 2016年 Octree. All rights reserved.
//

#import "TDFDNSPodResponseSerializer.h"

@implementation TDFDNSPodResponseSerializer

- (NSArray<TDFDNSRecord *> *)dnsRecordsForResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error {

    if (error) {
        
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *arr = [string componentsSeparatedByString:@","];
    NSMutableArray *records = [NSMutableArray array];
    
    if (arr.count > 1) {
        
        NSArray *ips = [[arr firstObject] componentsSeparatedByString:@";"];
        NSInteger ttl = [[arr objectAtIndex:1] integerValue];
        if (ttl > 0) {
            
            for (NSString *ip in ips) {
                
                [records addObject:[[TDFDNSRecord alloc] initWithValue:ip
                                                                   ttl:ttl]];
            }
        }
    }
    
    return records;
}

@end
