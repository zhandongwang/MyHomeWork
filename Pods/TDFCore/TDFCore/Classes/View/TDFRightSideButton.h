//
//  TDFRightSideButton.h
//  Pods
//
//  Created by happyo on 2017/8/16.
//
//

#import <UIKit/UIKit.h>

@interface TDFRightSideButton : UIView

@property (nonatomic, strong) void (^clickedBlock)();

@property (nonatomic, strong) void (^dismissBlock)();

- (instancetype)initWithTitle:(NSString *)title;

@end
