//
//  NewHomePageCollectionView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewHomePageHeaderView.h"
#import "HomePageHeaderModel.h"

@interface NewHomePageCollectionView : UICollectionView

@property (nonatomic, strong) NewHomePageHeaderView *headerView;
@property (nonatomic, strong) HomePageHeaderModel *model;//轮播图
@property (nonatomic,strong) NSArray *smartHeadlineNewsResultArr;//智造头条
@property (nonatomic,strong) NSArray *smartShoppingMallArr;//智造商城
@property (nonatomic,strong) NSArray *recommendArr;//为您推荐
@property (nonatomic,strong) NSArray *scienceResultArr;//科技成果
@property (nonatomic,strong) NSArray *solveArr;//解决方案
@property (nonatomic,strong) NSMutableArray *cityArray;

@property (nonatomic,strong) UIView *navigationView;
@property (nonatomic, strong) UIView *navBarView;
@end
