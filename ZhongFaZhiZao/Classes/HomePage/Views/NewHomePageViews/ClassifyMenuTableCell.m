//
//  ClassifyMenuTableCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/10.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ClassifyMenuTableCell.h"

@implementation ClassifyMenuTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        //初始化子视图
        [self initSubviews];
    }
    return self;
}

//初始化子视图
- (void)initSubviews{
    
    //1.标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _titleLabel.font = [UIFont systemFontOfSize:11.f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    //2.底部的线
    _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#D5D5D5"];
    [self.contentView addSubview:_bottomLine];
    
}
/*
- (void)setMenuResult:(ClassifyMenuResult *)menuResult{
    
    _menuResult = menuResult;
    NSString *titleStr = [NSString stringWithFormat:@"%@",menuResult.title];
    CGFloat titleLabelGapFromTop = 16/2.0 * KWidth_ScaleH;
    CGFloat titleLabelHeight = 30/2.0 * KWidth_ScaleH;
    CGSize titleLblWidthSize = [_titleLabel sizeThatFits:CGSizeMake(MAXFLOAT,titleLabelHeight)];
    _titleLabel.frame = CGRectMake(0,titleLabelGapFromTop, titleLblWidthSize.width, titleLabelHeight);
    _titleLabel.text = titleStr;
    [_titleLabel sizeToFit];
    _titleLabel.left = (self.frame.size.width - _titleLabel.width) / 2.0;
    
    
    if (_menuResult.isSelected) {
        self.titleLabel.textColor = [UIColor colorWithRed:250/255.0 green:59/255.0 blue:37/255.0 alpha:1];
    }else {
        self.titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    }
    CGFloat bottomLineWidth = 100/2.0 * KWidth_ScaleW;
    CGFloat bottomLineGapFromLeft = (self.frame.size.width - bottomLineWidth) / 2.0;
    _bottomLine.frame = CGRectMake(bottomLineGapFromLeft, self.height - 0.5, bottomLineWidth, 0.5);
    
}*/
- (void)layoutSubviews{
    
    [super layoutSubviews];
    NSString *titleStr = self.menuResult.title;
    CGFloat titleLabelGapFromTop = 16/2.0 * KWidth_ScaleH;
    CGFloat titleLabelHeight = 30/2.0 * KWidth_ScaleH;
    CGSize titleLblWidthSize = [_titleLabel sizeThatFits:CGSizeMake(MAXFLOAT,titleLabelHeight)];
    _titleLabel.frame = CGRectMake(0,titleLabelGapFromTop, titleLblWidthSize.width, titleLabelHeight);
    _titleLabel.text = titleStr;
    [_titleLabel sizeToFit];
    _titleLabel.left = (self.frame.size.width - _titleLabel.width) / 2.0;
    
    
    if (_menuResult.isSelected) {
        self.titleLabel.textColor = [UIColor colorWithRed:250/255.0 green:59/255.0 blue:37/255.0 alpha:1];
    }else {
        self.titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    }
    CGFloat bottomLineWidth = 100/2.0 * KWidth_ScaleW;
    CGFloat bottomLineGapFromLeft = (self.frame.size.width - bottomLineWidth) / 2.0;
    CGFloat bottomLineGapFromTop = 11/2.0 * KWidth_ScaleW;
    _bottomLine.frame = CGRectMake(bottomLineGapFromLeft, _titleLabel.bottom + bottomLineGapFromTop, bottomLineWidth, 0.5);
}
@end
