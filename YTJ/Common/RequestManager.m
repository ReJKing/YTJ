//
//  RequestManager.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import "RequestManager.h"
#import "HitMoivesRequest.h"
#import "AdvertRequest.h"
#import "CinemaRequest.h"
#import "MovieDetaiRequest.h"
#import "CinemaDetailRequest.h"
#import "movieSessionRequest.h"


#import "MovieObj.h"
#import "AdvertObj.h"
#import "CinemaObj.h"
#import "SnackObj.h"
#import "MovieScheduleObj.h"

#define IMAGESERVICEPATH @"http://120.76.79.54:8082/movie/upload_file/"
@implementation RequestManager

    
+ (void)getHitMoivesComplete:(void(^)(NSArray *moives,NSError *error))completion{
    
    [HitMoivesRequest getHitMoivesComplete:^(id json, NSError *error) {
        if(json && error == nil){
            if([json[@"code"] integerValue] == 1){   //返回值code为1，表示获取成功
                NSArray *moivesArray = json[@"data"];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSInteger i = 0; i < moivesArray.count; i++) {
                    MovieObj *obj = [[MovieObj alloc] init];
                    obj.movieName = moivesArray[i][@"movie_name"];
                    obj.imgUrl = [NSString stringWithFormat:@"%@%@",IMAGESERVICEPATH,moivesArray[i][@"img_url"]];
                    //                obj.playbillUrl = [IMAGESERVICEPATH stringByAppendingPathComponent:moivesArray[i][@"img_url"]];
                    obj.charactor = moivesArray[i][@"charactor"];
                    obj.grade = moivesArray[i][@"score_stars"];
                    obj.on_time = moivesArray[i][@"on_time"];
                    
                    [tempArray addObject:obj];
                }
                if(completion){
                    completion((NSArray *)tempArray,nil);
                }
            }else{
                if (completion) {
                    completion(nil,[self constructionErrorWith:json]);
                }
            }

    }else{
        
        if(completion){
            completion(nil,error);
        }
    }
    }];
    
}
    
    /*
     *获取广告数据
     */
+ (void)getAdvertComplete:(void(^)(NSMutableArray *adv,NSError *error))completion{
    
    [AdvertRequest getAdvertComplete:^(id json, NSError *error) {
        if(json && error == nil){
            if([json[@"code"] integerValue] == 1){   //返回值code为1，表示获取成功
                NSArray *advArray = json[@"data"];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSInteger i = 0; i < advArray.count; i++) {
                    AdvertObj *obj = [[AdvertObj alloc] init];
                    obj.text = advArray[i][@"text"];
                    obj.img_url = [NSString stringWithFormat:@"%@%@",IMAGESERVICEPATH,advArray[i][@"img_url"]];
                    //                obj.img_url =[IMAGESERVICEPATH stringByAppendingPathComponent:advArray[i][@"img_url"]];
                    obj.target_url = advArray[i][@"target_url"];
                    
                    [tempArray addObject:obj];
                }
                if(completion){
                    completion(tempArray,nil);
                }
            }else{
                if (completion) {
                    completion(nil,[self constructionErrorWith:json]);
                }
            }
  
        }else{
            
            if(completion){
                completion(nil,error);
            }
        }
        
    }];
}

+ (void)getCinemaComplete:(void(^)(NSMutableArray *cinemas,NSError *error))completion{
    
    [CinemaRequest getCinemaComplete:^(id json, NSError *error) {
        if(json && error == nil){
            
            if([json[@"code"] integerValue] == 1){   //返回值code为1，表示获取成功
                 NSArray *cinemaArray = json[@"data"][@"cinema"];
                 NSMutableArray *tempArray = [NSMutableArray array];
                for (NSInteger i = 0; i < cinemaArray.count; i++) {
                    CinemaObj *obj = [[CinemaObj alloc] init];
                    obj.cinema_id = cinemaArray[i][@"cinema_id"];
                    obj.cinema_name = cinemaArray[i][@"cinema_name"];
                    obj.cinema_address = cinemaArray[i][@"cinema_address"];
                    obj.low_price = cinemaArray[i][@"low_price"];
                    obj.module_url = cinemaArray[i][@"module_url"];
                    [tempArray addObject:obj];
                }
                if(completion){
                    completion(tempArray,nil);
                }
            }else{
                if (completion) {
                    completion(nil,[self constructionErrorWith:json]);
                }
            }
            
        }else{
            if(completion){
                completion(nil,error);
            }
        }
    }];
    
}

