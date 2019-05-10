//
//  FLUIKitTableViewCell.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLUIKitTableViewCell : UITableViewCell

- (void)updateWithImageUrl:(NSString *)url name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
