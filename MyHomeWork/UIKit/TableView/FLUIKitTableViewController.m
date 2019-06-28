//
//  FLUIKitTableViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLUIKitTableViewController.h"
#import "FLUIKitTableViewCell.h"
#import <coobjc/coobjc.h>
#import "FLUIKitTableViewControllerViewModel.h"
#import "FLMovieModel.h"
#import "DHOrderDishModel.h"

static NSString * const kCellReusedID = @"FLUIKitTableViewCell";

@interface FLUIKitTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation FLUIKitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DHOrderDishModel *dish = [DHOrderDishModel new];
    [self configTableView];
    NSLog(@"-------before invoke request------------");
    [self sendRequest];
    NSLog(@"-------after invoke request------------");
}

- (void)configTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 200;
    [self.tableView registerClass:[FLUIKitTableViewCell class] forCellReuseIdentifier:kCellReusedID];
    
}

- (void)sendRequest {
    co_launch(^{
        NSLog(@"-------before send request------------");
        NSArray *dataArray = [[FLUIKitTableViewControllerViewModel sharedInstance] getDiscoverList:@"1"];
        
        NSLog(@"-------after send request------------");
        
        if (dataArray) {
            self.dataSource = [dataArray copy];
            [self.tableView reloadData];

        } else {
            NSLog(@"request data failed");
        }
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLUIKitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReusedID forIndexPath:indexPath];
    FLMovieModel *model = self.dataSource[indexPath.row];
    [cell updateWithImageUrl:model.picPath name:model.title];
    
    return cell;
}
@end
