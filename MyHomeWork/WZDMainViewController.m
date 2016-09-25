//
//  WZDMainViewController.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "WZDMainViewController.h"

@interface WZDMainViewController ()

@property (nonatomic, strong) UIView *customView;

@end

@implementation WZDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.customView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)customView
{
    if (!_customView) {
        _customView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _customView.backgroundColor = [UIColor redColor];
    }
    return _customView;
}

@end
