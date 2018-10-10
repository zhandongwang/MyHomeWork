#TDFHTTPDNS

DNS Anti-spoofing lib

##How To Use

default: NDSPod free version

```objectivec

NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
config.protocolClasses = @[ [TDFHTTPProtocol class] ];

NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
NSString *urlString = @"https://api.douban.com/v2/book/search?q=python&fields=id,title";

NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error) {

        NSLog(@"Error: %@", [error localizedDescription]);
    } else {

        NSLog(@"Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }
}];

[task resume];

```

###Customize DNS hosting service provider

1. Set URL Formatter
    ```objectivec
    TDFDNSManager *manager= [TDFDNSManager sharedManager];
    manager.urlFormatter = @"http://xxx.xxx.xxx?domain=%@&ttl=1";
    ```

2. Reponse Serializer
    ```objectivec
    @interface CustomSerializer : TDFDNSResponseSerializer
    @end

    @implementation CustomSerializer

    - (NSArray<TDFDNSRecord *> *)dnsRecordsForResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error {

        // do some thing
        return ips;
    }
    @end

    // set serializer
    TDFDNSManager *manager= [TDFDNSManager sharedManager];
    manager.responseSerializer = [[CustomSerializer alloc] init];

    ```

##TODO



##License

TDFHTTPDNS is released under the WTFPL license. (Do What the Fuck You Want to Public License)
