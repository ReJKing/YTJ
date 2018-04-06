//
//  MoiveDetailTableViewController.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesObj.h"
#import "MoiveDetailHeadView.h"
@interface MoiveDetailTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic,strong) MoivesObj *moiveObj;
@end
