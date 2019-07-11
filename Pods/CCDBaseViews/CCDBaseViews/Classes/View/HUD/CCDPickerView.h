//
//  CCDPickerView.h
//  Pods
//
//  Created by 凤梨 on 17/4/25.
//
//

#import <UIKit/UIKit.h>

extern NSString * const kCCDPickerViewItemName;
extern NSString * const kCCDPickerViewItemId;

@protocol CCDPickerViewDelegate <NSObject>

@optional
- (CGFloat)CCDPickerViewRowHeight;

@end

@interface CCDPickerView : UIView

@property (nonatomic, copy) void(^confirmBlock)(NSDictionary *reasonDict);

@property (nonatomic, weak) id<CCDPickerViewDelegate> delegate;

/**
 刷新View

 @param dataArray 数据源，元素格式为@{kCCDPickerViewItemId:@"xxx",kCCDPickerViewItemName:@"yyy"},
 @param title 弹窗标题
 @param index 初始选中Item
 */
- (void)updateWithDataArray:(NSArray <NSDictionary *> *)dataArray title:(NSString *)title selectedItemIndex:(NSInteger )index;
- (void)updateWithDataArray:(NSArray <NSDictionary *> *)dataArray title:(NSString *)title;

- (void)show;

@end


@interface CCDPickerRowView : UIView

- (void)updateWithText:(NSString *)text;
@end


