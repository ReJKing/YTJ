//
//  JKTABView.m
//  test
//
//  Created by Jacky xu on 2018/4/12.
//  Copyright © 2018年 King. All rights reserved.
//

#define W 120
#define H 30

#import "JKTABView.h"

@interface JKTABView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *cursorView;
@property (nonatomic,strong) CALayer *lineLayer;
@property (nonatomic,strong) UIColor *highlightedColor;

@end


@implementation JKTABView

- (CALayer*)lineLayer{
    if(_lineLayer == nil){
        _lineLayer  = [CALayer layer];
        _lineLayer.backgroundColor = self.highlightedColor.CGColor;
        _lineLayer.frame = CGRectMake(5, H, W-10, 2);
        
    }
    return _lineLayer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray*)array color:(UIColor*)color{
    if(self = [super initWithFrame:frame]){
        self.highlightedColor = color;
        [self initUIWithDataArray:array];
    }
    return self;
}

/*初始化基本控件*/
- (void)initUIWithDataArray:(NSArray*)array{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    for(NSInteger i = 0; i < array.count; i++){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(W*i, 0, W, H)];
        btn.tag = 10000 + i;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:self.highlightedColor forState:UIControlStateSelected];
        if(i == 0){
            btn.selected = YES;
            [btn.layer addSublayer:self.lineLayer];
        }
        [self.scrollView addSubview:btn];
    }
    self.scrollView.contentSize = CGSizeMake(W * array.count, 0);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    
}
- (void)test:(UIButton*)sender{
    
    [self.delegate selectedItemWithIndex:sender.tag - 10000];
    
    for(UIView *view in self.scrollView.subviews){
        if([view isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton*)view;
            btn.selected = NO;
            [self.lineLayer removeFromSuperlayer];
        }
    }
    sender.selected = YES;
    [sender.layer addSublayer:self.lineLayer];
    
}

@end
