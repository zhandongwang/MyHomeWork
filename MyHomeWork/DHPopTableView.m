//
//  DHPopTableView.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/9.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHPopTableView.h"
#import "DHPopTableViewStyle.h"

static NSString * const cellIdentifier = @"cellIdentifier";

@interface DHPopTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *maskBgView;
@property (nonatomic, strong) UIButton *edgeButton;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, assign) CGRect tableViewFrame;
@property (nonatomic, strong) DHPopTableViewStyle *style;
@property (nonatomic, copy) NSArray *rowsData;
@property (nonatomic, copy) NSArray *sectionsData;

@end

@implementation DHPopTableView

- (instancetype)initWithTableViewFrame:(CGRect)frame style:(DHPopTableViewStyle *)style{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        _tableViewFrame = frame;
        _style = style;
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.maskBgView];
    [self addSubview:self.contentTableView];
    if (self.style.edgeButtonImage) {
        [self addSubview:self.edgeButton];
        [self.edgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentTableView.mas_left);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
}

- (void)dealloc {
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionsData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:self.style.cellTextLableFontSize];
        cell.textLabel.textColor = self.style.cellTextLableColor;
    }
    
    cell.textLabel.text = self.rowsData[indexPath.row];
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionsData[section];
}
#pragma mark - tableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    [self hide];
}

#pragma mark - event handle

- (void)maskBgViewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self hide];
}

- (void)edgeButtonTapped {
    [self hide];
}

#pragma mark - methods 

- (void)showWithData:(NSDictionary *)data {
    
    self.hidden = NO;
    [UIView animateWithDuration:0.25
     animations:^{
         CGRect rect = self.tableViewFrame;
         self.contentTableView.frame = rect;
         self.maskBgView.alpha = self.style.bgAlpha;
         [self layoutIfNeeded];
     }completion:^(BOOL finished) {
         [self.contentTableView reloadData];
     }];
}

- (void)hide {
    [UIView animateWithDuration:0.25
                     animations:^{
                         CGRect rect = self.tableViewFrame;
                         rect.origin.x = SCREEN_WIDTH;
                         self.contentTableView.frame = rect;
                         self.maskBgView.alpha = 0;
                         [self layoutIfNeeded];
                     }completion:^(BOOL finished) {
                         self.hidden = YES;
                         if (self.hiddenBlock) {
                             self.hiddenBlock();
                         }
                     }];
}

#pragma mark - accessors

- (UIView *)maskBgView {
    if (!_maskBgView) {
        _maskBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskBgView.backgroundColor = [UIColor blackColor];
        _maskBgView.alpha = self.style.bgAlpha;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskBgViewTapped:)];
        [_maskBgView addGestureRecognizer:tap];
    }
    return _maskBgView;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        CGRect rect = self.tableViewFrame;
        rect.origin.x = SCREEN_WIDTH;
        _contentTableView = [[UITableView alloc] initWithFrame:rect];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.tableFooterView = [UIView new];
        
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.alpha = self.style.tableViewAlpha;
        _contentTableView.rowHeight = self.style.tableViewRowHeight;
        _contentTableView.sectionHeaderHeight = self.style.sectionHeaderHeight;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _contentTableView.separatorColor = self.style.separatorColor;
        
    }
    return _contentTableView;
}

- (UIButton *)edgeButton {
    if (!_edgeButton) {
        _edgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_edgeButton setImage:self.style.edgeButtonImage forState:UIControlStateNormal];
        [_edgeButton addTarget:self action:@selector(edgeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edgeButton;
}
@end
