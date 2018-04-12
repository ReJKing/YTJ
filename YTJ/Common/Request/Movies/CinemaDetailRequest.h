//
//  CinemaMoviesRequest.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//


/*
 *获取影院数据
 */
#import <Foundation/Foundation.h>

@interface CinemaDetailRequest : NSObject

+ (void)getCinemaDetailWithCinemaId:(NSString*)cinemaId  Complete:(void(^)(id json,NSError *error))completion;
@end
