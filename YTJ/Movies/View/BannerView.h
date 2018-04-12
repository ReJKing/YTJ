//
//  BannerView.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/5.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertObj.h"

@interface BannerView : UIView
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageConterol;
@property (nonatomic,strong) NSArray *imageArray;

-(void)setimageArrayWithAdverObjArray:(NSArray *)adverObjArray;
@end
