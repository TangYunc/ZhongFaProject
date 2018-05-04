//
//  SolveView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/10.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewHomeSolveResult.h"

@interface SolveView : UIView
{
    UIView *_companyBJView;
    UIImageView *_companyLogoImageView;
    UILabel *_companyNameLabel;
    UILabel *_companyInfoLabel;
    UIImageView *_companyImageView;
    UIView *_solutionBJView;
    UIView *_gapLineView;
}

@property (nonatomic, strong)NewHomePageSolveDatas *solveDatas;
@end
