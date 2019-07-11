//
//  TDFBundleHelper.h
//  Pods
//
//  Created by huanghou on 17/3/17.
//
//

#define TDFBundleName(bundle) [[(bundle) infoDictionary] valueForKey:@"CFBundleName"]

#define TDFResourceBundleWithClass(cls) \
 [NSBundle bundleWithURL:[[NSBundle bundleForClass:(cls)] URLForResource:TDFBundleName([NSBundle bundleForClass:(cls)]) withExtension:@"bundle"]]

#define TDFImageFromCurrentBundle(imageName) TDFImageFromBundle((imageName),[self class])

#define TDFImageFromBundle(imageName, cls) [UIImage tdf_imageNamed:imageName inBundle:TDFResourceBundleWithClass((cls))]

#define TDFLocalizedString(key, comment) \
 NSLocalizedStringFromTableInBundle((key), TDFBundleName([NSBundle bundleForClass:[self class]]),TDFResourceBundleWithClass([self class]) , (comment))

#define TDFLocalizedStringFromBundle(key, cls, comment) \
 NSLocalizedStringFromTableInBundle((key), TDFBundleName([NSBundle bundleForClass:(cls)]),TDFResourceBundleWithClass((cls)) , (comment))

#import <Foundation/Foundation.h>

#import "UIImage+TDFBundle.h"
