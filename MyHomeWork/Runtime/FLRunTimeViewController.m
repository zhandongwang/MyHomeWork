//
//  FLRunTimeViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/13.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLRunTimeViewController.h"
#import "FLRunTimeView.h"
#import "FLCarModel.h"
#import "FLPersonModel.h"


@interface FLRunTimeViewController ()

@property (nonatomic, strong) FLRunTimeView *runTimeView;
@property (nonatomic, copy) void(^runTimeBlock)(void);
@property (nonatomic, strong) FLPersonModel *person;
@property (nonatomic, strong) FLCarModel *car;
@property (nonatomic, strong) NSTimer *timer;



@end

@implementation FLRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.runTimeView];
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadEntry:) object:@"hello thread"];
    thread.name = @"FengliThread";
    [thread start];
    [self makeCar];
}

- (void)threadEntry:(id)param {
    NSLog(@"%@", param);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"in dispatch_async%@",[NSThread currentThread]);
    });
    NSLog(@"out dispatch_async%@",[NSThread currentThread]);
}


- (FLCarModel *)makeCar {
    FLCarModel *car = [FLCarModel new];
    NSLog(@"%@,---%p",car,car);
    return car;
}


- (void)print {
    NSLog(@"test");
}

- (FLRunTimeView *)runTimeView {
    if (!_runTimeView) {
        _runTimeView = [[FLRunTimeView alloc] initWithFrame:self.view.frame];
    }
    return _runTimeView;
}


@end
