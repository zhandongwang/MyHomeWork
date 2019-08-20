//
//  FLASDKViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLASDKViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "FLMusterCellNode.h"

@interface FLASDKViewController ()<ASTableDelegate, ASTableDataSource>

@property (nonatomic, strong) ASTableNode *tableNode;

@end

@implementation FLASDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableNode];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tableNode.frame = self.view.bounds;
}

- (void)setupTableNode {
    _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    _tableNode.backgroundColor = [UIColor whiteColor];
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubnode:_tableNode];
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ^{
        FLMusterCellNode *cellNode = [[FLMusterCellNode alloc] initWithCount:indexPath.row+1];
        return cellNode;
    };
}

- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ASSizeRangeMake(CGSizeMake([UIScreen mainScreen].bounds.size.width, (([UIScreen mainScreen].bounds.size.width - 32)/16) * 9), CGSizeMake([UIScreen mainScreen].bounds.size.width, INFINITY));
}

@end
