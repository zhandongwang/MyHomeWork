//
//  TDFRootViewController+TitleLabel.m
//  Pods
//
//  Created by Arlen on 2017/3/24.
//
//

#import "TDFRootViewController+TitleLabel.h"
#import <objc/runtime.h>
#import "NSBundle+Language.h"
#import "UIColor+tdf_standard.h"

@implementation UIViewController (TitleLabel)

@dynamic titleLabel;

- (void)addTitleobserver
{
    if (![NSBundle isEnglishLanguage]) {
        return;
    }
    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    self.titleLabel.text = self.title;
}

- (void)removeTitleObserver
{
    if (![NSBundle isEnglishLanguage]) {
        return;
    }
    if (self.titleLabel) {
        [self removeObserver:self forKeyPath:@"title"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (![NSBundle isEnglishLanguage]) {
        return;
    }
    if ([keyPath isEqualToString:@"title"]) {
        self.titleLabel.text    =   change[NSKeyValueChangeNewKey];
    }
}


- (UILabel *)titleLabel
{
    UILabel *label = objc_getAssociatedObject(self, "titlelabel");
    if (!label) {
        UILabel *label  =   [[UILabel  alloc] init];
        
        float scale = [UIScreen mainScreen].bounds.size.width / 375.0;
        label.frame   =   CGRectMake(97, 0, 182.5 * scale, 44);

        label.textColor =   [UIColor tdf_hex_333333];
        label.textAlignment =   NSTextAlignmentCenter;
        label.numberOfLines =   0;
        self.navigationItem.titleView   =   label;
        objc_setAssociatedObject(self, "titlelabel", label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

@end
