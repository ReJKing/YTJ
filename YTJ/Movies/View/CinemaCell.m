//
//  CinemaCell.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/5.
//  Copyright © 2018年 King. All rights reserved.
//

#import "CinemaCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CinemaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.buyLabel.layer.borderColor = [[UIColor colorWithRed:255/225.0 green:147/255.0 blue:0 alpha:1.000] CGColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setObj:(CinemaObj *)obj{
    
    _obj = obj;
    self.cinemaNameLable.text = _obj.name;
    self.addressLable.text = _obj.address;
    self.priceLable.text = _obj.price;
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    [self setLabelHighlightBackground];
}
- (void)setLabelHighlightBackground{
    _vipLabel.backgroundColor = [UIColor colorWithRed:202/255.0 green:180/255.0 blue:9/255.0 alpha:1.0];
    _foodLabel.backgroundColor = [UIColor colorWithRed:61/255.0 green:228/255.0 blue:227/255.0 alpha:1.0];
    _preferentialLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:127/255.0 blue:8/255.0 alpha:1.0];
}
@end
