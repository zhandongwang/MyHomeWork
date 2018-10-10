//
//  TDFBackForePriceConverter.h
//  Pods
//
//  Created by tripleCC on 11/10/16.
//
//

#import <Foundation/Foundation.h>

#ifndef __TDFBackForePriceConverter__
#define __TDFBackForePriceConverter__

/** 
 后台价格都是 * 100 算，实际显示价格需要 / 100
 结合YYModel，在下面方法中转化成前端价格
 - (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
 
 在下面方法中转化成后台价格
 - (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic
 
 这样在执行model->json ／ json->model时，就会自动转换价格
 而价格的转换就统一在model层处理掉了，业务层不用关心后台返回的数据是不是对的
 */

static const CGFloat TDFBKPriceConversionRate = 100.0;

/** 前端->后台 */
static inline id TDFBKForeToBackPrice(id price) {
    
    if ([price isKindOfClass:[NSString class]]) {
        return @((NSInteger)([price doubleValue] * TDFBKPriceConversionRate)).stringValue;
    } else if ([price isKindOfClass:[NSNumber class]]) {
        return @((NSInteger)([price doubleValue] * TDFBKPriceConversionRate));
    }
    
    return price;
}

/** 后台->前端 */
static inline id TDFBKBackToForePrice(id price) {
    
    if ([price isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%f", [price doubleValue] / TDFBKPriceConversionRate];
    } else if ([price isKindOfClass:[NSNumber class]]) {
        // 注意这一步可能会精度丢失，对double进行NSNumber操作
        return @([price doubleValue] / TDFBKPriceConversionRate);
    }

    return price;
}

static inline id TDFBKBackToForeDoublePrice(double price) {
    return [NSString stringWithFormat:@"%f", price / TDFBKPriceConversionRate];
}

static inline id TDFBKForeToBackIntegerPrice(double price) {
    return [NSString stringWithFormat:@"%ld", (NSInteger)(price * TDFBKPriceConversionRate)];
}

#define TDFBK_FORE_TO_BACK_PRICE(dic, key) do { dic[@#key] = TDFBKForeToBackPrice([NSString stringWithFormat:@"%f", self.key]); } while(0)
#define TDFBK_BACK_TO_FORE_PRICE(dic, key) do { self.key = [TDFBKBackToForePrice(dic[@#key]) doubleValue]; } while(0)

#endif
