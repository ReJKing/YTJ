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
- (void)setObj:(MoivesObj *)obj{
    _obj = obj;
    _nameLabel.text =obj.name;
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:obj.playbillUrl]
                              placeholderImage:[UIImage imageNamed:@"m1.png"]];
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:obj.playbillUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSThread currentThread]);
           _bgImageView.image = [UIImage blurryImage:image withBlurLevel:1.0];
        });
    }];
    
    

    CGFloat grade = [obj.grade floatValue];
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f分",grade];
    _genresLabel.text = [obj.genres componentsJoinedByString:@"/"];
    _directorLabel.text = obj.director;
}
@end
