//
//  JKTABView.h
//  test
//
//  Created by Jacky xu on 2018/4/12.
//  Copyright © 2018年 King. All rights reserved.
//

/*
 *选项卡
 */
#import <UIKit/UIKit.h>

@protocol JKTABViewDelegate <NSObject>
- (void)selectedItemWithIndex:(NSInteger)index;
@optional


@end

@interface JKTABView : UIView
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,assign) id<JKTABViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray*)array color:(UIColor*)color;
@end
