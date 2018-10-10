//
//  TDFNetworking.h
//  TDFNetworking
//
//  Created by 於卓慧 on 5/6/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for TDFNetworking.
FOUNDATION_EXPORT double TDFNetworkingVersionNumber;

//! Project version string for TDFNetworking.
FOUNDATION_EXPORT const unsigned char TDFNetworkingVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <TDFNetworking/PublicHeader.h>
#if __has_include(<TDFNetworking/TDFNetworking.h>)
#import <TDFNetworking/TDFResponseModel.h>
#import <TDFNetworking/TDFNetworkingConstants.h>
#import <TDFNetworking/TDFHTTPClient.h>
#import <TDFNetworking/TDFRequestModel.h>
#import <TDFNetworking/TDFNetworkUtil.h>
#import <TDFNetworking/NSString+TDFNetworking.h>
#import <TDFNetworking/TDFHTTPRequestSerializer.h>
#else
#import "TDFResponseModel.h"
#import "TDFNetworkingConstants.h"
#import "TDFHTTPClient.h"
#import "TDFRequestModel.h"
#import "TDFNetworkUtil.h"
#import "NSString+TDFNetworking.h"
#import "TDFHTTPRequestSerializer.h"
#endif
