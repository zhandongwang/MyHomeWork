//
//  DHPopSectionHeaderView.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHPopSectionHeaderView : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *bottomLine;

- (void)updateWithTitle:(NSString *)title;

@end
