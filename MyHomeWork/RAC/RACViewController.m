//
//  RACViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/8/27.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "DHUserModel.h"
#import "RACViewModel.h"
@interface RACViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UILabel *pwdLabel;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) RACViewModel *viewModel;
@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setupSubViews];
//
//    self.viewModel = [[RACViewModel alloc] init];
//    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
//    RAC(self.viewModel,password) = self.pwdTextField.rac_textSignal;
//
//    self.loginButton.rac_command = self.viewModel.loginCommand;
//    @weakify(self);
//    [[self.viewModel.loginCommand executionSignals] subscribeNext:^(RACSignal  *x) {
//        @strongify(self)
//        [x subscribeNext:^(NSString*  value) {
//            NSLog(@"%@",value);
//        }];
//    }];
    
//    RACSignal *A = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"A"];
//
//        return  nil;
//    }];
//    RACSignal *B = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"B"];
//        return  nil;
//    }];
    

//    RACSignal *combine = [A combineLatestWith:B];
//    [combine subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    RACSubject *sA = [RACSubject subject];
    RACSubject *sB = [RACSubject subject];

//    RACSignal *sThen = [sA then:^RACSignal * _Nonnull{
//        return sB;
//    }];
    
//    [sThen subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    
//    RACSignal *sCombine = [sA zipWith:sB];
//    [sCombine subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    [sA sendNext:@"sA"];
    [sA sendNext:@"sAA"];
    [sB sendNext:@"sB"];
    [sB sendNext:@"sBB"];
    
//    @weakify(self);
//    [[[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
//      doNext:^(__kindof UIControl * _Nullable x) {
//          self.loginButton.enabled = NO;
//          self.resultLabel.hidden = YES;
//      }]
//      flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
//        @strongify(self);
//        return [self signInSignal];
//      }]
//      subscribeNext:^(NSNumber  *signInResult) {
//        @strongify(self);
//        self.loginButton.enabled = YES;
//        BOOL success = [signInResult boolValue];
//        self.resultLabel.hidden = success;
//        if (success) {
//            NSLog(@"SignIN Succeed!");
//        }
//    }];
//
//    RACSignal *validUserNameSignal = [self.userNameTextField.rac_textSignal map:^id _Nullable(NSString * value) {
//        return @([self isValaidUserName:value]);
//    }];
//
//    RACSignal *validPwdSignal = [self.pwdTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//        return @([self isValaidPassword:value]);
//    }];
//
//    RACSignal *signUpSignal = [RACSignal combineLatest:@[validUserNameSignal,validPwdSignal] reduce:^id(NSNumber *userNameValid, NSNumber *pwdValid){
//        return @([userNameValid boolValue] && [pwdValid boolValue]);
//    }];
//
//    RAC(self.loginButton, backgroundColor) = [signUpSignal map:^id _Nullable(NSNumber  *signupActive) {
//      return [signupActive boolValue] ? [UIColor redColor] : [UIColor grayColor];
//    }];
//
//    RAC(self.userNameTextField, backgroundColor) = [validUserNameSignal map:^id _Nullable(NSNumber  *value) {
//        return [value boolValue] ? [UIColor greenColor] : [UIColor yellowColor];
//    }];
//
//    RAC(self.pwdTextField, backgroundColor) = [validPwdSignal map:^id _Nullable(NSNumber  *value) {
//        return [value boolValue] ? [UIColor greenColor] : [UIColor yellowColor];
//    }];
}

- (RACSignal *)simpleSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"singnal was subscrbed");
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        [subscriber sendError:nil];
        return nil;
    }];
}

- (void)test {
    RACSignal *coldSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"Cold signal be subscribed.");
        [[RACScheduler mainThreadScheduler] afterDelay:1.5 schedule:^{
            [subscriber sendNext:@"A"];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext:@"B"];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:5 schedule:^{
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
    //创建订阅者
    [coldSignal subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    } completed:^{
        
    }];
    
    
//    RACSubject *subject = [RACSubject subject];
//    NSLog(@"Subject created.");
//
//    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
//        //订阅冷信号, 事件通过subject发送出去
//        [coldSignal subscribe:subject];
//    }];
//
//    [subject subscribeNext:^(id x) {
//        NSLog(@"Subscriber 1 recieve value:%@.", x);
//    }];
}

