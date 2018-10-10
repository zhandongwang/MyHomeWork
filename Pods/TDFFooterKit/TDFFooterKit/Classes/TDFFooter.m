//
//  TDFFooter.m
//  Pods
//
//  Created by tripleCC on 2017/8/25.
//
//
#import <TDFInternationalKit/TDFInternationalKit.h>
#import "TDFDataCenter.h"
#import "TDFFooter.h"
@interface TDFFooter ()
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) TDFFooterAlignment alignment;
@property (assign, nonatomic) CGSize size;
//添加svg
@property (nonatomic, strong) NSString *svgName;
@property (nonatomic, strong) UIColor *viewBackColor;
@end

@implementation TDFFooter
@synthesize actionBlock = _actionBlock;

+ (instancetype)addFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"ico_footer_button_addd_red")];
}

+ (instancetype)sortFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"ico_footer_button_sort")];
}

+ (instancetype)notAllCheckFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"ico_footer_button_uncheckall")];
}

+ (instancetype)allCheckFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"ico_footer_button_checkall")];
}

+ (instancetype)previewFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"ico_preview")];
}

+ (instancetype)createShopFooter {
    return [self footerWithBackgroundImage:TDFLocaizedImage([@"red/" stringByAppendingString:@"ico_footer_button_Createshop"]) ?: TDFLocaizedImage(@"ico_footer_button_Createshop")];
}

+ (instancetype)helpFooter {
    UIImage *image = NSLocalizedImage(@"ico_help");
    image = [UIImage imageWithCGImage:image.CGImage scale:(image.size.width / 32.0f) orientation:UIImageOrientationUp];
    NSString *countryId = [TDFDataCenter sharedInstance].countryId;
    BOOL isGlobalizationFormat =!([countryId isEqualToString: @"001"]);
    if (!isGlobalizationFormat) {
        return [self footerWithAlignment:TDFFooterAlignmentLeft
                         backgroundImage:nil
                                   image:image
                             actionBlock:nil];
    }
    else{
        return [[TDFFooter alloc] init];
    }
}

+ (instancetype)exportFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"export")];
}
+ (instancetype)templatePurchaseFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"templatePurchase")];
}
+ (instancetype)batchFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"ico_footer_button_batch")];
}
+ (instancetype)searchByMaterialFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"ico_footer_button_search_by_material")];
}

+ (instancetype)newAddFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"footer_add")];
}

+ (instancetype)newHelpFooter {
    TDFFooter *footer = [self footerWithBackgroundImage:NSLocalizedImage(@"footer_help")];
    footer.alignment = TDFFooterAlignmentLeft;
    footer.size = CGSizeMake(44, 44);
    NSString *countryId = [TDFDataCenter sharedInstance].countryId;
    BOOL isGlobalizationFormat =!([countryId isEqualToString: @"001"]);
    if (!isGlobalizationFormat) {
        return footer;
    }
    else{
        return [[TDFFooter alloc] init];
    }
    return footer;
}
+ (instancetype)newDeleteLocationFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"footer_delete_location")];
}
+ (instancetype)newAddLocationFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"footer_add_location")];
}

+ (instancetype)newNotAllCheckFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"new_ico_footer_button_uncheckall")];
}

+ (instancetype)newAllCheckFooter {
    return [self footerWithBackgroundImage:NSLocalizedImage(@"new_ico_footer_button_checkall")];
}

////////////////////////////////////////////////////////////////////////////////

- (instancetype)attachAction:(dispatch_block_t)block {
    self.actionBlock = block;
    return self;
}

- (BOOL)isEqual:(TDFFooter *)object {
    return ((!self.backgroundImage || !object.backgroundImage) && (!self.image || !object.image)) ?
    [super isEqual:object] :
    ([self.backgroundImage isEqual:object.backgroundImage] || [self.image isEqual:object.image]);
}

- (NSUInteger)hash {
    return [super hash];
}

////////////////////////////////////////////////////////////////////////////////

- (instancetype)initWithAlignment:(TDFFooterAlignment)alignment
                  backgroundImage:(UIImage *)backgroundImage
                            image:(UIImage *)image
                      actionBlock:(dispatch_block_t)actionBlock {
    if (self = [super init]) {
        _actionBlock = actionBlock;
        _alignment = alignment;
        _image = image;
        _backgroundImage = backgroundImage;
        _size = CGSizeMake(56, 56);
    }
    
    return self;
}


- (instancetype)initWithAlignment:(TDFFooterAlignment)alignment
                  backgroundImage:(UIImage *)backgroundImage
                      actionBlock:(dispatch_block_t)actionBlock {
    return [self initWithAlignment:alignment
                   backgroundImage:backgroundImage
                             image:nil
                       actionBlock:actionBlock];
}

+ (instancetype)footerWithAlignment:(TDFFooterAlignment)alignment
                    backgroundImage:(UIImage *)backgroundImage
                              image:(UIImage *)image
                        actionBlock:(dispatch_block_t)actionBlock {
    return [[self alloc] initWithAlignment:alignment
                           backgroundImage:backgroundImage
                                     image:image
                               actionBlock:actionBlock];
}

+ (instancetype)footerWithAlignment:(TDFFooterAlignment)alignment
                    backgroundImage:(UIImage *)backgroundImage
                        actionBlock:(dispatch_block_t)actionBlock {
    return [[self alloc] initWithAlignment:alignment
                           backgroundImage:backgroundImage
                               actionBlock:actionBlock];
}

+ (instancetype)footerWithBackgroundImage:(UIImage *)backgroundImage
                              actionBlock:(dispatch_block_t)actionBlock {
    return [[self alloc] initWithAlignment:TDFFooterAlignmentRight
                           backgroundImage:backgroundImage
                               actionBlock:actionBlock];
}

+ (instancetype)footerWithBackgroundImage:(UIImage *)backgroundImage {
    return [[self alloc] initWithAlignment:TDFFooterAlignmentRight
                           backgroundImage:backgroundImage
                               actionBlock:nil];
}



#pragma mark -- 使用svg初始化footer按钮
- (instancetype)initWithAlignment:(TDFFooterAlignment)alignment
                  backColor:(UIColor *)viewBackColor
                            svgName:(NSString *)svgName
                      actionBlock:(dispatch_block_t)actionBlock {
    if (self = [super init]) {
        _actionBlock = actionBlock;
        _alignment = alignment;
        _viewBackColor = viewBackColor;
        _svgName = svgName;
        _size = CGSizeMake(55, 55);
    }
    
    return self;
}

+ (instancetype)footerWithSvgName:(NSString *)svgName {
    return  [self footerWithSvgName:svgName backColor:tdf_greenColor];
}

+ (instancetype)footerWithSvgName:(NSString *)svgName backColor:(UIColor *)color {
    return [[self alloc] initWithAlignment:TDFFooterAlignmentRight backColor:color svgName:svgName actionBlock:nil];
}



@end

