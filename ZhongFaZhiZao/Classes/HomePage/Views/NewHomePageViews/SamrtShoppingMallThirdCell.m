//
//  SamrtShoppingMallThirdCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SamrtShoppingMallThirdCell.h"

@implementation SamrtShoppingMallThirdCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell{
    //1.商品视图
    _goodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _goodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_goodsImgImageView];
    //2.商品名
    _goodsNameLabel = [[UILabel alloc] init];
    _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _goodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _goodsNameLabel.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:_goodsNameLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.
    CGFloat goodsImgWidth = 102/2.0 * KWidth_ScaleW;
    CGFloat goodsImgHeight = 78/2.0 * KWidth_ScaleH;
    CGFloat goodsImgGapFromTop = 15/2.0 * KWidth_ScaleH;
    _goodsImgImageView.frame = CGRectMake(0, goodsImgGapFromTop, goodsImgWidth, goodsImgHeight);
    _goodsImgImageView.image = [UIImage imageNamed:@"NewHomePageAuxiliaryIcon"];
    _goodsImgImageView.centerX = self.frame.size.width / 2.0;
    //2.
    NSString *goodsNameStr = @"标准电机";
    CGFloat goodsNameLabelGapFromBottom = 22/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelHeight = 37/2.0 * KWidth_ScaleH;
    CGSize goodsNameLblWidthSize = [_goodsNameLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsNameLabelHeight)];
    _goodsNameLabel.frame = CGRectMake(0,0, goodsNameLblWidthSize.width, goodsNameLabelHeight);
    _goodsNameLabel.text = goodsNameStr;
    [_goodsNameLabel sizeToFit];
    _goodsNameLabel.bottom = self.frame.size.height - goodsNameLabelGapFromBottom;
    _goodsNameLabel.centerX = self.frame.size.width / 2.0;
}
@end
