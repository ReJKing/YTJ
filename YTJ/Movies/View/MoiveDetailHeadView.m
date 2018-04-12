//
//  MoiveDetailHeadView.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import "MoiveDetailHeadView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+Blur.h"
@implementation MoiveDetailHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (instancetype)moiveDetailHeadView{
    return [[NSBundle mainBundle] loadNibNamed:@"MoiveDetailHeadView" owner:nil options:nil].firstObject;
}
- (void)setObj:(MovieObj *)obj{
    _obj = obj;
    _nameLabel.text =obj.movieName;
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl]
                              placeholderImage:[UIImage imageNamed:@"m1.png"]];
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
           _bgImageView.image = [UIImage blurryImage:image withBlurLevel:1.0];
        });
    }];
    
    

//    _ratingLabel.text = [NSString stringWithFormat:@"%@分",obj.grade];
    _charactorLabel.text = [NSString stringWithFormat:@"%@",obj.charactor];
    _genresLabel.text = obj.style;
    _directorLabel.text = obj.director;
    _timeLengthLabel.text = [NSString stringWithFormat:@"%ld分钟",(long)obj.duration];
 
}
@end
