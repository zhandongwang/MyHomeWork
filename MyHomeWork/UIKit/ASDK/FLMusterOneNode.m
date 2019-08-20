//
//  FLMusterOneNode.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLMusterOneNode.h"
#import "ASNetworkImageNode+FL.h"
#import "ASTextNode+FL.h"
#import "NSAttributedString+FL.h"

@interface FLMusterOneNode ()

@property(nonatomic, strong) ASNetworkImageNode *postImageNode;
@property(nonatomic, strong) ASTextNode *titleNode;
@property(nonatomic, strong) ASTextNode *subTitleNode;


@end

@implementation FLMusterOneNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        _postImageNode = [ASNetworkImageNode createWithURLStr:@"http://filminfo.nfile.cn/filminfo/raw/c4/94/c494ac35bfa8f0424c9b5e9f1c20343f413727f3.jpg"];
        [self addSubnode:_postImageNode];
        
        _titleNode = [ASTextNode createWithAttr:[NSAttributedString createWithText:@"TitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitle" Font:[UIFont systemFontOfSize:14 weight:UIFontWeightBold] Color:[UIColor blackColor]] LineCount:1];
        [self addSubnode:_titleNode];
        _subTitleNode = [ASTextNode createWithAttr:[NSAttributedString createWithText:@"TitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitle" Font:[UIFont systemFontOfSize:14] Color:[UIColor grayColor]] LineCount:1];
        [self addSubnode:_subTitleNode];
        
        _postImageNode.imageModificationBlock = [_postImageNode imageModBlockWithCorner:4];
        
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASRatioLayoutSpec *postImageRatioSpec = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:9.0/16 child:_postImageNode];
    ASInsetLayoutSpec *titleInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 8, 8, 8) child:_titleNode];
    ASInsetLayoutSpec *subTitleInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 8, 8, 8) child:_subTitleNode];
    ASStackLayoutSpec *titleStackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[subTitleInsetSpec, titleInsetSpec]];
     ASRelativeLayoutSpec *relativeSpec = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart verticalPosition:ASRelativeLayoutSpecPositionEnd sizingOption:ASRelativeLayoutSpecSizingOptionDefault child:titleStackSpec];
    ASOverlayLayoutSpec *nameOverSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:postImageRatioSpec overlay:relativeSpec];
    
    return nameOverSpec;
}


@end
