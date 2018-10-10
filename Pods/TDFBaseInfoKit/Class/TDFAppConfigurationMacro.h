//
//  TDFAppConfigurationMacro.h
//  Pods
//
//  Created by tripleCC on 2017/8/3.
//
//

#ifndef TDFAppConfigurationMacro_h
#define TDFAppConfigurationMacro_h

#import "TDFBaseInfoDefaults.h"

#define WX_APP_ID               TDF_BASE_INFO_FOR_KEY(wxAppId)
#define WX_APP_SSECRET          TDF_BASE_INFO_FOR_KEY(wxAppSecret)
#define JPUSH_KEY               TDF_BASE_INFO_FOR_KEY(jpushKey)
#define MAP_KEY                 TDF_BASE_INFO_FOR_KEY(mapKey)
#define APP_API_KEY             TDF_BASE_INFO_FOR_KEY(appApiKey)
#define APP_API_SECRET          TDF_BASE_INFO_FOR_KEY(appApiSecret)
#define APP_BOSS_API_KEY        TDF_BASE_INFO_FOR_KEY(appBossApiKey)
#define APP_BOSS_API_SIGNKEY    TDF_BASE_INFO_FOR_KEY(appBossApiSignKey)
#define APP_GW_API_SIGNKEY      TDF_BASE_INFO_FOR_KEY(appGWApiSignKey)
#define UMANALYTICS_KEY         TDF_BASE_INFO_FOR_KEY(umanalyticsKey)
#define WEIXIN_AppId            TDF_BASE_INFO_FOR_KEY(weixinAppId)
#define WEIXIN_AppSecret        TDF_BASE_INFO_FOR_KEY(weixinAppSecret)
#define kTDFJPushAliasKey       TDF_BASE_INFO_FOR_KEY(jpushAliasKey)
#define SOBOT_APP_ID            TDF_BASE_INFO_FOR_KEY(sobotAppId)
#define SOBOT_APP_KEY           TDF_BASE_INFO_FOR_KEY(sobotAppKey)

//==========================================
//         这种东西，应该尽量避免创建的。。。
//==========================================
#define kTDFRestAppIdentifier 1
#define kTDFSupplyChainAppIdentifier 2
#define TDFAPPIdentifier        TDF_BASE_C_INFO_FOR_KEY(appIdentifier)
#define TDFLoginPodShouldHideOpenShopButton TDF_BASE_C_INFO_FOR_KEY(loginPodShouldHideOpenShopButton)

#endif /* TDFAppConfigurationMacro_h */
