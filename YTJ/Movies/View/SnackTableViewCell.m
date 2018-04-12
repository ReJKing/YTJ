//
//  SnackTableViewCell.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/12.
//  Copyright © 2018年 King. All rights reserved.
//

#import "SnackTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SnackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.buyBtn.layer.borderColor = [[UIColor colorWithRed:255/225.0 green:147/255.0 blue:0 alpha:1.000] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObj:(SnackObj *)obj{
    _obj = obj;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:obj.img_url] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = obj.title;
    _priceLabel.text = [NSString stringWithFormat:@"%@MOP",obj.price];
    _originalPriceLabel.text = [NSString stringWithFormat:@"影院价格:%@MOP",_obj.cinema_price];
    
}

@end
