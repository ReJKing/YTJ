//
//  MoivesTableViewCell.h
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesCollectionViewCell.h"

@protocol MoivesTableViewCellDelegate<NSObject>
@required
- (void)onclickCollectionItem:(MoivesObj *)obj;

@end

@interface MoivesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (nonatomic, weak, nullable) id <MoivesTableViewCellDelegate> delegate;

@end
