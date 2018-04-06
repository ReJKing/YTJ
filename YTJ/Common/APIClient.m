//
//  APIClinet.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import "APIClient.h"
#define API_SERVER_URL @"https://api.douban.com"

@implementation APIClient
+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:API_SERVER_URL]];
        
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        
        
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
