//
//  MoivesTableViewCell.m
//  YTJ
//
//  Created by Jacky xu on 2018/4/6.
//  Copyright © 2018年 King. All rights reserved.
//

#import "MoivesTableViewCell.h"

@interface MoivesTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation MoivesTableViewCell

- (NSMutableArray*)dataSource{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_dataSource){
            _dataSource = [NSMutableArray array];
        }
    
    });
    return _dataSource;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"collectionCell";
    MoivesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.obj = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark -UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    MoivesObj *obj =self.dataSource[indexPath.row];
    NSLog(@"%@",obj.name);
    [self.delegate onclickCollectionItem:obj];
    
}

@end
