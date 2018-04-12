//
//  getMovieDetaiRequest.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/10.
//  Copyright © 2018年 King. All rights reserved.
//

/*
 *根据电影名称获取电影信息（电影详情+上映影院）
 */
#import <Foundation/Foundation.h>

@interface MovieDetaiRequest : NSObject

+ (void)getMoiveDetailWithMoiveName:(NSString*)name Complete:(void(^)(id json,NSError *error))completion;


@end
