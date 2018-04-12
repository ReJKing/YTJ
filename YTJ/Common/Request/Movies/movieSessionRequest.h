//
//  movieSessionRequest.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/12.
//  Copyright © 2018年 King. All rights reserved.
//

/*
 *获取某个电影院某部电影的场次信息
 */

#import <Foundation/Foundation.h>

@interface movieSessionRequest : NSObject
+ (void)getMovieSessionlWithMovieId:(NSString*)movieId CinemaId:(NSString*)cinemaId Complete:(void(^)(id json,NSError *error))completion;
@end
