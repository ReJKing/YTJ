//
//  UIImageView+Blur.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
