//
//  TDFDNSResponseSerializer.h
//  TDFHTTPDNS
//
//  Created by Octree on 9/8/16.
//  Copyright © 2016年 Octree. All rights reserved.
//

#import "TDFDNSRecord.h"

@interface TDFDNSResponseSerializer : NSObject

- (NSArray<TDFDNSRecord *> *)dnsRecordsForResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error;

@end
