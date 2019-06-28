//
//  WZDChildViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/8/28.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLUIKitViewController.h"
#import "FLCustomView.h"


@interface FLUIKitViewController ()

@property (nonatomic, strong) FLCustomView *customView;
@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation FLUIKitViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.customView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (FLCustomView *)customView {
    if (!_customView) {
        _customView = [[FLCustomView alloc] initWithFrame:CGRectMake(100, 200, 300, 500)];
    }
    return _customView;
}


@end
