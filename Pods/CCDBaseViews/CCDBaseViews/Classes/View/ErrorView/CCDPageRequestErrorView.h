//
//  CCDPageRequestErrorView.h
//  Pods
//
//  Created by 凤梨 on 17/3/10.
//
//

#import <UIKit/UIKit.h>

//带有一个重试button、一个tipLabel、一个吉祥物的网络请求错误页面

@interface CCDPageRequestErrorView : UIView

@property (nonatomic, strong, readonly) UIButton *actionButton;
@property (nonatomic, strong, readonly) UILabel *tipLabel;
@property (nonatomic, strong, readonly) UIImageView *iconImageView;

@property (nonatomic, copy) void(^actionButtonTappedBlock)(void);
@end
