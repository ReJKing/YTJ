//
//  MoiveDetailTableViewController.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import "MoiveDetailTableViewController.h"
#import "RequestManager.h"
#import "CinemaCell.h"
#import "MovieDescribesCell.h"


@interface MoiveDetailTableViewController ()
@property (nonatomic,strong) NSMutableArray * cinemas;
@property (nonatomic,strong) MoiveDetailHeadView *moiveDetailHeadView;
@end

@implementation MoiveDetailTableViewController

- (NSMutableArray*)cinemas{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_cinemas == nil){
            _cinemas = [NSMutableArray array];
        }
    });
     return _cinemas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _moiveDetailHeadView = [MoiveDetailHeadView moiveDetailHeadView];
    _moiveDetailHeadView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    _moiveDetailHeadView.obj = _movieObj;
    [self.headView addSubview:_moiveDetailHeadView];
    [self showWindowLoadingHUB:@"正在加载..."];
    [self loadDataFromNetwork];
    
}

//- (void)initMJRefresh{
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        [self loadDataFromNetwork];
//    }];
//}
- (void)loadDataFromNetwork{

    [RequestManager getMoiveDetailWithMoiveName:_movieObj.movieName Complete:^(NSDictionary *resultData, NSError *error) {
        if(resultData != nil && error == nil){
            self.movieObj = resultData[@"movie"];
            self.cinemas = resultData[@"cinemas"];
            [_moiveDetailHeadView setObj:self.movieObj];
            [self endRefreshing];
            [self hideHUB];
            [self hidenCoverView];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    }else
    return self.cinemas.count;
}

- (void)setMovieObj:(MovieObj *)movieObj{
    _movieObj = movieObj;
    self.title = movieObj.movieName;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identfire = nil;
    if(indexPath.section == 0){
       identfire = @"cinemaDescribeCell";
    }else{
        identfire = @"cinemaCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfire forIndexPath:indexPath];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identfire];
    }
    if([cell isKindOfClass:[CinemaCell class]]){
        [cell setValue:self.cinemas[indexPath.row] forKey:@"obj"];
    }else{
        
        
        /*************************/
        if(self.movieObj.content){
            NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            // 行间距设置为30
            [paragraphStyle  setLineSpacing:8];
            NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:self.movieObj.content];
            [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.movieObj.content length])];
            
            // 设置Label要显示的text
            [cell.textLabel  setAttributedText:setString];
        }
//        cell.textLabel.text = self.movieObj.content;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return  0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
//        if(self.isOn){
//            return [self calculatedMovieDescribeHeight];
//
//        }else{
//            return 100;
//        }
        return [self calculatedMovieDescribeHeight];
       
    }
   
    return 80;
}

- (CGFloat)calculatedMovieDescribeHeight{
    NSString *text = self.movieObj.content;
    if(text){
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineSpacing:8];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        style.alignment = NSTextAlignmentLeft;
        NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:style}];
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
        CGSize size =  [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        
        // 并不是高度计算不对，我估计是计算出来的数据是 小数，在应用到布局的时候稍微差一点点就不能保证按照计算时那样排列，所以为了确保布局按照我们计算的数据来，就在原来计算的基础上 取ceil值，再加1；
        CGFloat height = ceil(size.height) + 20;
        return height;
    }
    return 0;
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
    
    if(indexPath.section == 0){
       
    }else if(indexPath.section == 1){
        CinemaCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setLabelHighlightBackground];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    
