//
//  WZDMainViewController.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "WZDMainViewController.h"
#import "WZDCustomView.h"

#define ImageName @"biye"

@interface WZDMainViewController ()<JSObjcDelegate, UIWebViewDelegate>

@property (nonatomic, strong) WZDCustomView *customView;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UIWebView *webView;


@end

@implementation WZDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.view addSubview:self.customView];
    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
//   
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 50)];
//    [[UIColor greenColor] setFill];
//    [path fill];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//   
//    UIGraphicsEndImageContext();
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(0, 50, 50, 50);
//    [self.view addSubview:imageView];
    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 50, 50));
//    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextFillPath(context);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(0, 50, 50, 50);
//    [self.view addSubview:imageView];
//    [self.view addSubview:self.webView];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testWeb" withExtension:@"html"];
//    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *buttonTitle = NSLocalizedString(@"CallCamera", nil);
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.image = [UIImage imageNamed:NSLocalizedString(ImageName, nil)];
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"Toyun"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常:%@", exceptionValue);
    };
    
}

- (void)callCamera {
    NSLog(@"Objc callCamera");
    JSValue *picCallBack = self.jsContext[@"picCallback"];
    [picCallBack callWithArguments:@[@"photos"]];
}

- (void)share:(NSString *)shareString {
    NSLog(@"Objc share:%@", shareString);
    JSValue *shareCallBack = self.jsContext[@"shareCallback"];
    [shareCallBack callWithArguments:nil];
}

#pragma mark - accessors

- (WZDCustomView *)customView
{
    if (!_customView) {
        _customView = [[WZDCustomView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _customView.center = self.view.center;
    
    }
    return _customView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.delegate = self;
    }
    return _webView;
}

@end
