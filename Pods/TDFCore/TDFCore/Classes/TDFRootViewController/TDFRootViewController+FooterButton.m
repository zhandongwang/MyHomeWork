//
//  TDFRootViewController+FooterButton.m
//  RestApp
//
//  Created by happyo on 16/9/9.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import "TDFRootViewController+FooterButton.h"
#import <objc/runtime.h>
#import "TDFFooterButton.h"
#import "TDFVerticalButton.h"
#import "UIImage+Resize.h"
#import "NSBundle+Language.h"
#import "TDFDataCenter.h"
#import "RestConstants.h"
#import <TDFCore/TDFCore.h>
#import "TDFAdaptation.h"

#define TDFFooterButtonSize 55.0f
#define TDFFooterButtonsLeftOffset 8.0f
#define TDFFooterButtonsHorizontalOffset 10.0f
#define TDFFooterButtonsOriginY ([UIScreen mainScreen].bounds.size.height - TDFFooterButtonSize - 72.0f - (iPhoneX ? 54.0f : 0))

static const void *footerButtonsKey = &footerButtonsKey;
static const void *buttonOriginXKey = &buttonOriginXKey;
static const void *otherButtonNameKey = &otherButtonNameKey;
UIImage *kTDFFooterImageWithName(NSString *name) {
    
    if (TDFAPPIdentifier == kTDFSupplyChainAppIdentifier) {
        
        return TDFLocaizedImage(name);
    } else {
        
        return TDFLocaizedImage([@"red/" stringByAppendingString:name]) ?: TDFLocaizedImage(name);
    }
};

@implementation TDFRootViewController (FooterButton)

@dynamic footerButtons;
@dynamic buttonOriginX;
@dynamic otherButtonName;

- (NSMutableArray *)footerButtons {
    return objc_getAssociatedObject(self, &footerButtonsKey);
}

