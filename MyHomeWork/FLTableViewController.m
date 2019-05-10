//
//  FLTableViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLTableViewController.h"
#import "FLUIKitViewController.h"
#import "FLCTViewController.h"
#import "FLCoreGraphicsViewController.h"
#import "FLUIKitTableViewController.h"

static NSString * const kCellID = @"cellID";


@interface FLTableViewController ()

@property (nonatomic, copy) NSDictionary *dataDict;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation FLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能列表";
    
    [self configDataSource];
    [self configTableView];
    
}
- (void)configDataSource {
    self.dataDict = @{@"UIKit":@"goToUIKit",
                      @"RunTime":@"goToRunTime",
                      @"RunLoop":@"goToRunLoop",
                      @"Block":@"goToBlock",
                      @"Core Text":@"goToCoreText",
                      @"Core Graphics":@"goToCoreGraphics",
                      };
    self.dataSource = [NSMutableArray arrayWithArray:self.dataDict.allKeys];
}


- (void)configTableView {
    self.tableView.rowHeight = 88;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Methods

- (void)goToUIKit {
    [self.navigationController pushViewController:[[FLUIKitTableViewController alloc] init] animated:YES];
}

- (void)goToRunTime {
    
}
- (void)goToRunLoop {
    
}
- (void)goToBlock {
    
}

- (void)goToCoreText {
    [self.navigationController pushViewController:[[FLCTViewController alloc] init] animated:YES];
}

- (void)goToCoreGraphics {
    [self.navigationController pushViewController:[[FLCoreGraphicsViewController alloc] init] animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *selString =  [self.dataDict valueForKey:self.dataSource[indexPath.row]];
    if ([self respondsToSelector:NSSelectorFromString(selString)]) {
        [self performSelector:NSSelectorFromString(selString)];
    }
}


@end
