//
//  NSData+UTIs.h
//  AssemblyComponent-AssemblyComponent
//
//  Created by byAlex on 2017/10/27.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TDFImageUTIsType) {
    TDFImageUTL_Unknown,
    TDFImageUTI_JPEG,     //"public.jpeg"
    TDFImageUTI_PNG,      //"public.tiff"
    TDFImageUTI_GIF,      //"com.compuserve.gif"
    TDFImageUTI_TIFF,     //"public.tiff"
};

@interface NSData (UTIs)

- (TDFImageUTIsType)tdf_imageType;
- (BOOL)tdf_isGif;
@end

