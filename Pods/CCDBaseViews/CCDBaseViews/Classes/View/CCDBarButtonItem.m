//
// Created by huanghou  on 2017/7/19.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "CCDBarButtonItem.h"


@implementation CCDBarButtonItem {

}

- (id)initWithDelegate:(UIViewController *)target isBack:(BOOL)isBack title:(NSString *)title {
    if ((self = [super initWithTitle:title
                               style:UIBarButtonItemStylePlain
                              target:self
                              action:isBack ? @selector(pop) : @selector(dismiss)])) {
        self.delegate   = target;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    return [self initWithTitle:title handler:NULL];
}

- (id)initWithTitle:(NSString *)title handler:(CCDBarButtonItemAction)action {
    self = [super initWithTitle:title
                          style:UIBarButtonItemStylePlain
                         target:self
                         action:@selector(handleAction:)];
    if (self) {
        self.blockAction = action;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image
                          style:UIBarButtonItemStylePlain
                         target:self
                         action:@selector(handleAction:)];
    if (self) {
    }
    return self;
}

- (void)handleAction:(id)sender {
    if (self.blockAction) {
        self.blockAction();
    }
}

- (void)pop {
    [self.delegate.navigationController popViewControllerAnimated:YES];
}

- (void)dismiss {
    [self.delegate dismissViewControllerAnimated:YES completion:NULL];
}
@end