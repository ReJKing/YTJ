//
//  MoivesCollectionViewCell.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/5.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesObj.h"

@interface MoivesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *playbillImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (nonatomic,strong) MoivesObj *obj;
@end
