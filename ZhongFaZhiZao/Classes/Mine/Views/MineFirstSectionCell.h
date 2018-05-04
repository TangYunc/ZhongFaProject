//
//  MineFirstSectionCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinePersonalInfoModel.h"

@interface MineFirstSectionCell : UITableViewCell
{
    //    我的订单小红点
    UILabel *_redLbl1;
    UILabel *_redLbl2;
    UILabel *_redLbl3;
    UILabel *_redLbl4;
    UIView *_bottomView;
}
@property(nonatomic,strong)UILabel *redLbl1;
@property(nonatomic,strong)UILabel *redLbl2;
@property(nonatomic,strong)UILabel *redLbl3;
@property(nonatomic,strong)UILabel *redLbl4;
@property(nonatomic,strong)UIView *bottomView;

@property (nonatomic, strong) MinePersonalInfoOrderCount *theOrderCount;
@end
