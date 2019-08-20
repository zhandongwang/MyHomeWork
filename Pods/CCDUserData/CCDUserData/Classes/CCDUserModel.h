//
//	CCDUserModel.h
//
//	Create by huang hou on 31/3/2017
//	Copyright © 2017 2dfire. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCDIndustry) {
    CCDIndustryRest = 0,         // 餐饮行业 0代表餐饮 这个值不允许更改是服务端决定的
    CCDIndustryRetail = 3,            // 零售行业 3代表零售 这个值不允许更改是服务端决定的
    CCDIndustryNewRetail = 1,            // 新零售行业 3代表新零售 这个值不允许更改是服务端决定的
};

@interface CCDUserModel : NSObject 

@property(nonatomic, copy) NSString *entityId;
@property(nonatomic, copy) NSString *userId;
//用户与与员工关联id
@property(nonatomic, copy) NSString *memberUserId;
@property(nonatomic, copy) NSString *memberId;
@property(nonatomic, assign) BOOL hasPantry;//是否有传菜方案
@property(nonatomic, copy) NSString *memberName;
@property(nonatomic, copy) NSString *mobile;
//职级名称
@property(nonatomic, copy) NSString *roleName;
@property(nonatomic, copy) NSString *sex;
@property(nonatomic, copy) NSString *shopCode;
@property(nonatomic, copy) NSString *shopName;
//开始工作状态
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *avatarUrl;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSDictionary *addition;
// 店铺实体类型 1:普通门店 2:连锁 3:分公司
@property (nonatomic, assign) NSInteger shopEntityType;
@property (nonatomic, assign, readonly) BOOL isNormalEntity;
@property (nonatomic, assign, readonly) BOOL isSingleShop;
//店铺语言
@property(nonatomic, copy) NSString *lang;

/**
 工作状态
 */
@property (nonatomic, assign) BOOL isWorkState;
//是否开启过云收银
@property (nonatomic, assign) BOOL hasOpenCloudCash;

/**
试用店铺是否已经过期
 */
@property (nonatomic, assign) BOOL isTrailShopExpired;

/**
 是否是试用店铺
 */
@property (nonatomic, strong) NSNumber *trialShop;
//当前货币符号
@property (nonatomic, copy) NSString *currencySymbol;

/**
 行业类型
 CCDIndustryRest 餐饮行业
 CCDIndustryRetail 零售行业
 */
@property (nonatomic, assign) CCDIndustry industry;

//国家id
@property(nonatomic, copy) NSString *countryId;

/**
 供应链那边不同的店有不同权限，一些操作如果是超管的话都不做权限校验
 1：超管
 */
@property (nonatomic, assign) NSInteger isSuper;
/**
 * 门店连锁实体ID
 */
@property (nonatomic, strong) NSString *brandEntityId;

@end
