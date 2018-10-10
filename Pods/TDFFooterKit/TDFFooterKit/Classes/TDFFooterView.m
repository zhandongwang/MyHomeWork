//
//  TDFFooterView.m
//  Pods
//
//  Created by tripleCC on 2017/8/25.
//
//

#import "TDFFooterView.h"
//#import "TDFFooterButton.h"

@interface TDFFooterView ()

@end

@implementation TDFFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}

- (void)buttonOnClicked {
    if (self.footer.actionBlock) {
        self.footer.actionBlock();
    }
}

- (void)setFooter:(id<TDFFooterProtocol>)footer {
    _footer = footer;
    
    if ([footer respondsToSelector:@selector(backgroundImage)]) {
        [self.button setBackgroundImage:[footer backgroundImage] forState:UIControlStateNormal];
    }
    
    if ([footer respondsToSelector:@selector(image)]) {
        [self.button setImage:[footer image] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.button.frame = self.bounds;
}
@end
