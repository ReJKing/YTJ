//
//  CinemaRequest.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/10.
//  Copyright © 2018年 King. All rights reserved.
//
/*
 *获取影院列表
 */

#import <Foundation/Foundation.h>

@interface CinemaRequest : NSObject
+ (void)getCinemaComplete:(void(^)(id json,NSError *error))completion;
@end
