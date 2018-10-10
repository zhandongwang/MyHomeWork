
@import Foundation;

@protocol TDFHTTPProtocolDelegate;

@interface TDFHTTPProtocol : NSURLProtocol

@property (nonatomic, strong, readonly ) NSURLAuthenticationChallenge * pendingChallenge;

@end