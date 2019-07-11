//
//  CCDBarButtonItemView.m
//  Pods
//
//  Created by 凤梨 on 17/3/31.
//
//

#import "CCDBarButtonItemView.h"

@interface CCDBarButtonItemView ()
@end

@implementation CCDBarButtonItemView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        [self setups];
    }
    return self;
}

- (void)setups {
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.adjustsImageWhenHighlighted = NO;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
}

@end
