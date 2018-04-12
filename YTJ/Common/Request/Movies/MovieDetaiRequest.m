//
//  getMovieDetaiRequest.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/10.
//  Copyright © 2018年 King. All rights reserved.
//

#import "MovieDetaiRequest.h"
#import "APIClient.h"
@implementation MovieDetaiRequest

+ (void)getMoiveDetailWithMoiveName:(NSString*)name Complete:(void(^)(id json,NSError *error))completion{
    
    NSString *url = @"api/cinema/searchcinemas";
    NSDictionary *parameter = @{@"movie_name":name};
    [[APIClient sharedClient] POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  JSON) {
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
