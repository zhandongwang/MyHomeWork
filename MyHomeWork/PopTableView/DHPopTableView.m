//
//  DHPopTableView.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/9.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHPopTableView.h"
#import "DHPopTableViewStyle.h"
#import "DHPopSectionHeaderView.h"

static NSString * const cellIdentifier = @"cellIdentifier";
static NSString * const sectionHeaderIdentifier = @"sectionHeaderIdentifier";

@interface DHPopTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *maskBgView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *edgeButton;
@property (nonatomic, assign) CGRect containerFrame;
@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, strong) DHPopTableViewStyle *style;

@property (nonatomic, copy) NSDictionary *dataSource;
@property (nonatomic, copy) NSArray *sectionData;

@end

@implementation DHPopTableView

- (instancetype)initWithContainerViewFrame:(CGRect)containerFrame tableViewHeight:(CGFloat)tableViewHeight style:(DHPopTableViewStyle *)style{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        _containerFrame = containerFrame;
        _tableViewHeight = tableViewHeight;
        _style = style;
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.maskBgView];
    [self addSubview:self.containerView];
    
    [self.containerView addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView.mas_centerX);
        make.centerY.mas_equalTo(self.containerView.mas_centerY);
        make.width.mas_equalTo(self.containerView.mas_width);
        make.height.mas_equalTo(self.tableViewHeight);
        
    }];
    
    if (self.style.edgeButtonImage) {
        [self.containerView addSubview:self.edgeButton];
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
    return self.sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [self.sectionData objectAtIndex:section];
    [self.dataSource valueForKey:sectionTitle];
    
    return [[self.dataSource valueForKey:sectionTitle] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:self.style.cellTextLableFontSize];
        cell.textLabel.textColor = self.style.cellTextLableColor;
    }
    
    NSString *sectionTitle = [self.sectionData objectAtIndex:indexPath.section];
    NSArray *rowsData = [self.dataSource valueForKey:sectionTitle];
    cell.textLabel.text = rowsData[indexPath.row];
    
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSString *title = self.sectionData[section];
    if (title.length == 0) {
        return 0;
    }
    return tableView.rowHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = self.sectionData[section];
    if (title.length == 0) {
        return nil;
    }
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderIdentifier];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:sectionHeaderIdentifier];
        DHPopSectionHeaderView *view = [[DHPopSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), tableView.rowHeight)];
        view.tag = 101;
        view.titleLabel.font = [UIFont systemFontOfSize:self.style.cellTextLableFontSize];
        view.titleLabel.textColor = self.style.cellTextLableColor;
        
        [headerView addSubview:view];
    }
    DHPopSectionHeaderView *sectionHeader = [headerView viewWithTag:101];
    [sectionHeader updateWithTitle:self.sectionData[section]];
    
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

- (void)showWithSectionData:(NSArray *)sectionData fullData:(NSDictionary *)data {

    self.dataSource = data;
    self.sectionData = sectionData;

    self.hidden = NO;
    [UIView animateWithDuration:0.25
     animations:^{
         CGRect rect = self.containerFrame;
         self.containerView.frame = rect;
         self.maskBgView.alpha = self.style.bgAlpha;
         [self layoutIfNeeded];
     }completion:^(BOOL finished) {
         [self.contentTableView reloadData];
     }];
}

- (void)hide {
    [UIView animateWithDuration:0.25
                     animations:^{
                         CGRect rect = self.containerFrame;
                         rect.origin.x = SCREEN_WIDTH;
                         self.containerView.frame = rect;
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

- (UIView *)containerView {
    if (!_containerView) {
        CGRect rect = self.containerFrame;
        rect.origin.x = SCREEN_WIDTH;
        _containerView = [[UIView alloc] initWithFrame:rect];
        //默认设置
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
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
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.tableFooterView = [UIView new];
        
        //默认设置
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.rowHeight = GET_PIXEL(40);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _contentTableView;
}

@end
