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

- (void)setObj:(MoivesObj *)obj{
     [self.playbillImageView sd_setImageWithURL:[NSURL URLWithString:obj.playbillUrl]
                                        placeholderImage:[UIImage imageNamed:@"m1.png"]];
    self.nameLabel.text = obj.name;
    CGFloat grade = [obj.grade floatValue];
    self.gradeLabel.text = [NSString stringWithFormat:@"%.1f分",grade];
}
@end
