//
//  MoivesViewController.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/5.
//  Copyright © 2018年 King. All rights reserved.
//

#import "MoivesViewController.h"
#import "CinemaCell.h"
#import "RequestManager.h"
#import "MoivesTableViewCell.h"
#import "MovieObj.h"
@interface MoivesViewController ()<MoivesTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *cinemaDataSource;
@property (nonatomic,strong) NSMutableArray *moivesDataSource;

@end

@implementation MoivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self showLoadingHUB:@"正在加载..."];
    [self loadDataFromNetwork];
//    [self initMJRefresh];
}
//- (void)initMJRefresh{
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        [self loadDataFromNetwork];
//    }];
//}
//

/*
 *加载网络数据
 */
- (void)loadDataFromNetwork{
    
    dispatch_group_t group = dispatch_group_create();
    //获取广告数据
    dispatch_group_enter(group);
    [RequestManager getAdvertComplete:^(NSMutableArray *advertArray, NSError *error) {
        [self.bannerView setimageArrayWithAdverObjArray:advertArray];
        dispatch_group_leave(group);
    }];
    //获取热映电影数据
    dispatch_group_enter(group);
    [RequestManager getHitMoivesComplete:^(NSArray *moives, NSError *error) {
        self.moivesDataSource  = [NSMutableArray arrayWithArray:moives];
        dispatch_group_leave(group);
    }];
    //获取影院数据
    dispatch_group_enter(group);
    [RequestManager getCinemaComplete:^(NSMutableArray *cinemas, NSError *error) {
        self.cinemaDataSource = cinemas;
        dispatch_group_leave(group);
    }];
    __weak typeof(self) weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
        [weakSelf endRefreshing];
        [weakSelf hideHUB];
        [weakSelf hidenCoverView];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1){
        return 5;
    }
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"";
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                cellIdentifier = @"hotCell";
                break;
            case 1:
                cellIdentifier = @"moivesCell";
                break;
                
            default:
                break;
        }
    }else{
        cellIdentifier = @"cinemaCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    if([cell isKindOfClass:[CinemaCell class]]){
        [cell setValue:self.cinemaDataSource[indexPath.row] forKey:@"obj"];
    }else if([cell isKindOfClass:[MoivesTableViewCell class]]){
        MoivesTableViewCell *mCell = (MoivesTableViewCell*)cell;
        mCell.delegate = self;
        mCell.dataSource = self.moivesDataSource;
        [mCell.collectionView reloadData];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return  0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 && indexPath.row ==1){
        return 140;
    }else if (indexPath.section == 1){
        return 80;
    }
    return 44;
}

//取消cell选中状态
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        CinemaCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setLabelHighlightBackground];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section == 1){
        CinemaCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setLabelHighlightBackground];
        NSString *module_url = [self.cinemaDataSource[indexPath.row] valueForKey:@"module_url"];
        [self performSegueWithIdentifier:@"PushToCinemaDetail" sender:module_url];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma maek -MoivesTableViewCellDelegate
- (void)onclickCollectionItem:(MovieObj *)obj{
    [self performSegueWithIdentifier:@"pushToMoiveDetail" sender:obj];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"pushToMoiveDetail"]){
        [segue.destinationViewController setValue:sender forKey:@"movieObj"];
    } else if([segue.identifier isEqualToString:@"PushToAllHotMovies"]){
        [segue.destinationViewController setValue:self.moivesDataSource forKey:@"dataSource"];
    } else if([segue.identifier isEqualToString:@"PushToCinemaDetail"]){
        
        [segue.destinationViewController setValue:sender forKey:@"module_url"];
    }
}
@end
