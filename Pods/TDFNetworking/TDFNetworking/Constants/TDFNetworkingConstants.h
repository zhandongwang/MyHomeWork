//
//  TDFConstants.h
//  TDFNetworking
//
//  Created by 於卓慧 on 5/6/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

#if DEBUG || defined(TDF_DEBUG)

FOUNDATION_EXPORT NSString * kTDFClusterRoot;
FOUNDATION_EXPORT NSString * kTDFBossAPI;
FOUNDATION_EXPORT NSString * kTDFGWAPI;
FOUNDATION_EXPORT NSString * kTDFGwEnv;
FOUNDATION_EXPORT NSString * kTDFSupplyChainAPI;
FOUNDATION_EXPORT NSString * kTDFDmallAPI;
FOUNDATION_EXPORT NSString * kTDFSupplyAPIRoot;
FOUNDATION_EXPORT NSString * kTDFEnvelopeURL;
FOUNDATION_EXPORT NSString * kTDFReportURL;
FOUNDATION_EXPORT NSString * kTDFRerpServerURL;
FOUNDATION_EXPORT NSString * kTDFKLoanURL;
FOUNDATION_EXPORT NSString * kTDFImageFilePath;
FOUNDATION_EXPORT NSString * kTDFImageOriginPath;
FOUNDATION_EXPORT NSString * kTDFPandoraReportURLRoot;
FOUNDATION_EXPORT NSString * kTDFPandoraHost;
FOUNDATION_EXPORT NSString * kTDFWebHost;
//商品预览
FOUNDATION_EXPORT NSString * kTDFMenuPreviewHTML;
//商品模板
FOUNDATION_EXPORT NSString * kTDFMenuTemplateURL;
FOUNDATION_EXPORT NSString * kTDFPaymentQRCodeURL;

//商家小程序====附近的小程序设置
FOUNDATION_EXPORT NSString * kTDFNearByMiniProgramesURL;

//积分兑换设置-小二积分设置服务器
FOUNDATION_EXPORT NSString * kTDFIntegralAPI;

//供应链表报
FOUNDATION_EXPORT NSString * kTDFSupplyReportURL;
//选店时总部切门店时报表多加参数，往urlFormat2后面拼接
FOUNDATION_EXPORT NSString * kTDFSupplyReportUrlExtend;
//采购单分享h5页面
FOUNDATION_EXPORT NSString * kTDFPurchaseShareURL;

//通联火融E
FOUNDATION_EXPORT NSString * kTDFTongHuaLoansURL;//二维火跳转链接
FOUNDATION_EXPORT NSString * kTDFOrgCode;//机构码

//微信支付优惠费率申请模块 绿洲
FOUNDATION_EXPORT NSString *kTDFWeixinOasisH5URL;


//FOUNDATION_EXPORT NSString * const kTDFProjectClusterRoot;
//FOUNDATION_EXPORT NSString * const kTDFProjectAPIRoot;
//FOUNDATION_EXPORT NSString * const kTDFProjectBossAPI;
//FOUNDATION_EXPORT NSString * const kTDFProjectGWAPI;
//FOUNDATION_EXPORT NSString * const kTDFProjectGwEnv;
//FOUNDATION_EXPORT NSString * const kTDFProjectSupplyChainAPI;
//FOUNDATION_EXPORT NSString * const kTDFProjectDmallAPI;
//FOUNDATION_EXPORT NSString * const kTDFProjectSupplyAPIRoot;
//FOUNDATION_EXPORT NSString * const kTDFProjectEnvelopeURL;
//FOUNDATION_EXPORT NSString * const kTDFProjectReportURL;
//FOUNDATION_EXPORT NSString * const kTDFProjectRerpServerURL;
//FOUNDATION_EXPORT NSString * const kTDFProjectKLoanURL;
//FOUNDATION_EXPORT NSString * const kTDFProjectImageFilePath;
//FOUNDATION_EXPORT NSString * const kTDFProjectImageOriginPath;
//FOUNDATION_EXPORT NSString * const kTDFProjectPandoraReportURLRoot;
//FOUNDATION_EXPORT NSString * const kTDFProjectIntegralAPI;
//
////供应链表报
//FOUNDATION_EXPORT NSString * const kTDFProjectSupplyReportURL;
////选店时总部切门店时报表多加参数，往urlFormat2后面拼接
//FOUNDATION_EXPORT NSString * const kTDFProjectSupplyReportUrlExtend;
////采购单分享h5页面
//FOUNDATION_EXPORT NSString * const kTDFProjectPurchaseShareURL;
#else
FOUNDATION_EXPORT NSString * const kTDFClusterRoot;
FOUNDATION_EXPORT NSString * const kTDFBossAPI;
FOUNDATION_EXPORT NSString * const kTDFGWAPI;
FOUNDATION_EXPORT NSString * const kTDFGwEnv;
FOUNDATION_EXPORT NSString * const kTDFSupplyChainAPI;
FOUNDATION_EXPORT NSString * const kTDFDmallAPI;
FOUNDATION_EXPORT NSString * const kTDFSupplyAPIRoot;
FOUNDATION_EXPORT NSString * const kTDFEnvelopeURL;
FOUNDATION_EXPORT NSString * const kTDFReportURL;
FOUNDATION_EXPORT NSString * const kTDFRerpServerURL;
FOUNDATION_EXPORT NSString * const kTDFKLoanURL;
FOUNDATION_EXPORT NSString * const kTDFImageFilePath;
FOUNDATION_EXPORT NSString * const kTDFImageOriginPath;

//积分兑换设置-小二积分设置服务器
FOUNDATION_EXPORT NSString * const kTDFIntegralAPI;

//供应链表报
FOUNDATION_EXPORT NSString * const kTDFSupplyReportURL;
//选店时总部切门店时报表多加参数，往urlFormat2后面拼接
FOUNDATION_EXPORT NSString * const kTDFSupplyReportUrlExtend;
//采购单分享h5页面
FOUNDATION_EXPORT NSString * const kTDFPurchaseShareURL;

//新报表的HOST
FOUNDATION_EXPORT NSString * const kTDFPandoraReportURLRoot;
FOUNDATION_EXPORT NSString * const kTDFPandoraHost;
FOUNDATION_EXPORT NSString * const kTDFWebHost;
//商品预览
FOUNDATION_EXPORT NSString * const kTDFMenuPreviewHTML;
//商品模板
FOUNDATION_EXPORT NSString * const kTDFMenuTemplateURL;
FOUNDATION_EXPORT NSString * const kTDFPaymentQRCodeURL;

//通联火融E
FOUNDATION_EXPORT NSString * const kTDFTongHuaLoansURL;//二维火跳转链接
FOUNDATION_EXPORT NSString * const kTDFOrgCode;//机构码

//商家小程序====附近的小程序设置
FOUNDATION_EXPORT NSString * const kTDFNearByMiniProgramesURL;

FOUNDATION_EXPORT NSString * const kTDFWeixinOasisH5URL;

#endif
