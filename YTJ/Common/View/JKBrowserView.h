//
//  JKBrowserView.h
//  test
//
//  Created by Jacky xu on 2018/4/11.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieObj.h"

@class JKBrowserView;
@protocol JKBrowserViewDelegate <NSObject>

@optional
- (void)movieBrowser:(JKBrowserView *)movieBrowser didSelectItemAtIndex:(NSInteger)index;
- (void)movieBrowser:(JKBrowserView *)movieBrowser didEndScrollingAtIndex:(NSInteger)index;
- (void)movieBrowser:(JKBrowserView *)movieBrowser didChangeItemAtIndex:(NSInteger)index;

@end

@interface JKBrowserView : UIView
@property (nonatomic, assign, readwrite) id<JKBrowserViewDelegate> delegate;
@property (nonatomic, assign, readonly)  NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies;
@end
