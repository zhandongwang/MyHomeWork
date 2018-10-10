
//
//  UIImage+Localization.m
//  ActivityForRestApp
//
//  Created by 梁世伟 on 2017/12/11.
//

#import "UIImage+Localization.h"
#import "NSBundle+Language.h"

@implementation UIImage (Localization)

+ (UIImage *)tdf_localizedImageWithName:(NSString *)name {
    return [self tdf_localizedImageWithName:name inBundle:nil];
    
}

+ (UIImage *)tdf_localizedImageWithName:(NSString *)name inBundle:(NSBundle *)bundle {
    NSString *selectedLanguage = [NSBundle currentLanguage];
    if ([selectedLanguage containsString:@"th"] ) {
        selectedLanguage = @"en";
    }

    NSString *localizedName = [NSString stringWithFormat:@"%@_%@",name,selectedLanguage];
    UIImage *image = [UIImage imageNamed:localizedName
                                inBundle:bundle
           compatibleWithTraitCollection:nil];
    if (!image) {
        image = [UIImage imageNamed:name
                           inBundle:bundle
      compatibleWithTraitCollection:nil];
    }
    return image;
}

@end
