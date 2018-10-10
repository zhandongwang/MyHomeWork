//
//  TDFHTTPProxyProtocol.h
//  Pods
//
//  Created by doubanjiang on 2018/4/24.
//

#import <Foundation/Foundation.h>

@class TDFRequestModel;
@class TDFResponseModel;

@protocol TDFHTTPProxyProtocol <NSObject>

@required

NS_ASSUME_NONNULL_BEGIN
/**
 在签名发送请求之前执行

 @param requestObject request
 */
- (void)beforeRequestSendWithRequestObject:(__kindof TDFRequestModel *)requestObject;

/**
 网络请求回调后执行

 @param response 响应对象
 @param requestObject request
 @return 是否继续回调
 */
- (BOOL)shouldContinueResponse:(TDFResponseModel *)response
             withRequestObject:(TDFRequestModel *)requestObject;


/**
 请求失败之后执行

 @param response response
 @param requestObject request
 */
- (void)requestFailWithResponse:(TDFResponseModel *)response
              withRequestObject:(TDFRequestModel *)requestObject;

@end
NS_ASSUME_NONNULL_END
