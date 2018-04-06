//
//  HitMoivesRequest.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HitMoivesRequest : NSObject
+ (void)getHitMoivesComplete:(void(^)(id json,NSError *error))completion;
@end
