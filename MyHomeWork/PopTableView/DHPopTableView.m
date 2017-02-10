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
@property (nonatomic, assign) CGRect tableViewFrame;
@property (nonatomic, strong) DHPopTableViewStyle *style;
@property (nonatomic, copy) NSArray *dataSource;

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:self.style.cellTextLableFontSize];
        cell.textLabel.textColor = self.style.cellTextLableColor;
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - tableView Delegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerWidth = tableView.bounds.size.width;
    CGFloat headerHeight = tableView.sectionHeaderHeight;

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, headerHeight)];
    headerView.backgroundColor = tableView.backgroundColor;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GET_PIXEL(15), 0, headerWidth - GET_PIXEL(15), headerHeight - GET_PIXEL(.5))];
    titleLabel.textColor = self.style.cellTextLableColor;
    titleLabel.font = [UIFont systemFontOfSize:self.style.cellTextLableFontSize];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLabel];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(GET_PIXEL(15), headerHeight - GET_PIXEL(.5), headerWidth, GET_PIXEL(.5))];
    bottomLine.backgroundColor = tableView.separatorColor;
    [headerView addSubview:bottomLine];
    
    if (section == 0) {
        titleLabel.text = @"饮料";
    } else if (section == 1) {
        titleLabel.text = @"甜品";
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)showWithData:(NSArray *)data {
    self.dataSource = data;
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

- (UIButton *)edgeButton {
    if (!_edgeButton) {
        _edgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_edgeButton setImage:self.style.edgeButtonImage forState:UIControlStateNormal];
        [_edgeButton addTarget:self action:@selector(edgeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edgeButton;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        CGRect rect = self.tableViewFrame;
        rect.origin.x = SCREEN_WIDTH;
        _contentTableView = [[UITableView alloc] initWithFrame:rect];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.tableFooterView = [UIView new];
        
        //默认设置
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.rowHeight = GET_PIXEL(40);
        _contentTableView.sectionHeaderHeight = _contentTableView.rowHeight;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _contentTableView;
}

@end
