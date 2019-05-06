//
//  FLCTViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCTViewController.h"
#import <Masonry.h>
#import <CoreText/CoreText.h>
#import "FLCTView.h"
#import "CTDisplayView.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"
#import "UIView+CTFrame.h"

@interface FLCTViewController ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) FLCTView *ctView;
@property (nonatomic, strong) CTDisplayView *ctDisplayView;

@end

@implementation FLCTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Core Text";
    
//    CTDisplayView *dispaleView = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
//    dispaleView.center = CGPointMake(self.view.center.x, self.view.center.y-100);
//    dispaleView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:dispaleView];
//
//
//    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
//    config.width = dispaleView.width;
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"JsonTemplate" ofType:@"json"];
//
//    //创建绘制数据实例
//    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
//    dispaleView.data = data;
//    dispaleView.height = data.height;
//    dispaleView.backgroundColor = [UIColor yellowColor];
    
    
    
    [self.view addSubview:self.ctView];
    [self.ctView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame), 300));
    }];
//    [self.view addSubview:self.textLabel];
//    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame), 300));
//    }];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"This is a test of characterAttr. 中文字符" attributes:nil];
    CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 40, NULL);
    [str addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, 4)];
    
    long number = 20;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [str addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, 4)];
    
    long number2 = 10;
    CFNumberRef num2 = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number2);
    [str addAttribute:(id)kCTKernAttributeName value:(__bridge id)num2 range:NSMakeRange(10, 4)];
 
    
    self.textLabel.attributedText = str;
    
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.backgroundColor = [UIColor yellowColor];
    }
    return _textLabel;
}

- (FLCTView *)ctView {
    if (!_ctView) {
        _ctView = [[FLCTView alloc] init];
        _ctView.backgroundColor = [UIColor whiteColor];
        
    }
    return _ctView;
}

@end
