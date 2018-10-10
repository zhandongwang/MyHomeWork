//
//  TDFFooter.h
//  Pods
//
//  Created by tripleCC on 2017/8/25.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TDFFooterAlignment) {
    TDFFooterAlignmentLeft,
    TDFFooterAlignmentRight,
    TDFFooterAlignmentLeftForVerticalVersion,// 左侧竖排排列
};

#define tdf_greenColor  [UIColor colorWithRed:0/255.0f green:204/255.0f blue:51/255.0f alpha:1.0]
#define tdf_redColor  [UIColor colorWithRed:255/255.0f green:0/255.0f blue:51/255.0f alpha:1.0]
#define tdf_blueColor [UIColor colorWithRed:0/255.0f green:136/255.0f blue:255/255.0f alpha:1.0]

@protocol TDFFooterProtocol <NSObject>
@required
@property (copy, nonatomic) dispatch_block_t actionBlock;
- (CGSize)size;
@optional
// 返回一个
- (UIImage *)backgroundImage;
- (UIImage *)image;

- (TDFFooterAlignment)alignment;

- (NSString *)svgName;
- (UIColor *)viewBackColor;
@end

@interface TDFFooter : NSObject <TDFFooterProtocol>
+ (instancetype)addFooter;
+ (instancetype)helpFooter;
+ (instancetype)allCheckFooter;
+ (instancetype)notAllCheckFooter;
+ (instancetype)sortFooter;

+ (instancetype)exportFooter;
+ (instancetype)templatePurchaseFooter;
+ (instancetype)batchFooter;
+ (instancetype)searchByMaterialFooter;
// 预览
+ (instancetype)previewFooter;
+ (instancetype)newAddFooter;
+ (instancetype)newAddLocationFooter;
+ (instancetype)newDeleteLocationFooter;
+ (instancetype)newHelpFooter;
+ (instancetype)newNotAllCheckFooter;
+ (instancetype)newAllCheckFooter;

//添加店铺
+ (instancetype)createShopFooter ;
////////////////////////////////////////////////////////////////////////////////
- (instancetype)attachAction:(dispatch_block_t)block;
- (instancetype)initWithAlignment:(TDFFooterAlignment)alignment
                  backgroundImage:(UIImage *)backgroundImage
                            image:(UIImage *)image
                      actionBlock:(dispatch_block_t)actionBlock;
+ (instancetype)footerWithAlignment:(TDFFooterAlignment)alignment
                    backgroundImage:(UIImage *)backgroundImage
                              image:(UIImage *)image
                        actionBlock:(dispatch_block_t)actionBlock;

#pragma mark -- 使用svg 设置显示

- (instancetype)initWithAlignment:(TDFFooterAlignment)alignment
                        backColor:(UIColor *)viewBackColor
                          svgName:(NSString *)svgName
                      actionBlock:(dispatch_block_t)actionBlock ;

+ (instancetype)footerWithSvgName:(NSString *)svgName;

+ (instancetype)footerWithSvgName:(NSString *)svgName backColor:(UIColor *)color ;

@end

