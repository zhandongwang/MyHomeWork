//
//  ASTableNode+FL.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "ASTableNode+FL.h"

@implementation ASTableNode (FL)

- (void)insertRowWithStart:(NSInteger)start NewCount:(NSInteger)count {
    NSInteger section = 0;
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger row = start; row < count; ++row) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:path];
    }
    
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}
@end
