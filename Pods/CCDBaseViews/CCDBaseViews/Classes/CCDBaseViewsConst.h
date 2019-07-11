//
//  CCDBaseViewsConst.h
//  Pods
//
//  Created by 凤梨 on 17/3/22.
//
//

#import <Foundation/Foundation.h>

@interface CCDBaseViewsConst : NSObject

#define CCDBaseViewsPodName @"CCDBaseViews"
#define CCDBaseViewsBundle	[[CCDBundleHelper sharedInstance] podBundle:CCDBaseViewsPodName]
#define CCDBaseViewsBundleImage(imageName) [UIImage imageNamed:[[CCDBundleHelper sharedInstance] getImagePath:imageName fromBundle:CCDBaseViewsPodName]]
    
#define CCDBaseViewsLocalizabledString(key)  NSLocalizedStringFromTableInBundle(key, @"CCDBaseViewsLocalizable", CCDBaseViewsBundle,)


@end
