//
//  TDFHomeBackgroundImageModel.h
//  RestApp
//
//  Created by happyo on 2017/6/24.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDFHomeBackgroundImageModel : NSObject

@property (nonatomic, assign) BOOL isDynamic;

@property (nonatomic, strong) NSString *vedioUrl;

@property (nonatomic, strong) NSString *dayImageString;

@property (nonatomic, strong) NSString *nightImageString;

@property (nonatomic, strong) NSString *breviaryImageString;

@end
