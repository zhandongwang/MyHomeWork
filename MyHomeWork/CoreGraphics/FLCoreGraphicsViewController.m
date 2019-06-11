//
//  FLCoreGraphicsViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/6.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCoreGraphicsViewController.h"
#import "FLCoreGraphicsCutomView.h"
#import "FLCoreGraphicsPushButton.h"

@interface FLCoreGraphicsViewController ()

@property (nonatomic, strong) FLCoreGraphicsCutomView *customView;
@property (nonatomic, strong) FLCoreGraphicsPushButton *pushButton;

@end

@implementation FLCoreGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.pushButton];
    [self.pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(100);
    }];
}


- (FLCoreGraphicsPushButton *)pushButton {
    if (!_pushButton) {
        _pushButton = [[FLCoreGraphicsPushButton alloc] initWithFrame:CGRectZero];
    }
    return _pushButton;
}

@end