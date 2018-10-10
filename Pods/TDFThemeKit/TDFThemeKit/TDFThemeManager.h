//
//  TDFThemeManager.h
//  RestApp
//
//  Created by happyo on 2017/6/23.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDFHomeBackgroundImageModel.h"

FOUNDATION_EXPORT NSString * kHomeThemeChangedNotification;

@interface TDFThemeManager : NSObject

@property (nonatomic, strong, readonly) NSArray<TDFHomeBackgroundImageModel *> *backgroundImageList;

@property (nonatomic, assign, readonly) NSInteger themeId;

+ (instancetype)sharedInstance;

- (void)changeTheme:(NSInteger)themeId;

- (BOOL)isDynamicTheme;

- (UIImage *)getBackgroundImage;

@end
