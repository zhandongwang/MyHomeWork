//
//	CCDUserModel.m
//
//	Create by huang hou on 31/3/2017
//	Copyright © 2017 2dfire. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CCDUserModel.h"

NSString *const kCCDUserModelEntityId = @"entityId";
NSString *const kCCDUserModelHasPantry = @"hasPantry";
NSString *const kCCDUserModelMemberId = @"memberId";
NSString *const kCCDUserModelMemberName = @"memberName";
NSString *const kCCDUserModelMemberUserId = @"memberUserId";
NSString *const kCCDUserModelMobile = @"mobile";
NSString *const kCCDUserModelRoleName = @"roleName";
NSString *const kCCDUserModelSex = @"sex";
NSString *const kCCDUserModelShopCode = @"shopCode";
NSString *const kCCDUserModelShopName = @"shopName";
NSString *const kCCDUserModelStatus = @"status";
NSString *const kCCDUserModelToken = @"token";
NSString *const kCCDUserModelUserId = @"userId";
NSString *const kCCDUserModelUserName = @"userName";

@interface CCDUserModel ()

@end

@implementation CCDUserModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
            @"avatarUrl": @[@"picFullPath",@"avatarUrl"],
            @"isSuper": @"isSupper",
    };
}

- (BOOL)isNormalEntity {
    return self.shopEntityType == 1;
}
-(BOOL)isSingleShop{
    return self.shopEntityType == 1 && ([self.brandEntityId isEqualToString:@""] || !self.brandEntityId);
}

- (NSString *)entityId {
    if (_entityId){
        return _entityId;
    }
    return @"";
}

- (NSString *)userId {
    if (_userId){
        return _userId;
    }
    return @"";
}

- (NSString *)currencySymbol {
    if (_currencySymbol){
        return _currencySymbol;
    }
    return @"";
}

@end
