//
//  CinemaMoviesTableViewController.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKBaseTableViewController.h"
@interface CinemaMoviesTableViewController : JKBaseTableViewController
@property (weak, nonatomic) IBOutlet UILabel *cinemaLabel;
@property (weak, nonatomic) IBOutlet UILabel *cinemaAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeContentLabel;
@property (nonatomic,strong) NSString *module_url;
@end
