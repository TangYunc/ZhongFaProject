//
//  HomePageCollectionView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageHeaderView.h"
#import "HomePageHeaderModel.h"

@interface HomePageCollectionView : UICollectionView

@property (nonatomic, strong) HomePageHeaderView *headerView;
@property (nonatomic, strong) HomePageHeaderModel *model;
@property (nonatomic,strong) NSMutableArray *cityArray;

@end
