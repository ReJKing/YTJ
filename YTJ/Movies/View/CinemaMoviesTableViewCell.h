//
//  CinemaMoviesTableViewCell.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CinemaMoviesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *scrollContainerView;

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
/*
 *  片长 | 类型 | 主演
 */
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@end
