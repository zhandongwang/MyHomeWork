//
// Created by huanghou  on 2017/7/19.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CCDBarButtonItemAction)(void);

@interface CCDBarButtonItem : UIBarButtonItem
@property(nonatomic, weak) UIViewController       *delegate;
@property(nonatomic, strong) UIButton             *button;
@property(nonatomic, copy) CCDBarButtonItemAction blockAction;

- (id)initWithDelegate:(UIViewController *)target isBack:(BOOL)isBack title:(NSString *)title;

- (id)initWithTitle:(NSString *)title;

- (id)initWithTitle:(NSString *)title handler:(CCDBarButtonItemAction)action;

- (id)initWithImage:(UIImage *)image;

- (void)setBlockAction:(CCDBarButtonItemAction)blockAction;

@end