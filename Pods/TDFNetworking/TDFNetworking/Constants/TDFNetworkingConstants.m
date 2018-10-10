//
//  TDFNetworkingCoonstants.m
//  TDFNetworking
//
//  Created by 於卓慧 on 5/28/16.
//  Copyright © 2016 2dfire. All rights reserved.

#import "TDFNetworkingConstants.h"


#if DEBUG || defined(TDF_DEBUG)
#define kTDFHost @"2dfire-daily.com"

NSString * kTDFClusterRoot = @"http://10.1.6.140/zmcluster";

NSString * kTDFSupplyChainAPI = @"http://10.1.5.85:8080/supplychain-api";

NSString * kTDFDmallAPI = @"http://10.1.6.86:8080/dmall-api";

NSString * kTDFSupplyAPIRoot = @"http://10.1.6.85:8080/retail-api";

NSString * kTDFBossAPI = @"http://api.2dfire-daily.com/boss-api";

NSString * kTDFGWAPI = @"http://gateway.2dfire-daily.com";

NSString * kTDFGwEnv = @"daily";

NSString * kTDFIntegralAPI = @"http://10.1.7.98:8080/integral-api";

NSString * kTDFEnvelopeURL = @"http://weidian.2dfire.com/hongbao/receive.do?couponId=%ld";
NSString * kTDFReportURL = @"http://d.2dfire-daily.com/report/index.html?session_id=%@&shop_code=%@&shop_name=%@&entity_id=%@&request_url=%@&dev=debug&version=sso";
NSString * kTDFRerpServerURL = @"http://server.2dfire-daily.com/rerp4";

NSString * kTDFKLoanURL = @"%@?dianmianid=%@&dianmianname=%@&man=%@&phone=%@";
NSString * kTDFImageFilePath = @"http://ifiletest.2dfire.com";
NSString * kTDFImageOriginPath = @"http://zmfile.2dfire-daily.com";

NSString * kTDFSupplyReportURL = @"http://10.1.5.213/nginx/report/index.html?session_key=%@&session_id=%@&shop_code=%@&shop_name=%@&entity_id=%@&request_url=%@&dev=debug&identification_key=scm";
NSString * kTDFSupplyReportUrlExtend = @"&member_user_id=%@&plat_form_type=1";
NSString * kTDFPurchaseShareURL = @"http://api.l.whereask.com/share/hercules/page/share.html";
NSString * kTDFPandoraReportURLRoot = @"http://d.2dfire-daily.com/pandora/#";
NSString * kTDFPandoraHost  = @"pandora.2dfire-daily.com";
NSString * kTDFWebHost = @"http://api.l.whereask.com";
//商品预览
NSString * kTDFMenuPreviewHTML = @"https://api.l.whereask.com/detail_template_daily/om/page/preview_detail.html";
//商品模板
NSString * kTDFMenuTemplateURL = @"https://api.l.whereask.com/detail_template_daily/om/page/edit_detail.html";
NSString * kTDFPaymentQRCodeURL = @"http://api.l.whereask.com/qrcode_pay/file/page/payment-qrcode.html";
NSString *  kTDFTongHuaLoansURL = @"http://dev-weixin.allinpal.com:18090/2dfire/home";
NSString *  kTDFOrgCode = @"T00120171201001";
NSString * kTDFNearByMiniProgramesURL = @"http://api.l.whereask.com/daily/file/page/wxNearbyMiniProgrames.html";
NSString *kTDFWeixinOasisH5URL = @"http://10.1.29.19/nginx/hercules/page/oasis.html";
#else
#define kTDFHost @"2dfire.com"

NSString * const kTDFClusterRoot = @"https://cluster.2dfire.com";
NSString * const kTDFBossAPI = @"https://boss-api.2dfire.com";
NSString * const kTDFGWAPI = @"https://gateway.2dfire.com";
NSString * const kTDFGwEnv = @"publish";

NSString * const kTDFSupplyChainAPI = @"https://newapi.2dfire.com/supplychain-api";
NSString * const kTDFDmallAPI = @"https://newapi.2dfire.com/dmall-api";
NSString * const kTDFSupplyAPIRoot = @"https://retailapi.2dfire.com";       
NSString * const kTDFEnvelopeURL = @"http://weidian.2dfire.com/hongbao/receive.do?couponId=%ld";
NSString * const kTDFReportURL = @"http://d.2dfire.com/report/index.html?session_id=%@&shop_code=%@&shop_name=%@&entity_id=%@&request_url=%@&dev=release&version=sso";

NSString * const kTDFRerpServerURL = @"https://server.2dfire.com/rerp4";

NSString * const kTDFKLoanURL = @"%@?dianmianid=%@&dianmianname=%@&man=%@&phone=%@";
NSString * const kTDFImageFilePath = @"https://ifile.2dfire.com";
NSString * const kTDFImageOriginPath = @"http://rest3.zm1717.com";

NSString * const kTDFSupplyReportURL = @"http://d.2dfire.com/report/index.html?session_key=%@&session_id=%@&shop_code=%@&shop_name=%@&entity_id=%@&request_url=%@&dev=release&identification_key=scm";
NSString * const kTDFSupplyReportUrlExtend = @"&member_user_id=%@&plat_form_type=1";
NSString * const kTDFPurchaseShareURL = @"http://d.2dfire.com/hercules/page/share.html";

NSString * const kTDFPandoraReportURLRoot = @"https://d.2dfire.com/pandora/#";
NSString * const kTDFPandoraHost = @"pandora.2dfire.com";

NSString * const kTDFIntegralAPI = @"https://boss-api.2dfire.com/integral-api";
NSString * const kTDFWebHost = @"https://d.2dfire.com";
//商品预览
NSString * const kTDFMenuPreviewHTML = @"https://d.2dfire.com/om/page/preview_detail.html";
//商品模板
NSString * const kTDFMenuTemplateURL = @"https://d.2dfire.com/om/page/edit_detail.html";
NSString * const kTDFPaymentQRCodeURL = @"https://d.2dfire.com/file/page/payment-qrcode.html";

NSString * const kTDFTongHuaLoansURL = @"https://weixin.allinpal.com/2dfire/home";
NSString * const kTDFOrgCode = @"P00120171201001";
NSString * const kTDFNearByMiniProgramesURL = @"https://d.2dfire.com/file/page/wxNearbyMiniProgrames.html";
NSString * const kTDFWeixinOasisH5URL = @"http://d.2dfire.com/hercules/page/oasis.html";
#endif
