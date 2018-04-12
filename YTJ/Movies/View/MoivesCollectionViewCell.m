//
//  MoivesCollectionViewCell.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/5.
//  Copyright © 2018年 King. All rights reserved.
//

#import "MoivesCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MoivesCollectionViewCell

- (void)setObj:(MovieObj *)obj{
     [self.playbillImageView sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl]
                                        placeholderImage:[UIImage imageNamed:@"m1.png"]];
    self.nameLabel.text = obj.movieName;
    self.gradeLabel.text = [NSString stringWithFormat:@"%@分",obj.grade];
}
@end
