//
//  HomePageHeaderView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageHeaderModel.h"

typedef NS_ENUM(int,ZF){
    
    Supply = 0+1000,
    Intelligence,
    Science,
    Solve,
    Knowledge,
    Electronic
};
@interface HomePageHeaderView : UIView

@property (nonatomic, strong) HomePageHeaderModel *model;
@end