//- (void)testSubject {
//    RACSubject *subject = [RACSubject subject];
//    RACSubject *replaySubject = [RACReplaySubject subject];
//    [[RACScheduler mainThreadScheduler] afterDelay:0.1
//                                          schedule:^{
//                                              // Subscriber 1
//                                              [subject subscribeNext:^(id x) {
//                                                  NSLog(@"Subscriber 1 get a next value: %@ from subject", x);
//                                              }];
//                                              [replaySubject subscribeNext:^(id x) {
//                                                  NSLog(@"Subscriber 1 get a next value: %@ from replay subject", x);
//                                              }];
//
//                                              // Subscriber 2
//                                              [subject subscribeNext:^(id x) {
//                                                  NSLog(@"Subscriber 2 get a next value: %@ from subject", x);
//                                              }];
//                                              [replaySubject subscribeNext:^(id x) {
//                                                  NSLog(@"Subscriber 2 get a next value: %@ from replay subject", x);
//                                              }];
//                                          }];
//    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
//        [subject sendNext:@"send package 1"];
//        [replaySubject sendNext:@"send package 1"];
//    }];
//
//    [[RACScheduler mainThreadScheduler] afterDelay:1.1
//                                          schedule:^{
//                                              // Subscriber 3
//                                              [subject subscribeNext:^(id x) {
//                                                  NSLog(@"Subscriber 3 get a next value: %@ from subject", x);
//                                              }];
//                                              [replaySubject subscribeNext:^(id x) {
//                                                  NSLog(@"Subscriber 3 get a next value: %@ from replay subject", x);
//                                              }];
//
//                                              // Subscriber 4
//                                              [subject subscribeNext:^(id x) {
//                                                  NSLog(@"Subscriber 4 get a next value: %@ from subject", x);
//                                              }];
//                                              [replaySubject subscribeNext:^(id x) {
//                                                  NSLog(@"Subscriber 4 get a next value: %@ from replay subject", x);
//                                              }];
//                                          }];
//    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
//        [subject sendNext:@"send package 2"];
//        [replaySubject sendNext:@"send package 2"];
//    }];



- (RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self singInWithUserName:self.userNameTextField.text pwd:self.pwdTextField.text block:^(BOOL success){
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (void)setupSubViews {
    [self.view addSubview:self.loginButton];
    [self.loginButton setFrame:CGRectMake(100, 400, 200, 40)];
    
    [self.view addSubview:self.resultLabel];
    [self.resultLabel setFrame:CGRectMake(100, 500, 200, 40)];
    self.resultLabel.hidden = YES;
    
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField setFrame:CGRectMake(100, 200, 200, 40)];
    [self.view addSubview:self.userNameLabel];
    [self.userNameLabel setFrame:CGRectMake(30, 200, 60, 40)];
    
    
    [self.view addSubview:self.pwdTextField];
    [self.pwdTextField setFrame:CGRectMake(100, 250, 200, 40)];
    [self.view addSubview:self.pwdLabel];
    [self.pwdLabel setFrame:CGRectMake(30, 250, 60, 40)];
}

- (void)singInWithUserName:(NSString *)userName pwd:(NSString *)pwd block:(void(^)(BOOL success))block {
    NSLog(@"Login...");
    if (self.pwdTextField.text.length > 12) {
        block(YES);
    } else {
        block(NO);
    }
}

- (BOOL)isValaidUserName:(NSString *)text {
    return text.length > 5;
}

- (BOOL)isValaidPassword:(NSString *)pwd {
    
    return pwd.length >5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - accessors

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"Action" forState:UIControlStateNormal];
//        [_loginButton setBackgroundColor:[UIColor redColor]];
        [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        
    }
    return _loginButton;
}

- (UITextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField.backgroundColor = [UIColor grayColor];
        _userNameTextField.delegate = self;
        _userNameTextField.placeholder = @"用户名";
        _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _userNameTextField;
}

- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.delegate = self;
        _pwdTextField.placeholder = @"密码";
        _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _pwdTextField;
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.backgroundColor = [UIColor yellowColor];
        _resultLabel.font = [UIFont systemFontOfSize:14];
        _resultLabel.textColor = [UIColor blueColor];
        _resultLabel.text = @"登录失败...";
    }
    return _resultLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont systemFontOfSize:14];
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.text = @"用户名";
    }
    return _userNameLabel;
}

- (UILabel *)pwdLabel {
    if (!_pwdLabel) {
        _pwdLabel = [[UILabel alloc] init];
        _pwdLabel.font = [UIFont systemFontOfSize:14];
        _pwdLabel.textColor = [UIColor blackColor];
        _pwdLabel.text = @"密码";
    }
    return _pwdLabel;
}

@end
