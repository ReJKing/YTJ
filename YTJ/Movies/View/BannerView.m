//
//  BannerView.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/5.
//  Copyright © 2018年 King. All rights reserved.
//

#import "BannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width


@interface BannerView()<UIScrollViewDelegate>

@end

@implementation BannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSArray*)dataSource{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_imageArray){
            _imageArray = [NSArray array];
        }
    });
    return _imageArray;
}
- (UIPageControl*)pageConterol{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_pageConterol){
            _pageConterol = [[UIPageControl alloc] init];
            _pageConterol.frame =CGRectMake(SCREEN_WIDTH/2 - _pageConterol.bounds.size.width/2, self.bounds.size.height-10, 0, 0);
        }
    });
    
    return _pageConterol;
}
- (UIScrollView*)scrollView{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_scrollView){
            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height)];
            _scrollView.delegate = self;
            _scrollView.pagingEnabled = YES;
            _scrollView.bounces = YES;
            _scrollView.showsVerticalScrollIndicator = NO;
            _scrollView.showsHorizontalScrollIndicator = NO;
        }
    });
    
    return _scrollView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
    }
    return self;

}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        NSLog(@"%@",self);
        [self addSubview:self.scrollView];
        [self addSubview:self.pageConterol];
    }
    return self;
}
/*
 *imageArraya内容为图片名，加载本地图片
 */
- (void)setImageArray:(NSArray *)imageArray{
    for(NSInteger i = 0; i < imageArray.count; i++){
        NSLog(@"%@",imageArray[i]);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.bounds.size.height)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        
        [self.scrollView addSubview:imageView];
        NSLog(@"%@-----",NSStringFromCGPoint(imageView.frame.origin));
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imageArray.count-1, 0);
    self.pageConterol.numberOfPages = imageArray.count;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndScrollingAnimation");
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    CGPoint point =  scrollView.contentOffset;
    NSLog(@"%@",NSStringFromCGPoint(point));
    NSInteger index =  roundf(point.x / scrollView.bounds.size.width);
    self.pageConterol.currentPage = index;
    NSLog(@"%ld",index);
}
    
-(void)setimageArrayWithAdverObjArray:(NSArray *)adverObjArray{
    for(NSInteger i = 0; i < adverObjArray.count; i++){
      
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.bounds.size.height)];
        AdvertObj *obj = adverObjArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj.img_url] placeholderImage:[UIImage imageNamed:@"b1"]];
        
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * adverObjArray.count-1, 0);
    self.pageConterol.numberOfPages = adverObjArray.count;
}
@end
