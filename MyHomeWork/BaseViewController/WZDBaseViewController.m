//
//  WZDBaseViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/8/28.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "WZDBaseViewController.h"

@interface WZDBaseViewController ()<WZDBaseViewControllerProtocol>

@end

@implementation WZDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.child respondsToSelector:@selector(sendRequest)]) {
        self.child = self;
    }
    
    self.interceptor = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendRequest {
    
}


@end
