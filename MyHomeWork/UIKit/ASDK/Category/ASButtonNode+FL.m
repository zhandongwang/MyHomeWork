//
//  ASButtonNode+FL.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "ASButtonNode+FL.h"

@implementation ASButtonNode (FL)

+ (ASButtonNode *)createWithImage:(UIImage *)img{
    return [self createWithText:nil Font:nil Color:nil Image:img Spacing:0];
    
}

+ (ASButtonNode *)createWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color{
    return [self createWithText:text Font:font Color:color Image:nil Spacing:0];
    
}

+ (ASButtonNode *)createWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color Image:(UIImage *)img Spacing:(CGFloat)spacing {
    ASButtonNode *buttonNode = [[ASButtonNode alloc]init];
    
    if (text.length) {
        [buttonNode setTitle:text withFont:font withColor:color forState:UIControlStateNormal];
        
    }
    
    if (img) {
        [buttonNode setImage:img forState:UIControlStateNormal];
        [buttonNode setContentSpacing:spacing];
        
    }
    return buttonNode;
}


@end
