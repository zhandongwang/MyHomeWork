//
//  UIImage+Localization.h
//  ActivityForRestApp
//
//  Created by 梁世伟 on 2017/12/11.
//

#import <UIKit/UIKit.h>


@interface UIImage (Localization)

+ (UIImage *)tdf_localizedImageWithName:(NSString *)name;
+ (UIImage *)tdf_localizedImageWithName:(NSString *)name inBundle:(NSBundle *)bundle;

@end

#define TDFLocaizedImage(name) [UIImage tdf_localizedImageWithName: name]
#define TDFLocaizedImageInBundle(name, bundle) \
[UIImage tdf_localizedImageWithName:name inBundle:bundle]
