//
//  JKBaseViewController.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import "JKBaseViewController.h"

@interface JKBaseViewController ()

@end

@implementation JKBaseViewController

- (instancetype)init
{
    if(self = [super init])
    {
        SessionDataTasks = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)showHUB:(NSString *)mes
{
    if (hud) {
        hud.hidden = YES;
        hud = nil;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.customView = [[UIImageView alloc] init];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = mes;
    [hud hideAnimated:YES afterDelay:2];
}

-(void)showLoadingHUB:(NSString *)message
{
    if (hud) {
        hud.hidden = YES;
        hud = nil;
    }
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = message;
}

- (void)hideHUB
{
    if (hud) {
        hud.hidden = YES;
        hud = nil;
    }
}


- (void)showWindowLoadingHUB:(NSString *)message
{
    if (hud) {
        if([message isEqualToString:hud.label.text])
        {
            return ;
        }
        hud.hidden = YES;
        hud = nil;
    }
    hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    hud.removeFromSuperViewOnHide = YES;
    [self.view.window addSubview:hud];
    [hud showAnimated:YES];
    hud.label.text = message;
}



- (void)showHUBWithImageName:(NSString *)imageName message:(NSString*)message
{
    if (hud) {
        // [hudb removeFromSuperViewOnHide];
        hud.hidden = YES;
        hud = nil;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
  
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:2];
}

/*
 *标记的请求
 */
-(void)markRequest:(NSString*)Identifier task:(NSURLSessionDataTask*)task
{
    if(Identifier)
        [SessionDataTasks setValue:task forKey:Identifier];
}

/*
 *取消所有标记的请求
 */
-(void)cancelAllMarkRequest
{
    [SessionDataTasks enumerateKeysAndObjectsUsingBlock:^(id key, NSURLSessionDataTask* obj, BOOL *stop) {
        [obj cancel];
    }];
}


@end
