//
//  CinemaMoviesRequest.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import "CinemaDetailRequest.h"
#import "APIClient.h"

@implementation CinemaDetailRequest
+ (void)getCinemaDetailWithCinemaId:(NSString*)cinemaId  Complete:(void(^)(id json,NSError *error))completion{
    
    NSString *url =[cinemaId stringByAppendingString:@"/cinema/cinemadetail"] ;

    NSDictionary *parameter = @{@"id":@"3"};
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
