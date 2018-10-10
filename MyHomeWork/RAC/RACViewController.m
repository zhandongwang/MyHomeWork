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

@interface RACViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UILabel *resultLabel;

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    DHUserModel *model = [[DHUserModel alloc] init];
    
    @weakify(self);
    [[[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(__kindof UIControl * _Nullable x) {
          self.loginButton.enabled = NO;
          self.resultLabel.hidden = YES;
      }]
      flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
        @strongify(self);
        return [self signInSignal];
      }]
      subscribeNext:^(NSNumber  *signInResult) {
        @strongify(self);
        self.loginButton.enabled = YES;
        BOOL success = [signInResult boolValue];
        self.resultLabel.hidden = success;
        if (success) {
            NSLog(@"SignIN Succeed!");
        }
    }];
    
    RACSignal *validUserNameSignal = [self.userNameTextField.rac_textSignal map:^id _Nullable(NSString * value) {
        return @([self isValaidUserName:value]);
    }];
    
    RACSignal *validPwdSignal = [self.pwdTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([self isValaidPassword:value]);
    }];
    
    RACSignal *signUpSignal = [RACSignal combineLatest:@[validUserNameSignal,validPwdSignal] reduce:^id(NSNumber *userNameValid, NSNumber *pwdValid){
        return @([userNameValid boolValue] && [pwdValid boolValue]);
    }];
    
    RAC(self.loginButton, backgroundColor) = [signUpSignal map:^id _Nullable(NSNumber  *signupActive) {
      return [signupActive boolValue] ? [UIColor redColor] : [UIColor grayColor];
    }];
        
    RAC(self.userNameTextField, backgroundColor) = [validUserNameSignal map:^id _Nullable(NSNumber  *value) {
        return [value boolValue] ? [UIColor greenColor] : [UIColor yellowColor];
    }];
    
    RAC(self.pwdTextField, backgroundColor) = [validPwdSignal map:^id _Nullable(NSNumber  *value) {
        return [value boolValue] ? [UIColor greenColor] : [UIColor yellowColor];
    }];
}

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
    
    [self.view addSubview:self.pwdTextField];
    [self.pwdTextField setFrame:CGRectMake(100, 250, 200, 40)];
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
        [_loginButton setBackgroundColor:[UIColor redColor]];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
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


@end
