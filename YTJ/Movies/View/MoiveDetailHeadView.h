//
//  MoiveDetailHeadView.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesObj.h"


@interface MoiveDetailHeadView : UIView

/*
 *  电影名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/*
 *  电影名称
 */
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
/*
 *  背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
/*
 *  电影评分
 */
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
/*
 *  电影类型
 */
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
/*
 *  导演
 */
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
/*
 *  电影时长
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLengthLabel;
/*
 *  上映时间
 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic,strong) MoivesObj *obj;

+ (instancetype)moiveDetailHeadView;

@end
