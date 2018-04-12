//
//  JKBaseTableViewController.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import "JKBaseTableViewController.h"
#import "MJRefresh.h"
@interface JKBaseTableViewController ()

@property (nonatomic,strong) UIView *coverView;

@end

@implementation JKBaseTableViewController

- (UIView*)coverView{

        if(_coverView == nil){
            _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
            _coverView.backgroundColor = [UIColor whiteColor];
        }
    return _coverView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.coverView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self performSelector:@selector(loadDataFromNetwork)];
    }];
    
}
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
        //        [hudb removeFromSuperViewOnHide];
        hud.hidden = YES;
        hud = nil;
    }
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.customView = [[UIImageView alloc] init];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = mes;
    [hud hideAnimated:YES afterDelay:2];
}
- (void)showHUBWithImageName:(NSString *)imageName message:(NSString*)message
{
    if (hud) {
        //        [hudb removeFromSuperViewOnHide];
        hud.hidden = YES;
        hud = nil;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:2];
}
-(void)showLoadingHUB:(NSString *)message
{
    if (hud) {
        //        [hudb removeFromSuperViewOnHide];
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
//    hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    hud.removeFromSuperViewOnHide = YES;
    [self.view.window addSubview:hud];
    [hud showAnimated:YES];
    hud.label.text = message;
}

-(void)markRequest:(NSString*)Identifier task:(NSURLSessionDataTask*)task
{
    if(Identifier)
        [SessionDataTasks setValue:task forKey:Identifier];
}

-(void)cancelAllMarkRequest
{
    [SessionDataTasks enumerateKeysAndObjectsUsingBlock:^(id key, NSURLSessionDataTask* obj, BOOL *stop) {
        [obj cancel];
    }];
}

- (void)hidenCoverView{
    [self.coverView removeFromSuperview];
}

- (void)endRefreshing{
    [self.tableView.mj_header endRefreshing];
}
@end
