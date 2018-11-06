//
//  JSPerson.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/10/30.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import JavaScriptCore;

@protocol PersonProtocol<JSExport>

- (NSString *)fullName;

@end


@interface JSPerson : NSObject <PersonProtocol>

- (NSString *)sayFullName;
- (void)evaluatePrice;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *secondName;

@end
