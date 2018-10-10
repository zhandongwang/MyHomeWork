//
//  TDFPasswordUtil.h
//  TDFOldBaseUtil
//
//  Created by tripleCC on 2017/11/2.
//

#import <Foundation/Foundation.h>

@interface TDFPasswordUtil : NSObject

+ (NSString *)validatePassword:(NSString *)password;
/**
 校验密码

 @param new 新
 @param confirm 确认
 @return 错误信息
 */
+ (NSString *)validateNewPassword:(NSString *)new confirmPassword:(NSString *)confirm;
@end
