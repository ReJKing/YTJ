//
//  CinemaRequest.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/10.
//  Copyright © 2018年 King. All rights reserved.
//

#import "CinemaRequest.h"
#import "APIClient.h"
@implementation CinemaRequest
+ (void)getCinemaComplete:(void(^)(id json,NSError *error))completion{
    
    NSString *url = @"api/cinema/cinemas";
    [[APIClient sharedClient] POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  JSON) {
        if(completion){
            completion(JSON,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completion){
            completion(nil,error);
        }
    }];
}
@end
