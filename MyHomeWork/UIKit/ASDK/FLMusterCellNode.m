//
//  FLMusterCellNode.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLMusterCellNode.h"
#import "FLMusterOneNode.h"
#import "FLMusterTwoNode.h"
#import "FLMusterTopNode.h"
@interface FLMusterCellNode()

@property(nonatomic, strong) FLMusterTopNode *topNode;
@property(nonatomic, strong) FLMusterOneNode *oneNode;
@property(nonatomic, strong) FLMusterTwoNode *twoNode;

@property(nonatomic, strong) NSArray<FLMusterTwoNode *> *twoNodeArray;

@property(nonatomic, assign) NSInteger count;

@end


@implementation FLMusterCellNode

- (instancetype)initWithCount:(NSInteger)count{
    self = [super init];
    if (self) {
        _count = count;
        [self setupUIWithCount:count];
        
    }
    return self;
}

- (void)setupUIWithCount:(NSInteger)count{
    _topNode = [FLMusterTopNode new];
    [self addSubnode:_topNode];
    
    _oneNode = [FLMusterOneNode new];
    [self addSubnode:_oneNode];
    
    NSMutableArray<FLMusterTwoNode *> *twoNodeArray = [NSMutableArray array];
    for (int i = 0; i < (count / 2); ++i) {
        NSInteger needCount = 2*(i+1);
        FLMusterTwoNode *twoNode = nil;
        if (needCount < count) {
            twoNode = [[FLMusterTwoNode alloc] initWithCount:2];
        } else {
            twoNode = [[FLMusterTwoNode alloc] initWithCount:1];
        }
        [self addSubnode:twoNode];
        [twoNodeArray addObject:twoNode];
    }
    _twoNodeArray = [twoNodeArray copy];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    NSArray *stackChildren = @[_topNode, _oneNode];
    if (_twoNodeArray.count) {
        stackChildren = [stackChildren arrayByAddingObjectsFromArray:_twoNodeArray];
    }
    ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:16 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:stackChildren];
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(16, 16, 16, 16) child:stackSpec];

    return insetSpec;
}



@end
