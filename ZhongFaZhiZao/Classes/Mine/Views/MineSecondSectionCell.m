//
//  MineSecondSectionCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MineSecondSectionCell.h"

@implementation MineSecondSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        //初始化子视图
        [self initSubviews];
    }
    return self;
}
//初始化子视图
- (void)initSubviews{
    
    //图片视图
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.clipsToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_iconImageView];
    
    //名字
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    _titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self.contentView addSubview:_titleLabel];
    
    //辅助视图
    //    _auxiliaryImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    //    _auxiliaryImageView.clipsToBounds = YES;
    //    _auxiliaryImageView.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.contentView addSubview:_auxiliaryImageView];
    
    //底部的线
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.contentView addSubview:_bottomView];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    _iconImageView.frame = CGRectMake(15 * KWidth_ScaleW, (self.height - 22) / 2.0, 22, 22);
    _iconImageView.image = self.theDic[@"image"];
    
    CGFloat titleLabelHeight = 14 * KWidth_ScaleH;
    //    CGSize titleLabelWidthSize = [_titleLabel sizeThatFits:CGSizeMake(MAXFLOAT,titleLabelHeight)];
    _titleLabel.frame = CGRectMake(_iconImageView.right + 13 * KWidth_ScaleW, 0, 130 * KWidth_ScaleW, titleLabelHeight);
    _titleLabel.text = self.theDic[@"title"];
    _titleLabel.centerY = _iconImageView.centerY;
    
    _bottomView.frame = CGRectMake(15 * KWidth_ScaleW, self.height - 0.5, self.width, 0.5);
    
}

@end
