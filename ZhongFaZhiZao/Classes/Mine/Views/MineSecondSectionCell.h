//
//  MineSecondSectionCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineSecondSectionCell : UITableViewCell
{
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UIImageView *_auxiliaryImageView;
    UIView *_bottomView;
}
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)NSDictionary *theDic;
@end