+ (void)getMoiveDetailWithMoiveName:(NSString*)name Complete:(void(^)(NSDictionary*resultData ,NSError *error))completion{
    [MovieDetaiRequest getMoiveDetailWithMoiveName:name Complete:^(id json, NSError *error) {
        if(json && error == nil){
            if([json[@"code"] integerValue] == 1){
                NSMutableArray *tempArray = [NSMutableArray array];
                //解析电影院
                NSArray *cinemaArray = json[@"data"][@"cinema"];
                for (NSInteger i = 0; i < cinemaArray.count; i++) {
                    CinemaObj *obj = [[CinemaObj alloc] init];
                    obj.cinema_id = cinemaArray[i][@"cinema_id"];
                    obj.cinema_name = cinemaArray[i][@"cinema_name"];
                    obj.cinema_address = cinemaArray[i][@"cinema_address"];
                    obj.low_price = cinemaArray[i][@"low_price"];
                    obj.module_url = cinemaArray[i][@"module_url"];
                    
                    
                    [tempArray addObject:obj];
                }
                //解析电影详情
                MovieObj *obj = [[MovieObj alloc] init];
                NSDictionary *movieDetail = json[@"movie"];
                obj.content = movieDetail[@"content"];
                obj.director = movieDetail[@"director"];
                obj.duration = [movieDetail[@"duration"] integerValue];
                obj.movieId = movieDetail[@"movie_id"];
                obj.style = movieDetail[@"style"];
                obj.on_time = movieDetail[@"on_time"];
                obj.videoUrl = movieDetail[@"video_url"];
                obj.charactor = movieDetail[@"charactor"];
                obj.imgUrl = [NSString stringWithFormat:@"%@%@",IMAGESERVICEPATH,movieDetail[@"img_url"]];
                obj.movieName = movieDetail[@"movie_name"];
                
                
                
                NSDictionary *resultsData = @{@"movie":obj,@"cinemas":tempArray};
                if (completion) {
                    completion(resultsData,nil);
                }
            
            }else{
                if (completion) {
                    completion(nil,[self constructionErrorWith:json]);
                }
            }
        }else{
            if(completion){
                completion(nil,error);
            }
        }
    }];
}

/*
 *获取电影院详情
 *每家影院独立表，根据moduleUrl拼接API路径
 
 */
