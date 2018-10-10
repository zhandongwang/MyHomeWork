//
//  TDFOldNavAdapter.m
//  Pods
//
//  Created by happyo on 2017/8/28.
//
//

#import "TDFCustomNavBarAdapter.h"

#define BG_FILE @"bgFile" // 从 RestConstants 拷过来的

@interface TDFCustomNavBarAdapter ()

@property (nonatomic, strong) NSDictionary *gylStyleDict;
@property (nonatomic, strong) NSDictionary *customDict;
@property (nonatomic, assign) BOOL isCustom;

@end
@implementation TDFCustomNavBarAdapter

+ (instancetype)sharedInstance
{
    static TDFCustomNavBarAdapter *adapter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adapter = [[TDFCustomNavBarAdapter alloc] init];
        [adapter configure];
    });
    return adapter;
}

- (void)configure
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TDFCustomNavBar" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (dict) {
        self.isCustom = YES;
        self.gylStyleDict = dict;
    } else {
        self.isCustom = NO;
    }
}

- (UIImage *)adapterBackgroundImageWithDefaultImage:(UIImage *)image
{
    return self.isCustom ? [UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:BG_FILE] ?: @"bg_01b.jpg"] : image;
}

- (UIColor *)adapterTitleColorWithDefaultColor:(UIColor *)color
{
    NSString *hexColorStr = self.customDict[@"titleColor"];
    
    return self.isCustom ? [UIColor colorWithHexString:hexColorStr] : color;
}

- (UIColor *)adapterButtonColorWithDefaultColor:(UIColor *)color
{
    NSString *hexColorStr = self.customDict[@"buttonColor"];
    
    return self.isCustom ? [UIColor colorWithHexString:hexColorStr] : color;
}

- (UIStatusBarStyle)adpterBarStyleWithDefaultStyle:(UIStatusBarStyle)barStyle
{
    return self.isCustom ? barStyle : barStyle;
}

- (UIColor *)adapterAlphaViewColorWithDefaultColor:(UIColor *)color
{
    NSString *hexColorStr = self.customDict[@"alphaColor"];
    NSNumber *alphaNumber = self.customDict[@"backgroundAlpha"];
    
    return self.isCustom ? [[UIColor colorWithHexString:hexColorStr] colorWithAlphaComponent:alphaNumber.floatValue] : color;
}

- (UIColor *)adapterNavigationBarColorWithDefaultColor:(UIColor *)color
{
    NSString *hexColorStr = self.customDict[@"barColor"];

    return self.isCustom ? [UIColor colorWithHexString:hexColorStr] : color;
}

- (UIImage *)adapterBackArrowImageWithDefaultImage:(UIImage *)image
{
    return self.isCustom ? [UIImage imageNamed:self.customDict[@"backImageName"]] : image;
}

- (UIImage *)adapterLeftImageWithImage:(UIImage *)image
{
    return self.isCustom ? nil : nil;
}

- (UIImage *)adapterRightImageWithImage:(UIImage *)image
{
    return self.isCustom ? nil : nil;
}

- (NSString *)adapterCloseTitle {
    return self.isCustom ? NSLocalizedString(@"关闭", nil) : nil;
}

- (UIImage *)adapterCloseImage {
    return self.isCustom ? [UIImage imageNamed:@"common_nbc_cancel"] : [UIImage imageNamed:@"common_nbc_back" ];
}

- (UIImage *)adapterCloseImageWithNavigationBarStyle:(TDFNavigationBarStyle)style {
    return self.isCustom ? [UIImage imageNamed:@"common_nbc_cancel"] : (style == TDFNavigationBarStyleWhite ? [UIImage imageNamed:@"core_icon_back_blue"] :  [UIImage imageNamed:@"common_nbc_back" ]);
}

- (NSString *)adapterLeftBackTitle
{
    return self.isCustom ? nil : nil;
}

- (CGFloat)adapterAlpha
{
    return self.isCustom ? 0.7 : 0;
}

- (UIColor *)adapterSearchViewCancelColor {
    return self.isCustom ? [UIColor colorWithHeX:0x0088ff]  : [UIColor colorWithHeX:0x007aff];
}

- (void)adapterGYLThemeStyleWithNavigationBarStyle:(TDFNavigationBarStyle)style {
    
    if (!self.isCustom) {
        //掌柜调用时，不设置
        return;
    }
    //默认都是白色风格
    switch (style) {
            
        case TDFNavigationBarStyleNone:
            self.customDict = self.gylStyleDict[@"noneStyle"];
            break;
        case TDFNavigationBarStyleWhite:
                self.customDict = self.gylStyleDict[@"whiteStyle"];
            break;
            
        case TDFNavigationBarStyleBlack:
                self.customDict = self.gylStyleDict[@"darkStyle"];
        break;
    }
}
@end


@implementation UIColor (Hex)
+(UIColor *)colorWithHeX:(long)hexColor{
    return [UIColor colorWithHeX:hexColor alpha:1.0f];
}

+(UIColor *)colorWithHeX:(long)hexColor alpha:(float)alpha{
    float red = ((float)((hexColor &0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor &0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor &0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [UIColor colorWithHexString:color alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
    
}
@end
