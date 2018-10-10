//
//  NSObject+AlertMessage.h
//  Pods
//
//  Created by chaiweiwei on 2017/7/3.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (AlertMessage)

- (void)TDF_showAlert:(NSString *)message;

- (void)TDF_showAlert:(NSString *)message alertAction:(void(^)(void))confirmBlock;

@end
