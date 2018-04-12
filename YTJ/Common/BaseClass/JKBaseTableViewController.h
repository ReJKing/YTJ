//
//  JKBaseTableViewController.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface JKBaseTableViewController : UITableViewController
{
    MBProgressHUD *hud;
    NSMutableDictionary*  SessionDataTasks;
}

- (void)showHUB:(NSString *)mes;
- (void)showLoadingHUB:(NSString *)message;
- (void)hideHUB;

- (void)showWindowLoadingHUB:(NSString *)message;

-(void)markRequest:(NSString*)Identifier task:(NSURLSessionDataTask*)task;
-(void)cancelAllMarkRequest;
- (void)showHUBWithImageName:(NSString *)imageName message:(NSString*)message;

- (void)hidenCoverView;
- (void)endRefreshing;
@end
