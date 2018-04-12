//
//  RequestManager.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestManager : NSObject

/*
 *获取热映电影列表
 */
+ (void)getHitMoivesComplete:(void(^)(NSArray *moives,NSError *error))completion;
/*
 *获取首页广告图列表
 */
+ (void)getAdvertComplete:(void(^)(NSMutableArray *moives,NSError *error))completion;
/*
 *获取首页电影院电影列表
 */
+ (void)getCinemaComplete:(void(^)(NSMutableArray *cinemas,NSError *error))completion;
/*
 *获取电影详情
 *resultData包含movie，cinemas两个key
 */
+ (void)getMoiveDetailWithMoiveName:(NSString*)name Complete:(void(^)(NSDictionary*resultData ,NSError *error))completion;
/*
 *获取电影院详情
 */
+ (void)getCinemaDetailWithModuleUrl:(NSString*)moduleUrl Complete:(void(^)(NSDictionary*resultData ,NSError *error))completion;
/*
 *获取电影场次数据
 */
+ (void)getCinemaMovieSessiontWithMovieId:(NSString*)movieId CinemaId:(NSString*)cinemaId Complete:(void(^)(NSMutableArray*resultData ,NSError *error))completion;
@end
