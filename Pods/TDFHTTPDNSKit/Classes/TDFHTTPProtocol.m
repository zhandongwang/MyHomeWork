
#import "TDFHTTPProtocol.h"
#import "TDFDNSManager.h"

@interface TDFHTTPProtocol () <NSURLSessionDataDelegate>

@property (nonatomic, strong, readwrite) NSThread *clientThread;
@property (nonatomic, copy,   readwrite) NSArray *modes;
@property (nonatomic, strong, readwrite) NSURLSessionDataTask *task;
@property (strong, nonatomic) NSString *hostName;

@end

@implementation TDFHTTPProtocol


#pragma mark - NSURLProtocol overrides

static NSString * kTDFRequestHandlerKey = @"kTDFRequestHandlerKey";

+ (BOOL)isIpAddress:(NSString *)host {
    NSString  *urlRegEx =@"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    
    return [urlTest evaluateWithObject:host];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    NSString *urlScheme = request.URL.scheme;
    
    if ([TDFDNSManager sharedManager].hostPredicate && ![[TDFDNSManager sharedManager].hostPredicate evaluateWithObject:request]) {
        return NO;
    }
    
    if ([urlScheme caseInsensitiveCompare:@"http"] != NSOrderedSame && [urlScheme caseInsensitiveCompare:@"https"] != NSOrderedSame) {
        return NO;
    }
    
    NSString *urlHost = request.URL.host;
    
    if ([self isIpAddress:urlHost]) {
        return NO;
    }
    
    if ([self propertyForKey:kTDFRequestHandlerKey inRequest:request]) {
    
        return NO;
    }
    
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

- (void)startLoading {
    
    NSMutableURLRequest *recursiveRequest;
    NSMutableArray *calculatedModes;
    NSString *currentMode;

    calculatedModes = [NSMutableArray array];
    [calculatedModes addObject:NSDefaultRunLoopMode];
    currentMode = [[NSRunLoop currentRunLoop] currentMode];
    
    if ( (currentMode != nil) && ! [currentMode isEqual:NSDefaultRunLoopMode] ) {
        [calculatedModes addObject:currentMode];
    }
    self.modes = calculatedModes;
    
    recursiveRequest = [[self request] mutableCopy];
    
    NSString *host = recursiveRequest.URL.host;
    NSString *scheme = recursiveRequest.URL.scheme;
    self.hostName = host;
    
    __typeof(self) __weak wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSString *ip = [[TDFDNSManager sharedManager] getIpByDomain:host];
        
        if (ip && ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame
                   || [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame)) {
            
            NSURLComponents *components = [[NSURLComponents alloc] initWithURL:self.request.URL
                                                       resolvingAgainstBaseURL:NO];
            components.host = ip;
            recursiveRequest.URL = components.URL;
        }
        
        assert(recursiveRequest != nil);
        
        [[wself class] setProperty:@YES forKey:kTDFRequestHandlerKey inRequest:recursiveRequest];
        [recursiveRequest setValue:wself.hostName forHTTPHeaderField:@"Host"];
        
        wself.clientThread = [NSThread currentThread];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                              delegate:self
                                                         delegateQueue:nil];
        wself.task = [session dataTaskWithRequest:recursiveRequest];
        [wself.task resume];
    });
}

- (void)stopLoading {

    if (self.task != nil) {
        [self.task cancel];
        self.task = nil;
    }
    self.hostName = nil;
}

#pragma mark - Authentication challenge handling

- (void)performOnThread:(NSThread *)thread modes:(NSArray *)modes block:(dispatch_block_t)block {

    if (thread == nil) {
        thread = [NSThread mainThread];
    }
    if ([modes count] == 0) {
        modes = @[ NSDefaultRunLoopMode ];
    }
    [self performSelector:@selector(onThreadPerformBlock:) onThread:thread withObject:[block copy] waitUntilDone:NO modes:modes];
}

- (void)onThreadPerformBlock:(dispatch_block_t)block {
    assert(block != nil);
    block();
}

#pragma mark - NSURLSession delegate callbacks

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)newRequest completionHandler:(void (^)(NSURLRequest *))completionHandler {
    NSMutableURLRequest *redirectRequest;
    
    redirectRequest = [newRequest mutableCopy];
    [[self class] removePropertyForKey:kTDFRequestHandlerKey inRequest:redirectRequest];

    [[self client] URLProtocol:self wasRedirectedToRequest:redirectRequest redirectResponse:response];
    [self.task cancel];

    [[self client] URLProtocol:self didFailWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    
//    refer: https://blog.austinchou.com/dns-anti-spoofing-using-nsurlprotocol-and-happydns/
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    SecTrustResultType result;
    NSURLCredential *cred;
    
    OSStatus status = SecTrustEvaluate(trust, &result);
    
    NSInteger retryCount = 1;
    NSInteger retainCount = 0;
    
    while (status == errSecSuccess && retryCount >= 0) {
        if (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified) {
            cred = [NSURLCredential credentialForTrust:trust];
            
            completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
            return;
        } else if (result == kSecTrustResultRecoverableTrustFailure) {
            retryCount--;
            
            CFIndex numCerts = SecTrustGetCertificateCount(trust);
            NSMutableArray *certs = [NSMutableArray arrayWithCapacity:numCerts];
            for (CFIndex idx = 0; idx < numCerts; ++idx) {
                SecCertificateRef cert = SecTrustGetCertificateAtIndex(trust, idx);
                [certs addObject:CFBridgingRelease(cert)];
            }
            
            SecPolicyRef policy = SecPolicyCreateSSL(true, (__bridge CFStringRef)self.hostName);
            OSStatus err = SecTrustCreateWithCertificates((__bridge CFTypeRef _Nonnull)(certs), policy, &trust);
            retainCount++;
            CFRelease(policy);
            
            [certs removeAllObjects];
            certs = nil;
            
            if (err != noErr) {
                break;
            }
            status = SecTrustEvaluate(trust, &result);
        }
    }
    
    completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSURLCacheStoragePolicy cacheStoragePolicy;
    NSInteger statusCode;
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        cacheStoragePolicy = NSURLCacheStorageAllowed;
        statusCode = [((NSHTTPURLResponse *) response) statusCode];
    } else {
        assert(NO);
        cacheStoragePolicy = NSURLCacheStorageNotAllowed;
        statusCode = 42;
    }
    
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:cacheStoragePolicy];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {

    [[self client] URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse *))completionHandler {

    completionHandler(proposedResponse);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error == nil) {
        
        [[self client] URLProtocolDidFinishLoading:self];
    } else {
        
        [[self client] URLProtocol:self didFailWithError:error];
    }
}

@end
