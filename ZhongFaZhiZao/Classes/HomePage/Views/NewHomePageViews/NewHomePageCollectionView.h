//
//  NewHomePageCollectionView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewHomePageHeaderView.h"
#import "NewHomePageHeaderResult.h"

@interface NewHomePageCollectionView : UICollectionView

@property (nonatomic, strong) NewHomePageHeaderView *headerView;
@property (nonatomic, strong) NewHomePageHeaderResult *model;
@property (nonatomic,strong) NSMutableArray *cityArray;

@property (nonatomic,strong) NSArray *adResultArr;
@property (nonatomic,strong) NSArray *smartHeadlineNewsResultArr;

@end
