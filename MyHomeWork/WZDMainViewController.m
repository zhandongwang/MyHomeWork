//
//  WZDMainViewController.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "WZDMainViewController.h"
#import "WZDCustomView.h"
#import "DHPopTableView.h"
#import "DHPopTableViewStyle.h"
#import "DHMessageKinds.h"
#import "DHMessageModel.h"

#import "DHAllOrderModel.h"
#import "DHOrderKind.h"
#import "DHOrderModel.h"


#define ImageName @"biye"

@interface WZDMainViewController ()<JSObjcDelegate, UIWebViewDelegate>

@property (nonatomic, strong) WZDCustomView *customView;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) DHPopTableView *popTabView;
@property (nonatomic, strong) DHPopTableViewStyle *popTabViewStyle;
@property (nonatomic, strong) NSMutableDictionary *popTableViewDataDict;
@property (nonatomic, strong) NSMutableArray *popTableViewSectionData;

@property (nonatomic, strong) UIButton *floaButton;

@end

@implementation WZDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
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
    
    NSString *buttonTitle = @"分类展示";// NSLocalizedString(@"CallCamera", nil);
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.image = [UIImage imageNamed:@"test2"]; //[UIImage imageNamed:NSLocalizedString(ImageName, nil)];
    [self.view addSubview:imageView];
    
    
    [self.view addSubview:self.popTabView];
    [self.view addSubview:self.floaButton];
    [self.floaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.centerY.equalTo(self.popTabView.mas_centerY);
    }];
    __weak typeof (self) weakSelf = self;
    self.popTabView.hiddenBlock = ^{
        weakSelf.floaButton.hidden = NO;
    };
    self.popTableViewDataDict = [[NSMutableDictionary alloc] initWithCapacity:5];
    self.popTableViewSectionData = @[].mutableCopy;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadPopViewData];
//    [self loadMessageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnTapped {
    [self.popTabView showWithSectionData:self.popTableViewSectionData fullData:self.popTableViewDataDict];
}

- (void)floaButtonTapped {
    self.floaButton.hidden = YES;
    [self.popTabView showWithSectionData:self.popTableViewSectionData fullData:self.popTableViewDataDict];
}

- (void)loadMessageData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"message" withExtension:@".json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    DHMessageKinds *kinds = [DHMessageKinds yy_modelWithJSON:data];
    [self.popTableViewSectionData addObject:@""];
    
    NSMutableArray *msgTitlesArray = [[NSMutableArray alloc] initWithCapacity:5];
    [kinds.messages enumerateObjectsUsingBlock:^(DHMessageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [msgTitlesArray addObject:obj.title];
    }];
    
    [self.popTableViewDataDict setValue:msgTitlesArray forKey:@""];
}


- (void)loadPopViewData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"popData" withExtension:@".json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    DHAllOrderModel *allOrderModel = [DHAllOrderModel yy_modelWithJSON:data];
    

    for (DHOrderKind *orderKind in allOrderModel.allOrders) {
        NSMutableArray *orderNamesArray = [[NSMutableArray alloc] initWithCapacity:5];
        for (DHOrderModel *orderModel in orderKind.orders) {
            [orderNamesArray addObject:orderModel.name];
        }
        [self.popTableViewDataDict setValue:orderNamesArray forKey:orderKind.title];
        [self.popTableViewSectionData addObject:orderKind.title];
    }
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

- (DHPopTableView *)popTabView {
    if (!_popTabView) {
        CGRect containerViewFrame = CGRectMake(SCREEN_WIDTH*0.7, 0, SCREEN_WIDTH*0.3, SCREEN_HEIGHT);
        
        _popTabView = [[DHPopTableView alloc] initWithContainerViewFrame:containerViewFrame tableViewHeight:280 style:self.popTabViewStyle];
        [_popTabView initSubViews];
        _popTabView.hidden = YES;
    }
    return _popTabView;
}

- (UIButton *)floaButton {
    if (!_floaButton) {
        _floaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_floaButton setImage:[UIImage imageNamed:@"cailei"] forState:UIControlStateNormal];
        [_floaButton addTarget:self action:@selector(floaButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _floaButton;
}

- (DHPopTableViewStyle *)popTabViewStyle {
    if (!_popTabViewStyle) {
        _popTabViewStyle = [[DHPopTableViewStyle alloc] init];
        _popTabViewStyle.bgAlpha = 0.65;
        _popTabViewStyle.containerViewBgColor = [UIColor colorWithWhite:1.0 alpha:0.85];
        _popTabViewStyle.edgeButtonImage = [UIImage imageNamed:@"cailei"];
        _popTabViewStyle.cellTextLableFontSize = 14.0;
        _popTabViewStyle.cellTextLableColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    }
    return _popTabViewStyle;
}

@end
