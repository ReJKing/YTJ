//
//  movieSessionRequest.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/12.
//  Copyright © 2018年 King. All rights reserved.
//

#import "movieSessionRequest.h"
#import "APIClient.h"

@implementation movieSessionRequest
+ (void)getMovieSessionlWithMovieId:(NSString*)movieId CinemaId:(NSString*)cinemaId Complete:(void(^)(id json,NSError *error))completion{

    NSString *url =[cinemaId stringByAppendingString:@"/cinema/movieshow"];
    
    NSDictionary *parameter = @{@"id":movieId,@"cinema_id":@"3"};
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
