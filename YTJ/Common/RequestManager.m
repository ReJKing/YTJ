//
//  RequestManager.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import "RequestManager.h"
#import "HitMoivesRequest.h"
#import "MoivesObj.h"

@implementation RequestManager

+ (void)getHitMoivesComplete:(void(^)(NSArray *moives,NSError *error))completion{
    
    [HitMoivesRequest getHitMoivesComplete:^(id json, NSError *error) {
        if(json && error == nil){
            NSLog(@"%@",json);
            NSArray *moivesArray = json[@"subjects"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSInteger i = 0; i < moivesArray.count; i++) {
                MoivesObj *obj = [[MoivesObj alloc] init];
                obj.name = moivesArray[i][@"title"];
                obj.playbillUrl = moivesArray[i][@"images"][@"small"];
                obj.grade = moivesArray[i][@"rating"][@"average"];
                obj.moiveId = moivesArray[i][@"id"];
                obj.director = moivesArray[i][@"directors"][0][@"name"];
                obj.genres = moivesArray[i][@"genres"];
                
                [tempArray addObject:obj];
            }
            if(completion){
                completion((NSArray *)tempArray,nil);
            }
            
    
        
    }else{
        
        if(completion){
            completion(nil,error);
        }
    }
    }];
    
}
@end
