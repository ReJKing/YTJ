//
//  HotMovieTableViewCell.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import "HotMovieTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation HotMovieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.buyLabel.layer.borderColor = [[UIColor colorWithRed:255/225.0 green:147/255.0 blue:0 alpha:1.000] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setObj:(MovieObj *)obj{
    
    _obj = obj;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl]
                              placeholderImage:[UIImage imageNamed:@"m1.png"]];
    self.movieNameLabel.text = obj.movieName;
    self.gradeLabel.text = [NSString stringWithFormat:@"%@分",obj.grade];
    self.charactorLabel.text = obj.charactor;
    self.onTimeLabel.text = obj.on_time;
}

@end
