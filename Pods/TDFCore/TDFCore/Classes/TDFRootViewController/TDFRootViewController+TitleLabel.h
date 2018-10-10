//
//  TDFRootViewController+TitleLabel.h
//  Pods
//
//  Created by Arlen on 2017/3/24.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (TitleLabel)

//英文状态下某些标题过长的情况下，需要自动换行。所以，不能直接使用title来显示标题

@property (nonatomic, strong) UILabel *titleLabel;

- (void)addTitleobserver;     //添加监听

- (void)removeTitleObserver;    //移除监听

@end
