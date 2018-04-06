//
//  CinemaCell.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/5.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaObj.h"
@interface CinemaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cinemaNameLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferentialLabel;
@property (nonatomic,strong) CinemaObj *obj;
- (void)setLabelHighlightBackground;
@end
