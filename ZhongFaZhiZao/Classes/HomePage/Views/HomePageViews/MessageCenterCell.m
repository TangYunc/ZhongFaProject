//
//  MessageCenterCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MessageCenterCell.h"

@implementation MessageCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

#pragma mark -- 初始化子视图
- (void)createUI {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-2*Margin, 240)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.masksToBounds = YES;
    backView.layer.borderWidth = 0.5;
    backView.layer.borderColor = [UIColor blackColor].CGColor;
    backView.layer.cornerRadius = 4;
    [self.contentView addSubview:backView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 8, CGRectGetWidth(backView.frame)-14-Margin, 24)];
    self.titleLabel.font = [UIFont systemFontOfSize:17.0];
    self.titleLabel.text = @"默认标题";
    [backView addSubview:self.titleLabel];
    
    self.mainImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Margin, 8+CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(backView.frame)-2*Margin, 272/2.0)];
    self.mainImgView.image = [UIImage imageNamed:@"InfoPlaceholderIcon"];
    [backView addSubview:self.mainImgView];
    
    self.sumLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 6+CGRectGetMaxY(self.mainImgView.frame), CGRectGetWidth(self.titleLabel.frame), 16)];
    self.sumLabel.font = [UIFont systemFontOfSize:12.0];
    self.sumLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    self.sumLabel.text = @"我祈祷拥有一颗透明的心灵，和会流泪的眼睛，给我再去相信的勇气，越过谎言去拥抱你";
    [backView addSubview:self.sumLabel];
    
    _lowbgdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sumLabel.frame)+6,kScreenWidth-2*Margin, 34)];
    _lowbgdView.backgroundColor = [UIColor colorWithRed:36/255.0 green:67/255.0 blue:86/255.0 alpha:0.1];
    [backView addSubview:_lowbgdView];
    
    _yueLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, (34-17)/2.0, 50, 17)];
    _yueLabel.text = @"阅读全文";
    _yueLabel.textColor = [UIColor blackColor];
    _yueLabel.alpha = 1;
    _yueLabel.font = [UIFont systemFontOfSize:12.0];
    [_lowbgdView addSubview:_yueLabel];
    
    _pimageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(backView.frame)-Margin-8, (CGRectGetHeight(_lowbgdView.frame)-15)/2.0, 8, 15)];
    _pimageView.image = [UIImage imageNamed:@"InfoShape"];
    _pimageView.hidden = NO;
    _pimageView.backgroundColor = [UIColor clearColor];
    [_lowbgdView addSubview:_pimageView];
}

@end
