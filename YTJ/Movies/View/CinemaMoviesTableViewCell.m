//
//  CinemaMoviesTableViewCell.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import "CinemaMoviesTableViewCell.h"
#import "JKBrowserView.h"
@interface CinemaMoviesTableViewCell()<JKBrowserViewDelegate>

@property (nonatomic,strong) JKBrowserView *browser;
@end
@implementation CinemaMoviesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataSource:(NSMutableArray *)dataSource{
    
    _dataSource = dataSource;
    self.browser = [[JKBrowserView alloc] initWithFrame:self.scrollContainerView.bounds movies:dataSource];
    self.browser.delegate = self;
    [self.scrollContainerView addSubview:self.browser];
    [self updateUIWhitCurrentIndex:0];
    
}

- (void)updateUIWhitCurrentIndex:(NSInteger)index{
    MovieObj *obj = self.dataSource[index];
    self.movieNameLabel.text = obj.movieName;
    NSString *describe = [NSString stringWithFormat:@"%ld分钟 | %@ | %@",obj.duration,obj.style,obj.director];
    self.describeLabel.text = describe;
}

- (void)movieBrowser:(JKBrowserView *)movieBrowser didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"didSelectItemAtIndex---%ld",index);
    [self updateUIWhitCurrentIndex:index];
    
}
- (void)movieBrowser:(JKBrowserView *)movieBrowser didEndScrollingAtIndex:(NSInteger)index{
    NSLog(@"didEndScrollingAtIndex---%ld",index);
    [self updateUIWhitCurrentIndex:index];
}
- (void)movieBrowser:(JKBrowserView *)movieBrowser didChangeItemAtIndex:(NSInteger)index{
    NSLog(@"didChangeItemAtIndex---%ld",index);
    [self updateUIWhitCurrentIndex:index];
}

@end
