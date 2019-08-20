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
#import "FLUIKitTableViewController.h"
#import "AFNetworking/AFNetworking.h"
#import <QuartzCore/QuartzCore.h>


static NSString * const kHttpRequestExampleUrl = @"http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&sort_by=popularity.desc&page=1";


@interface FLUIKitViewController ()

@property (nonatomic, strong) FLCustomView *customView;
//@property (nonatomic, strong) FLCustomView *customView2;

@property (nonatomic, strong) FLCustomButton *customButton;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) FLUIKitTableViewController *tableViewController;

@end

@implementation FLUIKitViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addChildVc];
//    [self sendHeaderRequest];
   
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testGes)];
//    [self.customView addGestureRecognizer:gesture];
//
//
    self.customButton = [[FLCustomButton alloc] initWithFrame:CGRectMake(100, 150, 100, 30)];
    [self.customButton setTitle:@"测试" forState:UIControlStateNormal];
    [self.customButton setBackgroundColor:[UIColor redColor]];
    [self.customButton addTarget:self action:@selector(customButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customButton];
//
//    NSLog(@"%@",[self.customView class]);
//    [self.customView addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    NSLog(@"%@",[self.customView class]);
}

- (void)testGes {
    NSLog(@"testGes");
}


- (void)addChildVc{
    [self addChildViewController:self.tableViewController];
    [self.view addSubview:self.tableViewController.view];
    [self.tableViewController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}

-(void)shaperLayerAnimations{
    //图形开始位置的动画
    CABasicAnimation *startAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnim.duration = 5;
    startAnim.fromValue = @(0);
    startAnim.toValue = @(0.6);
    
    //图形结束位置的动画
    CABasicAnimation *endAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnim.duration = 5;
    endAnim.fromValue = @(0.4);
    endAnim.toValue = @(1);
    
    //把两个动画合并，绘制的区域就会不断变动
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[startAnim, endAnim];
    group.duration = 5;
//    group.autoreverses = YES;
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.view.bounds;
    
    //图形是一大一小两个圆相切嵌套
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:CGPointMake(100, 300) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(150, 300) radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [shapeLayer addAnimation:group forKey:@"runningLine"];
    [self.view.layer addSublayer:shapeLayer];
}


- (void)customButtonTapped {
    [self shaperLayerAnimations];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (FLUIKitTableViewController *)tableViewController {
    if (!_tableViewController) {
        _tableViewController = [FLUIKitTableViewController new];
    }
    return _tableViewController;
}
@end
