//
//  TDFResponseModel.m
//  Pods
//
//  Created by 於卓慧 on 6/18/16.
//
//

#import "TDFResponseModel.h"

NSString *const kNetworkErrorCode = @"errorCode";

@implementation TDFResponseModel

- (BOOL)isSuccess
{
    if (self.responseObject) {
        NSNumber *code = [self.responseObject objectForKey:@"code"];
        
        if ([code integerValue] == 0) {
            NSString *message = [self.responseObject objectForKey:@"message"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            userInfo[NSLocalizedDescriptionKey] = message;
            userInfo[kNetworkErrorCode] = self.responseObject[kNetworkErrorCode];
            self.error = [NSError errorWithDomain:kNetworkErrorDomain code:[code integerValue] userInfo:userInfo];
            return NO;
        } else {
            self.dataObject = [self.responseObject objectForKey:@"data"];
            return YES;
        }
    }
    
    if (!self.error) {
        self.error = [NSError errorWithDomain:kNetworkErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"返回对象为空", nil)}];
    }
    
    return NO;
}

@end