+ (void)getCinemaDetailWithModuleUrl:(NSString*)moduleUrl Complete:(void(^)(NSDictionary*resultData ,NSError *error))completion{
    
    [CinemaDetailRequest getCinemaDetailWithCinemaId:moduleUrl Complete:^(id json, NSError *error) {
    
        if(json && error == nil){
            if([json[@"code"] integerValue] == 1){
                
                //解析电影
                NSMutableArray *tempArray = [NSMutableArray array];
                NSArray *movies = json[@"data"][@"movie"];
                for(NSInteger i = 0; i < movies.count; i++){
                    MovieObj *obj = [[MovieObj alloc] init];
                    obj.charactor = movies[i][@"charactor"];
                    obj.director = movies[i][@"director"];
                    obj.style = movies[i][@"style"];
                    obj.duration = [movies[i][@"duration"] integerValue];
                    obj.imgUrl = [NSString stringWithFormat:@"%@%@",IMAGESERVICEPATH,movies[i][@"img_url"]];
                    obj.movieId = movies[i][@"movie_id"];
                    obj.movieName = movies[i][@"movie_name"];
                    obj.on_time = movies[i][@"on_time"];
                    [tempArray addObject:obj];
                }
                
                //解析影院信息
                CinemaObj *cinema = [[CinemaObj alloc] init];
                NSDictionary *dic = json[@"data"][@"cinema"];
                cinema.cinema_address = dic[@"cinema_address"];
                cinema.cinema_id = dic[@"cinema_id"];
                cinema.cinema_name = dic[@"cinema_name"];
                cinema.cinema_phone = dic[@"cinema_phone"];
                
                //解析零食列表
                NSMutableArray *tempSnack = [NSMutableArray array];
                NSArray *snackArray = json[@"data"][@"snack"];
                for (NSDictionary *snackDic in snackArray) {
                    SnackObj *obj = [[SnackObj alloc] init];
                    obj.available_date = snackDic[@"available_date"];
                    obj.available_time = snackDic[@"available_time"];
                    obj.cinema_price = snackDic[@"cinema_price"];
                    obj.snackId = [snackDic[@"id"] stringValue];
                    obj.img_url = [NSString stringWithFormat:@"%@%@",IMAGESERVICEPATH,snackDic[@"img_url"]];
                    obj.price = snackDic[@"price"];
                    obj.title = snackDic[@"title"];
                    [tempSnack addObject:obj];
                }
                
                NSString *notice = json[@"data"][@"title"];
                
                NSDictionary *resultDic = @{@"cinema":cinema,@"movie":tempArray,@"snack":tempSnack,@"notice":notice};
                if(completion){
                    completion(resultDic,nil);
                }
                
                
            }else{
                if (completion) {
                    completion(nil,[self constructionErrorWith:json]);
                }
            }
            
        }else{
            if(completion){
                completion(nil,error);
            }
        }
    }];
}

/*
 *获取电影场次数据
 */
+ (void)getCinemaMovieSessiontWithMovieId:(NSString*)movieId CinemaId:(NSString*)cinemaId Complete:(void(^)(NSMutableArray *resultData ,NSError *error))completion{
    [movieSessionRequest getMovieSessionlWithMovieId:movieId CinemaId:cinemaId Complete:^(id json, NSError *error) {
        NSLog(@"%@",json);
        if(json && error == nil){
            if([json[@"code"] integerValue] == 1){
                NSArray *array = json[@"data"][@"lists"];
                NSMutableArray *tempResult = [NSMutableArray array];
                for(NSDictionary *dic in array){
                    NSString *time = dic[@"time"];
                    NSMutableArray *schedules = [NSMutableArray array];
                    for (NSDictionary *subDic in dic[@"detail"]) {
                        MovieScheduleObj *obj = [[MovieScheduleObj alloc] init];
                        obj.hall = subDic[@"detail"];
                        obj.hall_type = subDic[@"hall_type"];
                        obj.language = subDic[@"language"];
                        obj.o_price = subDic[@"o_price"];
                        obj.price = subDic[@"price"];
                        obj.show_id = subDic[@"show_id"];
                        obj.start = subDic[@"start"];
                        [schedules addObject:obj];
                    }
                    NSDictionary *date = @{@"time":time,@"schedules":schedules};
                    [tempResult addObject:date];
                    if(completion){
                        completion(tempResult,nil);
                    }
                }
            }else{
                if (completion) {
                    completion(nil,[self constructionErrorWith:json]);
                }
            }
            
        }else{
            if(completion){
                completion(nil,error);
            }
        }
    }];
}

/*
 *构造自定义NSError
 */
+ (NSError*)constructionErrorWith:(NSDictionary*)json{
    NSString *message = json[@"msg"];
    message = message?message:@"";
    NSDictionary* NSErrorDic= @{@"retCode":json[@"code"], @"message":message};
    return [[NSError alloc]initWithDomain:@"" code:0 userInfo:NSErrorDic];
}
@end
