//
//  ASTextNode+FL.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "ASTextNode+FL.h"

@implementation ASTextNode (FL)
+ (ASTextNode *)createWithAttr:(NSAttributedString *)attr{
    return [self createWithAttr:attr LineCount:0];
    
}

+ (ASTextNode *)createWithAttr:(NSAttributedString *)attr LineCount:(NSInteger)lineCount{
    ASTextNode *textNode = [ASTextNode new];
    textNode.attributedText = attr;
    textNode.placeholderEnabled = YES;
    textNode.placeholderFadeDuration = 0.2;
    textNode.placeholderColor = [UIColor colorWithWhite:0.777 alpha:1.0];
    textNode.maximumNumberOfLines = lineCount;
    textNode.truncationMode = NSLineBreakByTruncatingTail;
    return textNode;
    
}



@end
