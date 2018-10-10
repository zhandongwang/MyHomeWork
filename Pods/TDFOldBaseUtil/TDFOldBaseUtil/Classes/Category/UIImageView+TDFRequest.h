//
//  UIImageView+TDFRequest.h
//  RestApp
//
//  Created by guopin on 16/6/4.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,ImageUrlModel){
    ImageUrlScale = 0,
    ImageUrlCapture,
    ImageUrlOrigin,
} ;
@interface UIImageView (TDFRequest)
-(void)tdf_imageRequstWithPath:(NSString *)path placeholderImage:(UIImage *)placeholder urlModel:(ImageUrlModel)model;
@end
