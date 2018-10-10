//
//  TDFRightSideButton.m
//  Pods
//
//  Created by happyo on 2017/8/16.
//
//

#import "TDFRightSideButton.h"

@interface TDFRightSideButton ()

@property (nonatomic, strong) UIButton *backgroudButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation TDFRightSideButton

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithFrame:CGRectMake(0, 0, 40, 70)];
    
    if (self) {
        [self addSubview:self.backgroudButton];
        
        [self addSubview:self.titleLabel];
        
        self.titleLabel.text = title;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithTitle:@""];
}

#pragma mark -- Actions --

- (void)buttonClicked
{
    if (self.clickedBlock) {
        if (self.dismissBlock) {
            self.dismissBlock();
        }
        self.clickedBlock();
    }
}

#pragma mark -- Getters && Setters --

- (UIButton *)backgroudButton
{
    if (!_backgroudButton) {
        _backgroudButton = [[UIButton alloc] initWithFrame:self.bounds];
        [_backgroudButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_backgroudButton setBackgroundImage:[UIImage imageNamed:@"core_right_side_background"] forState:UIControlStateNormal];
    }
    
    return _backgroudButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 30, 15)];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

@end
