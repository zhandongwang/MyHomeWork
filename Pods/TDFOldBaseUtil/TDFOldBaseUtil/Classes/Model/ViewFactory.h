//
//  ViewFactory.h
//  CardApp
//
//  Created by 邵建青 on 14-2-19.
//  Copyright (c) 2014年 ZMSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewFactory : NSObject

+ (UIView *)generateFooter:(CGFloat)height;
+(UIView *)customerFooter:(CGFloat)height;
@end
