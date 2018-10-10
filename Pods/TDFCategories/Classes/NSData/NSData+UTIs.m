
//  NSData+UTIs.m
//  AssemblyComponent-AssemblyComponent
//
//  Created by byAlex on 2017/10/27.
//

#import "NSData+UTIs.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation NSData (UTIs)

- (TDFImageUTIsType)tdf_imageType {

    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)self, NULL);
    CFStringRef imageUTL = CGImageSourceGetType(imageSource);
    CFRelease(imageSource);
    
    if (UTTypeEqual(imageUTL, kUTTypeJPEG)) {
        return TDFImageUTI_JPEG;
    } else if (UTTypeEqual(imageUTL, kUTTypePNG)) {
        return TDFImageUTI_PNG;
    } else if (UTTypeEqual(imageUTL, kUTTypeTIFF)) {
        return TDFImageUTI_TIFF;
    } else if (UTTypeEqual(imageUTL, kUTTypeGIF)) {
        return TDFImageUTI_GIF;
    }
    
    return TDFImageUTL_Unknown;
}

- (BOOL)tdf_isGif {
    return self.tdf_imageType == TDFImageUTI_GIF;
}
@end
