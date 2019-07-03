//
//  WZDChildViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/8/28.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLUIKitViewController.h"
#import "FLCustomView.h"
#import "FLCustomButton.h"
@interface FLUIKitViewController ()

@property (nonatomic, strong) FLCustomView *customView;
@property (nonatomic, strong) FLCustomButton *customButton;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSString *name;

@end

@implementation FLUIKitViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.customView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    
    self.customView = [[FLCustomView alloc] initWithFrame:CGRectMake(100, 150, 50, 50)];
    self.customView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.customView];
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testGes)];
//    [self.customView addGestureRecognizer:gesture];
    
    
    self.customButton = [[FLCustomButton alloc] initWithFrame:CGRectMake(100, 250, 100, 30)];
    [self.customButton setTitle:@"测试" forState:UIControlStateNormal];
    [self.customButton setBackgroundColor:[UIColor redColor]];
    [self.customButton addTarget:self action:@selector(customButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customButton];
    
    NSLog(@"%@",[self.customView class]);
    [self.customView addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"%@",[self.customView class]);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__func__);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}



- (void)customButtonTapped {
    [self.customButton setFrame: CGRectMake(200, 250, 100, 30)];
    [self.view setNeedsLayout];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200, 300, 100, 30)];
//    label.text = @"ccccc";
//    label.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:label];
}

- (void)tapAction {
     NSLog(@"base view tapAction");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"=========> base view touchs Began");
//}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"=========> base view touchs Moved");
//}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"=========> base view touchs Ended");
//}
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"=========> base view touchs Cancelled");
//}

@end
