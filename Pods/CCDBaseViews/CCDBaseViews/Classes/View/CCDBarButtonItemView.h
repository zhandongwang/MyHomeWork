//
//  CCDBarButtonItemView.h
//  Pods
//
//  Created by 凤梨 on 17/3/31.
//
//

#import <UIKit/UIKit.h>

@interface CCDBarButtonItemView : UIButton

@property (nonatomic, copy) void(^tappedBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title;

@end
