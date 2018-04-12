//
//  CinemaMoviesTableViewController.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import "CinemaMoviesTableViewController.h"
#import "CinemaMoviesTableViewCell.h"
#import "SnackTableViewCell.h"
#import "RequestManager.h"
#import "CinemaObj.h"


@interface CinemaMoviesTableViewController ()
@property (nonatomic,strong) NSMutableArray *snackDataSource;
@property (nonatomic,strong) NSMutableArray *moviesDataSource;
@property (nonatomic,strong) NSDictionary *notice;
@property (nonatomic,strong) CinemaObj *cinema;
@property (nonatomic,strong) NSMutableArray *schedulesDataSource;
@end

@implementation CinemaMoviesTableViewController

- (NSMutableArray*)snackDataSource{
    if(_snackDataSource == nil){
        _snackDataSource = [NSMutableArray array];
    }
    return _snackDataSource;
}
- (NSMutableArray*)moviesDataSource{
    if(_moviesDataSource == nil){
        _moviesDataSource = [NSMutableArray array];
    }
    return _moviesDataSource;
}
- (NSMutableArray*)schedulesDataSource{
    if(_schedulesDataSource == nil){
        _schedulesDataSource = [NSMutableArray array];
    }
    return _schedulesDataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showHUB:@"正在加载..."];
    [self loadDataFromNetwork];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateUI{
    self.title = self.cinema.cinema_name;
    self.cinemaLabel.text = self.cinema.cinema_name;
    self.cinemaAddressLabel.text = self.cinema.cinema_address;
    self.noticeTitleLabel.text = self.notice[@"title"];
    self.noticeContentLabel.text = self.notice[@"content"];
    
}
- (void)loadDataFromNetwork{
    [RequestManager getCinemaDetailWithModuleUrl:self.module_url Complete:^(NSDictionary *resultData, NSError *error){
        [self endRefreshing];
        if(resultData != nil){
            [self hidenCoverView];
            [self hideHUB];
            self.cinema = resultData[@"cinema"];
            self.moviesDataSource = [resultData[@"movie"] mutableCopy];
            self.snackDataSource = resultData[@"snack"];
            self.notice = resultData[@"notice"];
            
            [self.tableView reloadData];
            [self updateUI];
            
           
            
        }
    }];
    
    [RequestManager getCinemaMovieSessiontWithMovieId:@"0" CinemaId:self.module_url Complete:^(NSMutableArray *resultData, NSError *error) {
        if(resultData && error == nil){
            self.schedulesDataSource = [resultData mutableCopy];
            
        }

        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if(section == 0){
        return 1;
    }
    return self.snackDataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"";
    if(indexPath.section == 0){
        identifier = @"CinemaMoviesTableViewCell";
    }else {
        identifier = @"SnackTableViewCell";
    }
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if([cell isKindOfClass:[CinemaMoviesTableViewCell class]]){
        if(self.moviesDataSource.count > 0){
             [cell setValue:self.moviesDataSource forKey:@"dataSource"];
        }
       
    }else if([cell isKindOfClass:[SnackTableViewCell class]]){
        [cell setValue:self.snackDataSource[indexPath.row] forKey:@"obj"];
    }
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 200;
    }
    return 80;
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (IBAction)onclickPhoneBtnHandle:(id)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.cinema.cinema_phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
