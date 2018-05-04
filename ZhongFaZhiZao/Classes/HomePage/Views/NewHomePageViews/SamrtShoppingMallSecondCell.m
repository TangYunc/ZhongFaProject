//
//  SamrtShoppingMallSecondCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SamrtShoppingMallSecondCell.h"

@implementation SamrtShoppingMallSecondCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell{
    //1.商品名
    _goodsNameLabel = [[UILabel alloc] init];
    _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _goodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _goodsNameLabel.numberOfLines = 2;
    _goodsNameLabel.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:_goodsNameLabel];
    //2.商品视图
    _goodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _goodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_goodsImgImageView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.
    NSString *goodsNameStr = @"西门子链接总线 6ES7";
//    CGFloat goodsNameLabelGapFromTop = 43/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelGapFromLeft = 34/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelWidth = 139/2.0 * KWidth_ScaleW;
    CGSize goodsNameLblWidthSize = [_goodsNameLabel sizeThatFits:CGSizeMake(goodsNameLabelWidth,MAXFLOAT)];
    _goodsNameLabel.frame = CGRectMake(goodsNameLabelGapFromLeft,0, goodsNameLabelWidth, goodsNameLblWidthSize.height);
    _goodsNameLabel.text = goodsNameStr;
    [_goodsNameLabel sizeToFit];
    _goodsNameLabel.centerY = self.frame.size.height / 2.0;
    //2.
    CGFloat goodsImgWidth = 170/2.0 * KWidth_ScaleW;
    CGFloat goodsImgHeight = 138/2.0 * KWidth_ScaleH;
    CGFloat goodsImgGapFromRight = 16/2.0 * KWidth_ScaleW;
    _goodsImgImageView.frame = CGRectMake(_goodsNameLabel.right + goodsImgGapFromRight, 0, goodsImgWidth, goodsImgHeight);
    _goodsImgImageView.centerY = self.frame.size.height / 2.0;
    [_goodsImgImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
}
@end
