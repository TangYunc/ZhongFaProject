//
//  SSMSecondSectionCell.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMResult.h"

@interface SSMSecondSectionCell : UITableViewCell
{
    UIView *_bjView;
    UIImageView *_bjImgView;
    UILabel *_titleLabel;
    UIButton *_moreBtn;
}

@property (nonatomic, copy) NSString *fromColorName;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, strong) SSMDatasCates *cates;
@end
