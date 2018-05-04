//
//  MineHeaderView.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "MinePersonalInfoModel.h"

@interface MineHeaderView : UIView
{
    UIImageView *_bjImageView;
    UIImageView *_headerPortraitImageView;
    UILabel *_nameLabel;
    UIButton *_loginBtn;
    CustomButton *_informationBtn;
    UIImageView *_bqlbl1;
    UILabel *_bqLbl;
    UIView *_collectionBJView;
    UIView *_gapLine1View;
    UIView *_gapLine2View;
    UIView *_bottomView;

}
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) CustomButton *informationBtn;
@property (nonatomic,strong) UILabel *bqLbl;
@property (nonatomic,strong) UIImageView *bqlbl1;
@property (nonatomic,strong) MinePersonalInfoDatas *personalInformation;
@end
