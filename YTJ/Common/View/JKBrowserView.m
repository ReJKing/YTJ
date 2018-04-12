//
//  JKBrowserView.m
//  test
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#define kScrollViewContentOffset (kScreenWidth / 2.0 - (kItemWidth / 2.0 + kItemSpacing))
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kItemSpacing 25.0
#define kItemWidth  70.0
#define kItemHeight 100.0
#define kItemSelectedWidth  85.0
#define kItemSelectedHeight 120.0

#define kMovieBrowserHeight 140.0

#import "JKBrowserView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JKBrowserView()<UIScrollViewDelegate>
@property (nonatomic, assign, readwrite) NSInteger      currentIndex;
@property (nonatomic, strong, readwrite) NSMutableArray *movies;
@property (nonatomic, assign, readwrite) CGPoint        scrollViewContentOffset;
@property (nonatomic, strong, readwrite) UIScrollView   *scrollView;
@property (nonatomic, strong, readwrite) NSMutableArray *items;//存影片
/*
 *  背景图
 */
@property (nonatomic, strong, readwrite) UIImageView    *backgroundImageView;
@property (nonatomic, assign, readwrite) BOOL           isTapDetected;
@end

@implementation JKBrowserView

- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies
{
    self = [super initWithFrame:frame];
    if (self) {
        self.movies = [movies mutableCopy];
        [self initUI];
    }
    
    return self;
}
- (void)initUI
{
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    _backgroundImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_backgroundImageView];
    if (self.movies.count > 0) {
        MovieObj *obj = [self.movies firstObject];
        [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl]];
    }
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    blurView.frame = self.bounds;
    [self addSubview:blurView];
    
    [self setupScrollView];
    
}
/*
 *     初始化scrollView
 */
- (void)setupScrollView{
    CGRect scrollFrame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    _scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    [self addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.delegate = self;
    _scrollView.contentInset = UIEdgeInsetsMake(0, kScrollViewContentOffset, 0, kScrollViewContentOffset);
    //kMovieBrowserHeight-->0不让它上下滑动
    _scrollView.contentSize = CGSizeMake((kItemWidth + kItemSpacing) * self.movies.count + kItemSpacing, 0);
    NSInteger i = 0;
    _items = [NSMutableArray array];
    for (MovieObj *obj in self.movies) {
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake((kItemSpacing + kItemWidth) * i + kItemSpacing, (kMovieBrowserHeight - kItemHeight) - 15, kItemWidth, kItemHeight)];
        [_scrollView addSubview:itemView];
        
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemHeight)];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.layer.borderWidth = 1.0;
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i + 100;
        [itemView addSubview:imageView];
        [self.items addObject:imageView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        [imageView addGestureRecognizer:tapGesture];
        
        i++;
    }
    [self adjustSubviews:_scrollView];
}

#pragma mark - Tap Detection 点击图片事件处理

- (void)tapDetected:(UITapGestureRecognizer *)tapGesture
{
    if (tapGesture.view.tag == self.currentIndex + 100) {
        if ([self.delegate respondsToSelector:@selector(movieBrowser:didSelectItemAtIndex:)]) {
            [self.delegate movieBrowser:self didSelectItemAtIndex:self.currentIndex];
            return;
        }
    }
    
    CGPoint point = [tapGesture.view.superview convertPoint:tapGesture.view.center toView:self.scrollView];
    point = CGPointMake(point.x - kScrollViewContentOffset - ((kItemWidth / 2 + kItemSpacing)), 0);
    self.scrollViewContentOffset = point;
    
    self.isTapDetected = YES;
    
    [self.scrollView setContentOffset:point animated:YES];
    
}

