//
//  AdvertRequest.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/9.
//  Copyright © 2018年 King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertRequest : NSObject
+ (void)getAdvertComplete:(void(^)(id json,NSError *error))completion;
@end
