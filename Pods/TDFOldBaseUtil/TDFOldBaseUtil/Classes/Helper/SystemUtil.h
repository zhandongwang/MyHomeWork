//
//  SystemUtil.h
//  CardApp
//
//  Created by SHAOJIANQING-MAC on 13-6-26.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemUtil : NSObject

+ (NSInteger)getSystemType;

+ (void)hideKeyboard;

+ (NSString *)getXibName:(NSString *)xibName;

+ (NSString *)getDeviceName;

+(void)showMessage:(NSString *)message;
@end
