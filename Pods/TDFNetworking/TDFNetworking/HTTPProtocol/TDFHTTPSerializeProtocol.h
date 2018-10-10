//
//  TDFHTTPSerializeProtocol.h
//  Pods
//
//  Created by doubanjiang on 2018/5/8.
//

#import <Foundation/Foundation.h>

@class TDFRequestModel;

@protocol TDFHTTPSerializeProtocol <NSObject>

@required
NS_ASSUME_NONNULL_BEGIN
/**
 添加默认请求参数，用于拼接链接
 
 @param request requestModel
 @return dic
 */
- (NSDictionary<NSString *,NSString *> *)tdf_defaultGETParamsWithRequest:(TDFRequestModel *)request;

/**
 添加请求Header
 
 @param request requestModel
 @return dic
 */
- (NSDictionary<NSString *,NSString *> *)tdf_HTTPHeaderFieldWithRequest:(TDFRequestModel *)request;

/**
 根据传入的model与请求默认GET参数获取URL

 @param request requestModel
 @param defaultGETParams defaultGETParams
 @return URL
 */
- (NSString *)tdf_URLWithRequest:(TDFRequestModel *)request
                defaultGETParams:(NSDictionary<NSString *,NSString *> *)defaultGETParams;

/**
 添加默认业务参数
 
 @param request requestModel
 @return dic
 */
- (NSDictionary<NSString *,NSString *> *)tdf_defaultParamsWithRequest:(TDFRequestModel *)request;

/**
 业务请求参数
 
 @param request requestModel
 @return dic
 */
- (NSDictionary<NSString *,NSString *> *)tdf_paramsWithRequest:(TDFRequestModel *)request;

/**
 添加签名，对参数签名后将作为字段@"sign"将加入业务参数
 
 @param request requestModel
 @return sign
 */
- (NSString *)tdf_signWithRequest:(TDFRequestModel *)request
                       parameters:(NSDictionary<NSString *,NSString *> *)parameters
                              URL:(NSString *)URL;
@end
NS_ASSUME_NONNULL_END
