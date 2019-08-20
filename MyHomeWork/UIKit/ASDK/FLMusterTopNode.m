//
//  FLMusterTopNode.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLMusterTopNode.h"
#import "ASTextNode+FL.h"
#import "NSAttributedString+FL.h"
#import "ASButtonNode+FL.h"

@interface FLMusterTopNode ()

@property(nonatomic, strong) ASTextNode *titleNode;
@property(nonatomic, strong) ASButtonNode *moreButtonNode;

@end

@implementation FLMusterTopNode
- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleNode = [ASTextNode createWithAttr:[NSAttributedString createWithText:@"二级标题" Font:[UIFont systemFontOfSize:18] Color:[UIColor blackColor]] LineCount:1];
        [self addSubnode:_titleNode];
        _moreButtonNode = [ASButtonNode createWithText:@"More" Font:[UIFont systemFontOfSize:14] Color:[UIColor blueColor] Image:[UIImage imageNamed:@"definition_more"] Spacing:4];
        _moreButtonNode.imageAlignment = ASButtonNodeImageAlignmentEnd;
        [self addSubnode:_moreButtonNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    _titleNode.style.flexGrow = 1.0;
    _titleNode.style.flexShrink = 1.0;
    ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:8 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStretch children:@[_titleNode, _moreButtonNode]];
    
    return stackSpec;
}

@end
