//
//  UIImageView+FLWebCache.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/10.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "UIImageView+FLWebCache.h"
#import "FLDataService.h"

@implementation UIImageView (FLWebCache)

- (void)setImageWithPicURL:(NSString*)url CO_ASYNC {
    objc_setAssociatedObject(self, @selector(setImageWithPicURL:),url, OBJC_ASSOCIATION_RETAIN);
    
    co_launch(^{
        UIImage *image = [[FLDataService sharedInstance] imageWithURL:url];
        if ([objc_getAssociatedObject(self, @selector(setImageWithPicURL:)) isEqualToString:url]) {
            self.image = image;
        }
        
    });
    
}


@end
