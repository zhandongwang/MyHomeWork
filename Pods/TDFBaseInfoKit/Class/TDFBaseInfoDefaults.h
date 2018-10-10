//
//  TDFBaseInfoDefaults.h
//  Pods
//
//  Created by tripleCC on 2017/8/5.
//
//

#import <Foundation/Foundation.h>

#define TDF_BASE_INFO_FOR_KEY(key) \
({ \
id value = [TDFBaseInfoDefaults shared].key; \
NSAssert(value, @"%@ can not be nil, you should setup it in TDFBaseInfoDefaults init category.", @#key); \
value; \
})

#define TDF_BASE_C_INFO_FOR_KEY(key) [TDFBaseInfoDefaults shared].key

@protocol TDFBaseInfoDefaultsInitialProtocol <NSObject>
@required
- (void)initDefaultsInformation;
@end

@interface TDFBaseInfoDefaults : NSObject
@property (copy, nonatomic) NSString *wxAppId;
@property (copy, nonatomic) NSString *wxAppSecret;
@property (copy, nonatomic) NSString *jpushKey;
@property (copy, nonatomic) NSString *mapKey;
@property (copy, nonatomic) NSString *appApiKey;
@property (copy, nonatomic) NSString *appApiSecret;
@property (copy, nonatomic) NSString *appBossApiKey;
@property (copy, nonatomic) NSString *appBossApiSignKey;
@property (copy, nonatomic) NSString *appGWApiSignKey;
@property (copy, nonatomic) NSString *umanalyticsKey;
@property (copy, nonatomic) NSString *weixinAppId;
@property (copy, nonatomic) NSString *weixinAppSecret;
@property (copy, nonatomic) NSString *jpushAliasKey;
//@property (copy, nonatomic) NSString *sobotAppId;
//@property (copy, nonatomic) NSString *sobotAppKey;

@property (assign, nonatomic) NSInteger restAppIdentifier;
@property (assign, nonatomic) NSInteger supplyChainAppIdentifier;
@property (assign, nonatomic) NSInteger appIdentifier;
@property (assign, nonatomic) BOOL loginPodShouldHideOpenShopButton;


@property (copy, nonatomic) NSString *projectClusterRoot;
@property (copy, nonatomic) NSString *projectAPIRoot;
@property (copy, nonatomic) NSString *projectDmallAPI;
@property (copy, nonatomic) NSString *projectSupplyAPIRoot;
@property (copy, nonatomic) NSString *projectBossAPI;
@property (copy, nonatomic) NSString *projectGWAPI;
@property (copy, nonatomic) NSString *projectGwEnv;
@property (copy, nonatomic) NSString *projectIntegralAPI;
@property (copy, nonatomic) NSString *projectEnvelopeURL;
@property (copy, nonatomic) NSString *projectReportURL;
@property (copy, nonatomic) NSString *projectRerpServerURL;
@property (copy, nonatomic) NSString *projectKLoanURL;
@property (copy, nonatomic) NSString *projectImageFilePath;
@property (copy, nonatomic) NSString *projectImageOriginPath;
@property (copy, nonatomic) NSString *projectSupplyReportURL;
@property (copy, nonatomic) NSString *projectSupplyReportUrlExtend;
@property (copy, nonatomic) NSString *projectPurchaseShareURL;
@property (copy, nonatomic) NSString *projectPandoraReportURLRoot;
@property (copy, nonatomic) NSString *projectSupplyChainAPI;
//收款码H5页面
@property (copy, nonatomic) NSString *projectPaymentQRCodeURL;
@property (copy, nonatomic) NSString *celebiProjectId;
@property (copy, nonatomic) NSString *celebiAppId;
+ (instancetype)shared;
@end
