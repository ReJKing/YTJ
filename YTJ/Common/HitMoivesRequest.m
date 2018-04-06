//
//  HitMoivesRequest.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import "HitMoivesRequest.h"
#import "APIClient.h"

@implementation HitMoivesRequest

+ (void)getHitMoivesComplete:(void(^)(id json,NSError *error))completion{
    
    NSString *url = @"v2/movie/in_theaters";
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
