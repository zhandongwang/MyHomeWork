//
//  CCDPickerView.m
//  Pods
//
//  Created by 凤梨 on 17/4/25.
//
//

#import "CCDPickerView.h"
@import Masonry;
@import CCDCore;
NSString * const kCCDPickerViewItemName = @"kCCDPickerViewItemName";
NSString * const kCCDPickerViewItemId = @"kCCDPickerViewItemId";

static CGFloat const kWrapperViewHeight = 255;

@interface CCDPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *wrapperView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIView *horLine;
@property (nonatomic, strong) UIView *verLine;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, copy) NSArray <NSDictionary *> *dataArray;
@property (nonatomic, copy) NSDictionary *selectedItem;
@end

@implementation CCDPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStyle];
        [self setupSubViews];
        [self setupLayout];
    }
    return self;
}

- (void)setupStyle {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tapGes];
}

- (void)setupSubViews {
    [self addSubview:self.wrapperView];
    [self.wrapperView addSubview:self.titleLabel];
    [self.wrapperView addSubview:self.picker];
    [self.wrapperView addSubview:self.horLine];
    [self.wrapperView addSubview:self.cancelButton];
    [self.wrapperView addSubview:self.verLine];
    [self.wrapperView addSubview:self.confirmButton];
    if ([self.delegate respondsToSelector:@selector(CCDPickerViewRowHeight)]) {
        self.rowHeight = [self.delegate CCDPickerViewRowHeight];
    } else {
        self.rowHeight = 42;
    }
}

- (void)setupLayout {
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(kWrapperViewHeight * SCREEN_HEIGHT_SCALE);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.wrapperView);
        make.height.mas_equalTo(45);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.wrapperView);
        make.height.mas_equalTo(44);
        make.right.equalTo(self.verLine.mas_left);
    }];
    [self.verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.wrapperView.mas_bottom);
        make.height.equalTo(self.cancelButton.mas_height);
        make.width.mas_equalTo(OnePixel);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.wrapperView);
        make.height.equalTo(self.cancelButton.mas_height);
        make.width.equalTo(self.cancelButton.mas_width);
        make.left.equalTo(self.verLine.mas_right);
    }];
    [self.horLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.wrapperView);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.cancelButton.mas_top);
    }];

    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wrapperView).offset(12);
        make.right.equalTo(self.wrapperView).offset(-12);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.bottom.equalTo(self.horLine.mas_top).offset(-12);
    }];

}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.rowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    CCDPickerRowView *rowView = [[CCDPickerRowView alloc] initWithFrame:CGRectMake(0, 0, pickerView.ccd_viewWidth ,self.rowHeight + 3)];//加3可以去除不明原因的白线
    [rowView updateWithText:self.dataArray[row][kCCDPickerViewItemName]];
    
    return rowView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedItem = self.dataArray[row];
    
}
#pragma mark - public methods

- (void)updateWithDataArray:(NSArray <NSDictionary *> *)dataArray title:(NSString *)title {
    [self updateWithDataArray:dataArray title:title selectedItemIndex:0];
}
- (void)updateWithDataArray:(NSArray <NSDictionary *> *)dataArray title:(NSString *)title selectedItemIndex:(NSInteger )index {
    if (dataArray.count <= 0) {
        return;
    }
    self.dataArray = dataArray;
    if (title.length) {
        self.titleLabel.text = title;
    }
    if (index >= 0 && index < dataArray.count) {
        self.selectedItem = dataArray[index];
        [self.picker selectRow:index inComponent:0 animated:NO];
    } else {
        self.selectedItem = dataArray[0];
    }
   
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)show {
    self.wrapperView.frame = CGRectMake(0, self.ccd_viewBottom, self.ccd_viewWidth, kWrapperViewHeight * SCREEN_HEIGHT_SCALE);
    self.hidden = NO;
    [UIView animateWithDuration:0.25
                     animations:^{
                         CGRect rect = self.frame;
                         self.wrapperView.frame = CGRectMake(0, self.ccd_viewBottom - kWrapperViewHeight * SCREEN_HEIGHT_SCALE, self.ccd_viewWidth, kWrapperViewHeight * SCREEN_HEIGHT_SCALE);
                         self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
                         [self layoutIfNeeded];
                     }completion:^(BOOL finished) {
                         
                     }];

}

#pragma mark - event handle

- (void)hide {
    [UIView animateWithDuration:0.25
                     animations:^{
                         CGRect rect = self.wrapperView.frame;
                         rect.origin.y = self.ccd_viewHeight;
                         self.wrapperView.frame = rect;
                         self.backgroundColor = [UIColor clearColor];
                         [self layoutIfNeeded];
                     }completion:^(BOOL finished) {
                         self.hidden = YES;
                         [self removeFromSuperview];
                     }];
}

- (void)cancelButtonTapped:(UIButton *)sender {
    [self hide];
}

- (void)confirmButtonTapped:(UIButton *)sender {
    if (self.confirmBlock) {
        self.confirmBlock(self.selectedItem);
    }
    self.hidden = YES;
    [self removeFromSuperview];
}

#pragma mark - accessors

- (UIView *)wrapperView {
    if (!_wrapperView) {
        _wrapperView = [UIView new];
        _wrapperView.backgroundColor = [UIColor whiteColor];
    }
    return _wrapperView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel ccd_createLabelWithFont:[UIFont systemFontOfSize:20] textColor:CCDColor333333 textAlign:NSTextAlignmentCenter];
        _titleLabel.text = CCDLocalizedString(@"reasons", @"请选择原因");
    }
    return _titleLabel;
}

- (UIPickerView *)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _picker.dataSource = self;
        _picker.delegate = self;
        _picker.backgroundColor = [UIColor ccd_colorWithHexValue:0xEAE6E6];
    }
    return _picker;
}

- (UIView *)horLine {
    if (!_horLine) {
        _horLine = [UIView ccd_createLineWithColor:CCDColorE6E6E6];
    }
    return _horLine;
}


- (UIView *)verLine {
    if (!_verLine) {
        _verLine = [UIView ccd_createLineWithColor:CCDColorE6E6E6];
    }
    return _verLine;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:CCDLocalizedString(@"cancel", @"取消") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:CCDColor666666 forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:CCDLocalizedString(@"confirm", @"确定") forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor ccd_colorWithHexValue:0x0076FF] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _confirmButton.backgroundColor = [UIColor whiteColor];
        [_confirmButton addTarget:self action:@selector(confirmButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end


@interface CCDPickerRowView  ()

@property (nonatomic, strong) UILabel *rowLabel;

@end

@implementation CCDPickerRowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CCDColorD8D8D8;
        [self addSubview:self.rowLabel];
        [self.rowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)updateWithText:(NSString *)text {
    self.rowLabel.text = text;
}

- (UILabel *)rowLabel {
    if (!_rowLabel) {
        _rowLabel = [UILabel new];
        _rowLabel.font = [UIFont boldSystemFontOfSize:18];
        _rowLabel.textColor = CCDColor333333;
        _rowLabel.textAlignment = NSTextAlignmentCenter;
        _rowLabel.backgroundColor = CCDColorD8D8D8;
    }
    return _rowLabel;
}

@end