- (void)setFooterButtons:(NSMutableArray *)footerButtons
{
    objc_setAssociatedObject(self, &footerButtonsKey, footerButtons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)buttonOriginX
{
    return objc_getAssociatedObject(self, &buttonOriginXKey);
}

- (void)setButtonOriginX:(NSNumber *)buttonOriginX
{
    objc_setAssociatedObject(self, &buttonOriginXKey, buttonOriginX, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)otherButtonName {
    return objc_getAssociatedObject(self, &otherButtonNameKey);
}

- (void)setOtherButtonName:(NSString *)otherButtonName {
    objc_setAssociatedObject(self, &otherButtonNameKey, otherButtonName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)footerUploadingButtonAction:(__unused UIButton *)sender {}

- (void)footerScanButtonAction:(UIButton *)sender {}

- (void)footerAddButtonAction:(UIButton *)sender {
    
}

- (void)footerAddApplyButtonAction:(UIButton *)sender {};

- (void)footerExportButtonAction:(UIButton *)sender {
    
}


- (void)footerBatchButtonAction:(UIButton *)sender {
    
}

- (void)footerHelpButtonAction:(UIButton *)sender {
    
}

- (void)handleHelpButtonPanGestureRecognizer:(UIPanGestureRecognizer*)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGFloat centerX = recognizer.view.center.x+ translation.x;
    CGFloat centerY = recognizer.view.center.y+ translation.y;
    CGFloat thecenter = 0;

    recognizer.view.center=CGPointMake(centerX,recognizer.view.center.y+ translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        if(centerX > [UIScreen mainScreen].bounds.size.width/2) {
            thecenter = [UIScreen mainScreen].bounds.size.width - TDFFooterButtonSize/2;
        }else{
            thecenter=TDFFooterButtonSize/2;
        }
        if (centerY < TDFFooterButtonSize/2) {
            centerY = TDFFooterButtonSize/2;
        }else if (centerY > [UIScreen mainScreen].bounds.size.height-100) {
            centerY =  [UIScreen mainScreen].bounds.size.height - 100;
        }
    
        [UIView animateWithDuration:0.3 animations:^{
            recognizer.view.center=CGPointMake(thecenter, centerY);
        }];
    }
}

- (void)footerAllCheckButtonAction:(UIButton *)sender {
    
}

- (void)footerNotAllCheckButtonAction:(UIButton *)sender {
    
}

- (void)footerImportButtonAction:(UIButton *)sender {
    
}

- (void)footerSortButtonAction:(UIButton *)sender {
    
}

- (void)footerPickButtonAction:(UIButton *)sender {
    
}

- (void)footerSearchButtonAction:(UIButton *)sender {
    
}

- (void)footerEmailButtonAction:(UIButton *)sender {
    
}

- (void)footerPrintButtonAction:(UIButton *)sender {
    
}

- (void)footerCentralizePurchaseAction:(UIButton *)sender {
    
}

- (void)footerSendMessageButtonAction:(UIButton *)sender{
    
}

- (void)footerOtherButtonAction:(UIButton *)sender {
    
}

- (void)footerPrintBillButtonAction:(UIButton *)sender {
    
}

- (void)footerAddShopButtonAction:(UIButton *)sender{
    
}

- (void)footerShopCardToChainButtonAction:(UIButton *)sender {
    
}


- (void)footerAddDocumentTempleteBtnAction:(UIButton *)sender {
    
}


- (void)footerRecordButtonAction:(UIButton *)sender{
    
    
}

- (void)footerBatchRenewalButtonAction:(UIButton *)sender{
    
    
}

- (void)footerVideoRecordingButtonAction:(UIButton *)sender{
    
    
}

- (void)footerBuyFieldButtonAction:(UIButton *)sender{
    
    
}

- (void)footerRepaymentButtonAction:(UIButton *)sender {
    
}

- (void)footerMemoLibraryButtonAction:(UIButton *)sender {
    
};

- (void)footerPantryLibraryButtonAction:(UIButton *)sender{
    
};

- (void)footerPreviewButtonAction:(UIButton *)sender{
    
};

- (void)generateFooterButtonWithTypes:(TDFFooterButtonTypes)types withOtherButtonName:(NSString *)butName {
    self.otherButtonName = butName;
    [self generateFooterButtonWithTypes:types];
}

- (void)footerOrderRecordButtonAction:(UIButton *)sender{};


- (void)footerCreateShopButtonAction:(UIButton *)sender {
    
}

- (void)generateFooterButtonWithTypes:(TDFFooterButtonTypes)types {
    
    self.buttonOriginX = @([UIScreen mainScreen].bounds.size.width - TDFFooterButtonsLeftOffset);
    
    if (!self.footerButtons) {
        self.footerButtons = [NSMutableArray arrayWithCapacity:3];
    }else {
        [self.footerButtons removeAllObjects];
    }
    
    //添加
    if (types & TDFFooterButtonTypeAdd) {
        TDFFooterButton *addButton = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        [addButton setBackgroundImage:NSLocalizedImage(@"ico_footer_button_addd_red") forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        addButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        
        [addButton addTarget:self action:@selector(footerAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:addButton];
        
        [self.view addSubview:addButton];
        if (self.needHideOldNavigationBar) {
            addButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    //    if (types & TDFFooterButtonTypeCreateShop) {
    //        TDFVerticalButton *createShopButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
    //        [createShopButton setBackgroundImage:[UIImage imageNamed:@"ico_footer_button_createShop"] forState:UIControlStateNormal];
    //        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
    //        createShopButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
    //        createShopButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    //        [createShopButton addTarget:self action:@selector(footerCreateShopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.footerButtons addObject:createShopButton];
    //        [self.view addSubview:createShopButton];
    //        if (self.needHideOldNavigationBar) {
    //            createShopButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
    //        }
    //    }
    
    // 添加申请
    //    if (types & TDFFooterButtonTypeAddApply) {
    //        TDFFooterButton *addApplyButton = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
    //        [addApplyButton setBackgroundImage:NSLocalizedImage(@"ico_add_apply") forState:UIControlStateNormal];
    //        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize);
    //        addApplyButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
    //
    //        [addApplyButton addTarget:self action:@selector(footerAddApplyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //        [self.footerButtons addObject:addApplyButton];
    //
    //        [self.view addSubview:addApplyButton];
    //        if (self.needHideOldNavigationBar) {
    //            addApplyButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
    //        }
    //    }
    
    //排序
    if (types & TDFFooterButtonTypeSort) {
        TDFVerticalButton *sortBtn = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [sortBtn setBackgroundImage:kTDFFooterImageWithName(@"ico_footer_button_sort") forState:UIControlStateNormal];
        [sortBtn setTitle:nil forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        sortBtn.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [sortBtn addTarget:self action:@selector(footerSortButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:sortBtn];
        [self.view addSubview:sortBtn];
        if (self.needHideOldNavigationBar) {
            sortBtn.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    // refactor:tripleCC 可以采用数组+UICollectionView的形式
    // 目前是先判断的类型，越靠近右边
    if (types & TDFFooterButtonTypeCentralizePurchase) {
        TDFVerticalButton *centralizePurchaseButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [centralizePurchaseButton setImage: TDFLocaizedImage(@"ico_centralize_purchase") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        centralizePurchaseButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [centralizePurchaseButton addTarget:self action:@selector(footerCentralizePurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:centralizePurchaseButton];
        [self.view addSubview:centralizePurchaseButton];
        if (self.needHideOldNavigationBar) {
            centralizePurchaseButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeOrderRecord) {
        TDFVerticalButton *oderRecord = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [oderRecord setImage:[UIImage imageNamed:@"ico_footer_button_order_record"] forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        oderRecord.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [oderRecord addTarget:self action:@selector(footerOrderRecordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:oderRecord];
        [self.view addSubview:oderRecord];
        if (self.needHideOldNavigationBar) {
            oderRecord.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeUploading) {
        TDFVerticalButton *uploadingButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [uploadingButton setBackgroundImage:[UIImage imageNamed:@"ico_uploading"] forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        uploadingButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        uploadingButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [uploadingButton addTarget:self action:@selector(footerUploadingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:uploadingButton];
        [self.view addSubview:uploadingButton];
        if (self.needHideOldNavigationBar) {
            uploadingButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    //发送短信
    if (types & TDFFooterButtonTypeSendMessage) {
        TDFFooterButton *sendMessageButton = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        [sendMessageButton setBackgroundImage:kTDFFooterImageWithName (@"ico_footer_button_sendMessage") forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        sendMessageButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [sendMessageButton addTarget:self action:@selector(footerSendMessageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.footerButtons addObject:sendMessageButton];
        
        [self.view addSubview:sendMessageButton];
        if (self.needHideOldNavigationBar) {
            sendMessageButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypePick) {
        TDFVerticalButton *pickBtn = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [pickBtn setBackgroundImage: kTDFFooterImageWithName(@"ico_batch_pick") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        pickBtn.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        pickBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [pickBtn addTarget:self action:@selector(footerPickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:pickBtn];
        [self.view addSubview:pickBtn];
        if (self.needHideOldNavigationBar) {
            pickBtn.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeImport) {
        TDFVerticalButton *importBtn = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [importBtn setBackgroundImage: TDFLocaizedImage(@"icon_input") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        importBtn.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        importBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [importBtn addTarget:self action:@selector(footerImportButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:importBtn];
        [self.view addSubview:importBtn];
        if (self.needHideOldNavigationBar) {
            importBtn.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    //    if (types & TDFFooterButtonTypeSearchByMaterial) {
    //        TDFVerticalButton *searchByMaterialBtn = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
    //        [searchByMaterialBtn setBackgroundImage:[UIImage imageNamed:@"ico_footer_button_search_by_material"] forState:UIControlStateNormal];
    //        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
    //        searchByMaterialBtn.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
    //        searchByMaterialBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    //        [searchByMaterialBtn addTarget:self action:@selector(footerSearchByMaterialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.footerButtons addObject:searchByMaterialBtn];
    //        [self.view addSubview:searchByMaterialBtn];
    //        if (self.needHideOldNavigationBar) {
    //            searchByMaterialBtn.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
    //        }
    //    }
    
    if (types & TDFFooterButtonTypeBatch) {
        TDFFooterButton *batchButton = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        //        [batchButton setBackgroundImage:[UIImage imageNamed:@"ico_footer_button_bat"] forState:UIControlStateNormal];
        [batchButton setBackgroundImage:kTDFFooterImageWithName(@"ico_footer_button_batch") forState:UIControlStateNormal];
        [batchButton setTitle:nil forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset);
        batchButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [batchButton addTarget:self action:@selector(footerBatchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:batchButton];
        [self.view addSubview:batchButton];
        if (self.needHideOldNavigationBar) {
            batchButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTyoesStatementRecord) { //结算记录
        
        TDFVerticalButton *recordButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [recordButton setBackgroundImage:[UIImage imageNamed:@"ico_footer_button_balance"] forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        recordButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        recordButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [recordButton addTarget:self action:@selector(footerRecordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [recordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.footerButtons addObject:recordButton];
        [self.view addSubview:recordButton];
        if (self.needHideOldNavigationBar) {
            recordButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypesBatchIssue) {
        TDFFooterButton *batchButton = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        [batchButton setBackgroundImage:kTDFFooterImageWithName(@"icon_batch_Issue") forState:UIControlStateNormal];
        [batchButton setTitle:nil forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset);
        batchButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [batchButton addTarget:self action:@selector(footerBatchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:batchButton];
        [self.view addSubview:batchButton];
        if (self.needHideOldNavigationBar) {
            batchButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    
    if (types & TDFFooterButtonTypeOther) {
        TDFFooterButton *addButton = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        [addButton setBackgroundImage:[UIImage imageNamed:@"ico_rnd_green"] forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset);
        addButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        
        if (self.otherButtonName && self.otherButtonName.length > 0) {
            [addButton setTitle:self.otherButtonName forState:UIControlStateNormal];
            addButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        } else {
            [addButton setTitle:NSLocalizedString(@"其他", nil) forState:UIControlStateNormal];
        }
        
        addButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [addButton addTarget:self action:@selector(footerOtherButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:addButton];
        
        [self.view addSubview:addButton];
        if (self.needHideOldNavigationBar) {
            addButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeExport) {
        TDFFooterButton *exportButton = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        [exportButton setBackgroundImage:kTDFFooterImageWithName(@"export") forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset);
        exportButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        exportButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [exportButton addTarget:self action:@selector(footerExportButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:exportButton];
        [self.view addSubview:exportButton];
        if (self.needHideOldNavigationBar) {
            exportButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    //
    if (types & TDFFooterButtonTypeConfirmPurchase) {
        TDFFooterButton *notAllCheck = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        [notAllCheck setBackgroundImage:[UIImage imageNamed:@"ico_footer_button_purchase"] forState:UIControlStateNormal];
        [notAllCheck setTitle:nil forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset);
        notAllCheck.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [notAllCheck addTarget:self action:@selector(footerConfirmPurchaseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:notAllCheck];
        [self.view addSubview:notAllCheck];
        if (self.needHideOldNavigationBar) {
            notAllCheck.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    //还款
    if (types & TDFFooterButtonTypeRepayment) {
        TDFFooterButton *RepaymentButton = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        RepaymentButton.layer.borderWidth = 1;
        RepaymentButton.layer.cornerRadius  = 55/2;
        RepaymentButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [RepaymentButton setBackgroundImage:NSLocalizedImage(@"ico_footer_button_repayment") forState:UIControlStateNormal];
        [RepaymentButton setTitle:nil forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset);
        RepaymentButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [RepaymentButton addTarget:self action:@selector(footerRepaymentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:RepaymentButton];
        [self.view addSubview:RepaymentButton];
        if (self.needHideOldNavigationBar) {
            RepaymentButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    
    
    //全不选
    if (types & TDFFooterButtonTypeNotAllCheck) {
        TDFFooterButton *notAllCheck = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        [notAllCheck setBackgroundImage:kTDFFooterImageWithName(@"ico_footer_button_uncheckall") forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset);
        notAllCheck.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [notAllCheck addTarget:self action:@selector(footerNotAllCheckButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:notAllCheck];
        [self.view addSubview:notAllCheck];
        if (self.needHideOldNavigationBar) {
            notAllCheck.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    //全选
    if (types & TDFFooterButtonTypeAllCheck) {
        TDFFooterButton *allCheck = [TDFFooterButton buttonWithType:UIButtonTypeCustom];
        [allCheck setBackgroundImage:kTDFFooterImageWithName(@"ico_footer_button_checkall") forState:UIControlStateNormal];
        self.buttonOriginX = @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset);
        allCheck.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [allCheck addTarget:self action:@selector(footerAllCheckButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:allCheck];
        [self.view addSubview:allCheck];
        if (self.needHideOldNavigationBar) {
            allCheck.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    
    if (types & TDFFooterButtonTypeScan) {
        TDFVerticalButton *scanButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [scanButton setBackgroundImage:[UIImage imageNamed:@"ico_scan_button"] forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        scanButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        scanButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [scanButton addTarget:self action:@selector(footerScanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:scanButton];
        [self.view addSubview:scanButton];
        if (self.needHideOldNavigationBar) {
            scanButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeAddShop) {
        TDFVerticalButton *addShopButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [addShopButton setBackgroundImage: kTDFFooterImageWithName(@"ico_footer_button_addshop") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        addShopButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        [addShopButton addTarget:self action:@selector(footerAddShopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:addShopButton];
        [self.view addSubview:addShopButton];
        if (self.needHideOldNavigationBar) {
            addShopButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeShopCardToChain) {
        TDFVerticalButton *addShopButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [addShopButton setBackgroundImage: kTDFFooterImageWithName (@"icon_footer_button_shopCardToChain") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        addShopButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        addShopButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [addShopButton addTarget:self action:@selector(footerShopCardToChainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:addShopButton];
        [self.view addSubview:addShopButton];
        if (self.needHideOldNavigationBar) {
            addShopButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    
    if (types & TDFFooterButtonTypeSearch) {
        TDFVerticalButton *searchButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [searchButton setBackgroundImage: kTDFFooterImageWithName(@"ico_footer_button_search") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        searchButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        searchButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [searchButton addTarget:self action:@selector(footerSearchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:searchButton];
        [self.view addSubview:searchButton];
        if (self.needHideOldNavigationBar) {
            searchButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypePrint) {
        TDFVerticalButton *printButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [printButton setBackgroundImage:TDFLocaizedImage(@"ico_footer_button_printOld") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        printButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        printButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [printButton addTarget:self action:@selector(footerPrintButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:printButton];
        [self.view addSubview:printButton];
        if (self.needHideOldNavigationBar) {
            printButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypePrintBill) {
        TDFVerticalButton *printButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [printButton setBackgroundImage:kTDFFooterImageWithName(@"ico_footer_button_printBill") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        printButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        printButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [printButton addTarget:self action:@selector(footerPrintBillButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:printButton];
        [self.view addSubview:printButton];
        if (self.needHideOldNavigationBar) {
            printButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeEmail) {
        TDFVerticalButton *emailButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [emailButton setBackgroundImage: TDFLocaizedImage(@"ico_footer_button_email") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        emailButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        emailButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [emailButton addTarget:self action:@selector(footerEmailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerButtons addObject:emailButton];
        [self.view addSubview:emailButton];
        if (self.needHideOldNavigationBar) {
            emailButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    
    
    
    if (types & TDFFooterButtonTypeCostPriceList) {
        TDFVerticalButton *costButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [costButton setBackgroundImage:[UIImage imageNamed:@"ico_footer_button_costprice"] forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        costButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        costButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [costButton addTarget:self action:@selector(footerCostPriceListButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:costButton];
        [self.view addSubview:costButton];
        if (self.needHideOldNavigationBar) {
            costButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeDocumentTemplate) {
        TDFVerticalButton *documentButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [documentButton setBackgroundImage:[UIImage imageNamed:@"ico_footer_button_documentTemplate"] forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        documentButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        documentButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [documentButton addTarget:self action:@selector(footerAddDocumentTempleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:documentButton];
        [self.view addSubview:documentButton];
        if (self.needHideOldNavigationBar) {
            documentButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    
    if (types & TDFFooterButtonTypeVideoRecording) {
        TDFVerticalButton *videoRecordButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        
        [videoRecordButton setBackgroundImage: kTDFFooterImageWithName(@"ico_footer_videoCustomer") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?
        @(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):
        @(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        
        videoRecordButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        videoRecordButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [videoRecordButton addTarget:self action:@selector(footerBatchVideoRecordingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:videoRecordButton];
        [self.view addSubview:videoRecordButton];
        if (self.needHideOldNavigationBar) {
            videoRecordButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    if (types & TDFFooterButtonTypeBuyField) {
        TDFVerticalButton *buyFieldButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [buyFieldButton setBackgroundImage:kTDFFooterImageWithName(@"ico_footer_buyField") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        buyFieldButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        buyFieldButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [buyFieldButton addTarget:self action:@selector(footerBuyFieldButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:buyFieldButton];
        [self.view addSubview:buyFieldButton];
        if (self.needHideOldNavigationBar) {
            buyFieldButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    if (types & TDFFooterButtonTypeBatchRenewal) {
        TDFVerticalButton *batchRenewalButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
        [batchRenewalButton setBackgroundImage:kTDFFooterImageWithName(@"ico_footer_batchRebewal") forState:UIControlStateNormal];
        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
        batchRenewalButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
        batchRenewalButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [batchRenewalButton addTarget:self action:@selector(footerBatchRenewalButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerButtons addObject:batchRenewalButton];
        [self.view addSubview:batchRenewalButton];
        if (self.needHideOldNavigationBar) {
            batchRenewalButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
        }
    }
    
    // // 预览
    //    if (types & TDFFooterButtonTypePreview) {
    //        TDFVerticalButton *batchRenewalButton = [TDFVerticalButton buttonWithType:UIButtonTypeCustom];
    //        [batchRenewalButton setBackgroundImage:[UIImage imageNamed:@"ico_preview"] forState:UIControlStateNormal];
    //        self.buttonOriginX = self.footerButtons.count>0?@(self.buttonOriginX.floatValue - TDFFooterButtonSize - TDFFooterButtonsHorizontalOffset):@(self.buttonOriginX.floatValue - TDFFooterButtonSize);
    //        batchRenewalButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY, TDFFooterButtonSize, TDFFooterButtonSize);
    //        batchRenewalButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    //        [batchRenewalButton addTarget:self action:@selector(footerPreviewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.footerButtons addObject:batchRenewalButton];
    //        [self.view addSubview:batchRenewalButton];
    //        if (self.needHideOldNavigationBar) {
    //            batchRenewalButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64, TDFFooterButtonSize, TDFFooterButtonSize);
    //        }
    //    }
    
    
    //帮助按钮一定要放在最下边，不然会计算出错 (新UI标准帮助按钮为44*44)
//    if ([TDFDataCenter sharedInstance].industry == TDFIndustryTypeRest) {
        //零售的帮助页面隐藏
        if (types & TDFFooterButtonTypeHelp) {
            NSString *countryCode = [TDFDataCenter sharedInstance].countryId;
            BOOL isGlobalizationFormat =!([countryCode isEqualToString: @"001"]);
            if(!isGlobalizationFormat){
                UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.buttonOriginX = @(8.0f);
                helpButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY + 11.0, TDFFooterButtonSize - 11.0, TDFFooterButtonSize - 11.0);
                UIImage *helpImage = [UIImage imageNamed:@"ico_help"];
                
                [helpButton setImage:[UIImage imageWithCGImage:helpImage.CGImage scale:(helpImage.size.width / 32.0f)  orientation:UIImageOrientationUp] forState:UIControlStateNormal];
                helpButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                [helpButton addTarget:self action:@selector(footerHelpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.footerButtons addObject:helpButton];
                [self.view addSubview:helpButton];
                if (self.needHideOldNavigationBar) {
                    helpButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64+11.0, TDFFooterButtonSize - 11.0, TDFFooterButtonSize - 11.0);
                }
                
            }
        }
        // 如果是供应链
        if (TDFAPPIdentifier == kTDFSupplyChainAppIdentifier){
            UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.buttonOriginX = @(8.0f);
            helpButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY + 11.0, TDFFooterButtonSize - 11.0, TDFFooterButtonSize - 11.0);
            UIImage *helpImage = [UIImage imageNamed:@"ico_help"];
            
            [helpButton setImage:[UIImage imageWithCGImage:helpImage.CGImage scale:(helpImage.size.width / 32.0f)  orientation:UIImageOrientationUp] forState:UIControlStateNormal];
            helpButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [helpButton addTarget:self action:@selector(footerHelpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.footerButtons addObject:helpButton];
            [self.view addSubview:helpButton];
            if (self.needHideOldNavigationBar) {
                helpButton.frame = CGRectMake(self.buttonOriginX.floatValue, TDFFooterButtonsOriginY+64+11.0, TDFFooterButtonSize - 11.0, TDFFooterButtonSize - 11.0);
            }
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHelpButtonPanGestureRecognizer:)];
            [helpButton addGestureRecognizer:pan];
        }
//    }    
}

- (void)hideAllFooterButtons {
    for(UIView *subView in self.footerButtons) {
        subView.hidden = YES;
    }
}

- (void)removeAllFooterButtons {
    
    for(UIButton *footerButton in self.footerButtons) {
        [footerButton removeFromSuperview];
    }
}


@end

