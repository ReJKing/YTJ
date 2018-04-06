//
//  MineViewController.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/4.
//  Copyright © 2018年 King. All rights reserved.
//

#import "MineViewController.h"
#import "UIImage+Blur.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headBgImageView.image = [UIImage blurryImage:[UIImage imageNamed:@"t1"] withBlurLevel:1.0];
    self.userHeadImageView.userInteractionEnabled = YES;
}
- (IBAction)onclickUserHeadImageViewHandel:(id)sender {
    [self performSegueWithIdentifier:@"pushToUserInfo" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section == 2 && indexPath.row == 1){
        [self onclickContactCSCellHandle];
    }else if(indexPath.section == 2 && indexPath.row == 2){
        NSLog(@"点击商务合作");
    }
}
/*
 *打电话
 */
- (void)onclickContactCSCellHandle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"+85378990987" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                            
                                                              NSLog(@"取消");
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             NSLog(@"呼叫");
                                                         }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
