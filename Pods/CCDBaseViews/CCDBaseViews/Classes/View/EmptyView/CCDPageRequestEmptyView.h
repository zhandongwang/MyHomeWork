//
//  CCDPageRequestEmptyView.h
//  Pods
//
//  Created by 凤梨 on 2017/8/16.
//
//

#import <UIKit/UIKit.h>

@interface CCDPageRequestEmptyView : UIView

NS_ASSUME_NONNULL_BEGIN

- (instancetype)initWithFrame:(CGRect)frame image:(nullable UIImage *)image title:(NSString *)title;

- (void)updateWithImage:(nullable UIImage *)image title:(nullable NSString *)title;

NS_ASSUME_NONNULL_END
@end
