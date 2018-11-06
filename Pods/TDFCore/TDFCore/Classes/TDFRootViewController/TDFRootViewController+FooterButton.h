//
//  TDFRootViewController+FooterButton.h
//  RestApp
//
//  Created by happyo on 16/9/9.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import "TDFRootViewController.h"
#import <TDFAdaptationKit/TDFAdaptationKit.h>

#define TDFFooterButtonSize 55.0f
#define TDFFooterButtonsLeftOffset 8.0f
#define TDFFooterButtonsHorizontalOffset 10.0f
#define biPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f  ? YES : NO )
#define TDFFooterButtonsOriginY  (biPhoneX ? ([UIScreen mainScreen].bounds.size.height - TDFFooterButtonSize - 100.0f):([UIScreen mainScreen].bounds.size.height - TDFFooterButtonSize - 72.0f))
UIImage *kTDFFooterImageWithName(NSString *name);
typedef NS_OPTIONS(NSUInteger, TDFFooterButtonTypes) {
    TDFFooterButtonTypeNone = 0,
    TDFFooterButtonTypeExport = 1 << 0,
    TDFFooterButtonTypeBatch = 1 << 1,
    TDFFooterButtonTypeAdd = 1 << 2,
    TDFFooterButtonTypeHelp = 1 << 3,
    TDFFooterButtonTypeAllCheck = 1 << 4,
    TDFFooterButtonTypeNotAllCheck = 1 << 5,
    TDFFooterButtonTypeScan = 1 << 6,
    TDFFooterButtonTypeUploading = 1 << 7,
    TDFFooterButtonTypeImport = 1 << 8,
    TDFFooterButtonTypeSort = 1 << 9,
    TDFFooterButtonTypePick = 1 << 10,
    TDFFooterButtonTypeCentralizePurchase = 1 << 11,
    TDFFooterButtonTypeSearch = 1 << 12,
    TDFFooterButtonTypeEmail = 1 << 13,
    TDFFooterButtonTypePrint = 1 << 14,
    TDFFooterButtonTypeSendMessage = 1 << 15,
	TDFFooterButtonTypeOther = 1 << 16,
    TDFFooterButtonTypePrintBill = 1 << 17,
    TDFFooterButtonTypesBatchIssue = 1 << 18,
    TDFFooterButtonTypeAddShop = 1 << 19,
    TDFFooterButtonTypeShopCardToChain = 1 << 20,
    TDFFooterButtonTypeCostPriceList = 1 << 21,
    TDFFooterButtonTypeDocumentTemplate = 1 << 22,
    TDFFooterButtonTypeConfirmPurchase = 1 << 23,
    TDFFooterButtonTyoesStatementRecord =1 <<24 ,
    TDFFooterButtonTypeBatchRenewal =1 << 25 ,
    TDFFooterButtonTypeBuyField =1 << 26 ,
    TDFFooterButtonTypeVideoRecording =1 << 27,
    TDFFooterButtonTypeRepayment = 1 << 28,                         //还款
    TDFFooterButtonTypeMemoLibrary = 1 << 29,                       //备注库管理
    TDFFooterButtonTypeFeedLibrary = 1 << 30,                       //加料库管理
    TDFFooterButtonTypeOrderRecord = 1 << 31,                       //订货记录
};

@interface TDFRootViewController (FooterButton)

@property(nonatomic, strong) NSMutableArray *footerButtons;
@property(nonatomic, strong) NSNumber *buttonOriginX;
@property (nonatomic, copy) NSString *otherButtonName;

- (void)footerAddButtonAction:(UIButton *)sender;
- (void)footerExportButtonAction:(UIButton *)sender;
- (void)footerBatchButtonAction:(UIButton *)sender;
- (void)footerHelpButtonAction:(UIButton *)sender;
- (void)footerAllCheckButtonAction:(UIButton *)sender;                  //全选
- (void)footerNotAllCheckButtonAction:(UIButton *)sender;               //全不选
- (void)footerScanButtonAction:(UIButton *)sender;
- (void)footerUploadingButtonAction:(UIButton *)sender;
- (void)footerImportButtonAction:(UIButton *)sender;
- (void)footerSortButtonAction:(UIButton *)sender;
- (void)footerPickButtonAction:(UIButton *)sender;
- (void)footerCentralizePurchaseAction:(UIButton *)sender;
- (void)footerSearchButtonAction:(UIButton *)sender;
- (void)footerEmailButtonAction:(UIButton *)sender;
- (void)footerPrintButtonAction:(UIButton *)sender;
- (void)footerPrintBillButtonAction:(UIButton *)sender;
- (void)footerOtherButtonAction:(UIButton *)sender;
- (void)footerSendMessageButtonAction:(UIButton *)sender;
- (void)footerAddShopButtonAction:(UIButton *)sender;
- (void)footerShopCardToChainButtonAction:(UIButton *)sender;
- (void)footerCostPriceListButtonAction:(UIButton *)sender;
- (void)generateFooterButtonWithTypes:(TDFFooterButtonTypes)types;
- (void)generateFooterButtonWithTypes:(TDFFooterButtonTypes)types withOtherButtonName:(NSString *)butName;
- (void)footerAddDocumentTempleteBtnAction:(UIButton *)sender;
- (void)footerConfirmPurchaseBtnAction:(UIButton *)sender ;
- (void)footerRecordButtonAction:(UIButton *)sender;
- (void)footerBatchRenewalButtonAction:(UIButton *)sender;
- (void)footerBatchVideoRecordingButtonAction:(UIButton *)sender;
- (void)footerSearchByMaterialButtonAction:(UIButton *)sender;
- (void)footerRepaymentButtonAction:(UIButton *)sender;                 //还款
- (void)footerMemoLibraryButtonAction:(UIButton *)sender;               //加料、备注库管理

/**
 预览点击

 @param sender sender
 */
- (void)footerPreviewButtonAction:(UIButton *)sender;
- (void)footerOrderRecordButtonAction:(UIButton *)sender;   //订货记录
- (void)footerCreateShopButtonAction:(UIButton *)sender;
- (void)hideAllFooterButtons;

- (void)removeAllFooterButtons;


@end
