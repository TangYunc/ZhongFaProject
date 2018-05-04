//
//  NewHomePageHeaderView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageHeaderModel.h"

typedef NS_ENUM(int,ZF){
    
    ScienceResult = 0+1000,
    SmartInformation,
    Solve,
    PhysicalMarket,
    SamrtShoppingMall,
    SupplyChain
};

@interface NewHomePageHeaderView : UIView

@property (nonatomic, strong) HomePageHeaderModel *model;
@property (nonatomic,strong) NSArray *smartShoppingMallArr;//智造商城
@property (nonatomic,strong) NSArray *recommendArr;
@property (nonatomic,strong) NSArray *smartHeadlineNewsResultArr;

@property (nonatomic,strong) NSMutableArray *cityArray;

@end
