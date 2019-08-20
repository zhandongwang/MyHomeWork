//
//  WZDCustomView.h
//  MyHomeWork
//
//  Created by 凤梨 on 16/12/17.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLCustomButton.h"
@interface FLCustomView : UIView

- (void)updateName:(NSString *)name;
@property (nonatomic, strong) FLCustomButton *childButton;

@end
