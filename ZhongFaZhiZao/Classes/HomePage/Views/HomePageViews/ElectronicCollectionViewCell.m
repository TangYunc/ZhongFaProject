//
//  ElectronicCollectionViewCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ElectronicCollectionViewCell.h"

@implementation ElectronicCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell{
    
    _ElectronicImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_ElectronicImg];
    
    _mengbanImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _mengbanImg.userInteractionEnabled = YES;
    [self.contentView addSubview:_mengbanImg];
    
    _mengbanLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _mengbanLabel.textColor = [UIColor whiteColor];
    _mengbanLabel.font = [UIFont boldSystemFontOfSize:13.0];
    _mengbanLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_mengbanLabel];
    
    
    _leftLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    _leftLbl.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_leftLbl];
    
    _rightLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    _rightLbl.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_rightLbl];
    
    _icon = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_icon];
    
    
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _cityLabel.font = [UIFont boldSystemFontOfSize:10.0];
    _cityLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_cityLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _ElectronicImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_ElectronicImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dataDic[@"small_pic"]]] placeholderImage:[UIImage imageNamed:@"DefaultImage750"]];
    
    _mengbanImg.frame = _ElectronicImg.frame;
    _mengbanImg.image = [UIImage imageNamed:@"HomePageMaskIcon"];
    
    _mengbanLabel.frame = CGRectMake(0, 51*KWidth_ScaleH, kScreenWidth, 17);
    _mengbanLabel.text = [NSString stringWithFormat:@"%@",self.dataDic[@"center_name"]];
    
    _leftLbl.frame = CGRectMake(100*KWidth_ScaleW, 81*KWidth_ScaleH, 56*KWidth_ScaleW, 1.5);
    
    _rightLbl.frame = CGRectMake(kScreenWidth - 100*KWidth_ScaleW- 56*KWidth_ScaleW, 81*KWidth_ScaleH, 56*KWidth_ScaleW, 1.5);
    
    _icon.frame = CGRectMake(12*KWidth_ScaleW+CGRectGetMaxX(_leftLbl.frame), 77*KWidth_ScaleH, 10*KWidth_ScaleW, 12*KWidth_ScaleH);
    _icon.image = [UIImage imageNamed:@"HomePageLocationIcon"];
    
    _cityLabel.frame = CGRectMake(5*KWidth_ScaleW+CGRectGetMaxX(_icon.frame), 76*KWidth_ScaleH, 26*KWidth_ScaleW, 14*KWidth_ScaleH);
    _cityLabel.text = [NSString stringWithFormat:@"%@",self.dataDic[@"city"]];
}
@end
