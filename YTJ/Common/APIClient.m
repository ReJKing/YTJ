//
//  APIClinet.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import "APIClient.h"
#define API_SERVER_URL @"http://120.76.79.54:8081"

@implementation APIClient
+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.timeoutIntervalForRequest = 10.0f;
        sessionConfig.timeoutIntervalForResource = 20.0f;
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:API_SERVER_URL] sessionConfiguration:sessionConfig];

        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
//        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        [_sharedClient.requestSerializer setValue:@"Basic MTIzNDU2OjEyMzQ1Ng==" forHTTPHeaderField:@"Authorization"];
        
        
    });
    
    return _sharedClient;
}


- (void)cancelAllRequest
{
    [self.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
}
@end
