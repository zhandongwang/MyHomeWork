//
//  TDFResponseModel.h
//  Pods
//
//  Created by 於卓慧 on 6/18/16.
//
//

#import <Foundation/Foundation.h>

static NSString *kNetworkErrorDomain = @"kNetworkErrorDomain";
CF_EXPORT NSString *const kNetworkErrorCode;

@interface TDFResponseModel : NSObject

@property (nonatomic, strong) NSError *error;

@property (nonatomic, strong) id responseObject;

@property (nonatomic, strong) id dataObject;

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

- (BOOL)isSuccess;

@end
