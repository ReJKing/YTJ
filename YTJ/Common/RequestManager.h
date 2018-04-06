//
//  RequestManager.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestManager : NSObject

+ (void)getHitMoivesComplete:(void(^)(NSArray *moives,NSError *error))completion;


@end