- (void)adjustSubviews:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x + kScrollViewContentOffset) / (kItemWidth + kItemSpacing);
    index = MIN(self.movies.count - 1, MAX(0, index));
    
    CGFloat scale = (scrollView.contentOffset.x + kScrollViewContentOffset - (kItemWidth + kItemSpacing) * index) / (kItemWidth + kItemSpacing);
    if (self.movies.count > 0) {
        CGFloat height;
        CGFloat width;
        
        if (scale < 0.0) {
            scale = 1 - MIN(1.0, ABS(scale));
            
            UIImageView *leftView = self.items[index];
            leftView.layer.borderColor = [UIColor colorWithWhite:1 alpha:scale].CGColor;
            height = kItemHeight + (kItemSelectedHeight - kItemHeight) * scale;
            width = kItemWidth + (kItemSelectedWidth - kItemWidth) * scale;
            leftView.frame = CGRectMake(-(width - kItemWidth) / 2, -(height - kItemHeight), width, height);
            
            if (index + 1 < self.movies.count) {
                UIImageView *rightView = self.items[index + 1];
                rightView.frame = CGRectMake(0, 0, kItemWidth, kItemHeight);
                rightView.layer.borderColor = [UIColor clearColor].CGColor;
            }
            
        } else if (scale <= 1.0) {
            if (index + 1 >= self.movies.count) {
                
                scale = 1 - MIN(1.0, ABS(scale));
                
                UIImageView *imgView = self.items[self.movies.count - 1];
                imgView.layer.borderColor = [UIColor colorWithWhite:1 alpha:scale].CGColor;
                height = kItemHeight + (kItemSelectedHeight - kItemHeight) * scale;
                width = kItemWidth + (kItemSelectedWidth - kItemWidth) * scale;
                imgView.frame = CGRectMake(-(width - kItemWidth) / 2, -(height - kItemHeight), width, height);
                
            } else {
                CGFloat scaleLeft = 1 - MIN(1.0, ABS(scale));
                UIImageView *leftView = self.items[index];
                leftView.layer.borderColor = [UIColor colorWithWhite:1 alpha:scaleLeft].CGColor;
                height = kItemHeight + (kItemSelectedHeight - kItemHeight) * scaleLeft;
                width = kItemWidth + (kItemSelectedWidth - kItemWidth) * scaleLeft;
                leftView.frame = CGRectMake(-(width - kItemWidth) / 2, -(height - kItemHeight), width, height);
                
                CGFloat scaleRight = MIN(1.0, ABS(scale));
                UIImageView *rightView = self.items[index + 1];
                rightView.layer.borderColor = [UIColor colorWithWhite:1 alpha:scaleRight].CGColor;
                height = kItemHeight + (kItemSelectedHeight - kItemHeight) * scaleRight;
                width = kItemWidth + (kItemSelectedWidth - kItemWidth) * scaleRight;
                rightView.frame = CGRectMake(-(width - kItemWidth) / 2, -(height - kItemHeight), width, height);
            }
        }
        
        for (UIImageView *imgView in self.items) {
            if (imgView.tag != index + 100 && imgView.tag != (index + 100 + 1)) {
                imgView.frame = CGRectMake(0, 0, kItemWidth, kItemHeight);
                imgView.layer.borderColor = [UIColor clearColor].CGColor;
            }
        }
        
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x + kScrollViewContentOffset + (kItemWidth / 2 + kItemSpacing / 2)) / (kItemWidth + kItemSpacing);
    index = MIN(self.movies.count - 1, MAX(0, index));
    
    if (self.currentIndex != index) {
        self.currentIndex = index;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(movieBrowserDidEndScrolling) object:nil];
    
    [self adjustSubviews:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSInteger index = (targetContentOffset->x + kScrollViewContentOffset + (kItemWidth / 2 + kItemSpacing / 2)) / (kItemWidth + kItemSpacing);
    targetContentOffset->x = (kItemSpacing + kItemWidth) * index - kScrollViewContentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self performSelector:@selector(movieBrowserDidEndScrolling) withObject:nil afterDelay:0.1];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //iPhone X 不刷新影片数据问题所在
    //    NSLog(@"%@",NSStringFromCGPoint(self.scrollViewContentOffset));
    //    NSLog(@"%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    //    NSLog(@"状态：%d",!CGPointEqualToPoint(self.scrollViewContentOffset, self.scrollView.contentOffset));
    //    if (!CGPointEqualToPoint(self.scrollViewContentOffset, self.scrollView.contentOffset)) {
    //        if (self.isTapDetected) {
    //            self.isTapDetected = NO;
    //            [self.scrollView setContentOffset:self.scrollViewContentOffset animated:YES];
    //        }
    //    } else {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self movieBrowserDidEndScrolling];
    });
    //    }
}

#pragma mark - end scrolling handling

- (void)movieBrowserDidEndScrolling
{
    if ([self.delegate respondsToSelector:@selector(movieBrowser:didEndScrollingAtIndex:)]) {
        [self.delegate movieBrowser:self didEndScrollingAtIndex:self.currentIndex];
    }
    
    if (self.currentIndex < self.movies.count) {
        [self backgroundViewFadeTransition];
    }
}

#pragma mark - backgroundView

- (void)backgroundViewFadeTransition
{
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:((MovieObj *)self.movies[self.currentIndex]).imgUrl]];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.45f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.backgroundImageView.layer addAnimation:transition forKey:nil];
}

#pragma mark - setters

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    if ([self.delegate respondsToSelector:@selector(movieBrowser:didChangeItemAtIndex:)]) {
        [self.delegate movieBrowser:self didChangeItemAtIndex:_currentIndex];
    }
}

@end
