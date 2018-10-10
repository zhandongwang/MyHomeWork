//
//  TDFPasswordUtil.m
//  TDFOldBaseUtil
//
//  Created by tripleCC on 2017/11/2.
//

#import "TDFPasswordUtil.h"

@implementation TDFPasswordUtil
+ (NSString *)validateNewPassword:(NSString *)new confirmPassword:(NSString *)confirm {
    if (!new.length) {
        return NSLocalizedString(@"新密码不能为空哦!", nil);
    }
    
    NSString *result = [self validatePassword:new];
    if (result) {
        return result;
    }
    
    if (!confirm.length) {
        return NSLocalizedString(@"确认密码不能为空哦!", nil);
    }
    
    if (![new isEqualToString:confirm]) {
        return NSLocalizedString(@"您两次输入的密码不一致，请仔细检查！", nil);
    }
    return nil;
}

+ (NSString *)validatePassword:(NSString *)password {
    if ([self isMatchPattern:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$" withObject:password]) {
        return nil;
    }
    
    return NSLocalizedString(@"请输入6-20位字母、数字组合的密码！", nil);
}

+ (BOOL)isMatchPattern:(NSString *)pattern withObject:(id)object {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:object];
    return isMatch;
}
@end
