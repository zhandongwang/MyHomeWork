//
//  FRCMainViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/13.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "FRCMainViewController.h"
#import "DHMessageKinds.h"
#import "DHMessageModel.h"

static NSString * const cellID = @"cellID";

@interface FRCMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UILabel *mylabel;
@property (nonatomic, strong) UIButton *myButton;

@end

@implementation FRCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"FRC";
    [self.view addSubview:self.mylabel];
    self.mylabel.frame = CGRectMake(100, 200, 200, 40);
    [self.view addSubview:self.myButton];
    [self.myButton setFrame:CGRectMake(100, 300, 200, 40)];
    
    
//    [self.view addSubview:self.tableView];
//    [self addRefreshToTableView:self.tableView];
//    self.titleArray = [[NSMutableArray alloc] initWithCapacity:10];
}

- (void)test {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self sendFirstPageRequet];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)sendFirstPageRequet {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self loadMessageData];
    [self.tableView.header endRefreshing];
}

- (void)sendNextPageRequet {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self loadMessageData];
    [self.tableView.footer endRefreshing];
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];

    return cell;
    
}

#pragma mark - methods
- (void)loadMessageData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"message" withExtension:@".json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    DHMessageKinds *kinds = [DHMessageKinds yy_modelWithJSON:data];
    [kinds.messages enumerateObjectsUsingBlock:^(DHMessageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.titleArray addObject:obj.title];
    }];
    [self.tableView reloadData];

}

#pragma mark - accessors

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.rowHeight = 40;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (UILabel *)mylabel {
    if (!_mylabel) {
        _mylabel = [[UILabel alloc] init];
        _mylabel.backgroundColor = [UIColor blueColor];
        _mylabel.text = @"测试";
    }
    return _mylabel;
}

- (UIButton *)myButton {
    if (!_myButton) {
        _myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myButton setBackgroundColor:[UIColor redColor]];
        [_myButton setTitle:@"测试" forState:UIControlStateNormal];
        [_myButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myButton;
}
@end
