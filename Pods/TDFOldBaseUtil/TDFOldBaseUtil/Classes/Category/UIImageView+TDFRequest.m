//
//  UIImageView+TDFRequest.m
//  RestApp
//
//  Created by guopin on 16/6/4.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import "UIImageView+TDFRequest.h"
#import "UIImageView+WebCache.h"
#import "ImageUtils.h"
@implementation UIImageView (TDFRequest)
-(void)tdf_imageRequstWithPath:(NSString *)path placeholderImage:(UIImage *)placeholder urlModel:(ImageUrlModel)model
{
    switch (model) {
            
        case ImageUrlScale:
             [self sd_setImageWithURL:[NSURL URLWithString:[ImageUtils scaleImageUrl:path size:self.bounds.size]] placeholderImage:placeholder];
            break;

        case ImageUrlCapture:
            [self sd_setImageWithURL:[NSURL URLWithString:[ImageUtils captureImageUrl:path size:self.bounds.size]] placeholderImage:placeholder];
            break;
            
        case ImageUrlOrigin:
            [self sd_setImageWithURL:[NSURL URLWithString:[ImageUtils originImageUrl:path]] placeholderImage:placeholder];
            break;

        default:
            break;
    }

}
@end
