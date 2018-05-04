//
//  SamrtShoppingMallFirstCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SamrtShoppingMallFirstCell.h"

@implementation SamrtShoppingMallFirstCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
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
    _goodsNameLabel.numberOfLines = 2;
    _goodsNameLabel.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:_goodsNameLabel];
    //3.商品价格
    _goodsPriceLabel = [[UILabel alloc] init];
    _goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    _goodsPriceLabel.textColor = [UIColor colorWithHexString:@"#002A00"];
    _goodsPriceLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_goodsPriceLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.
    CGFloat goodsImgWidth = 298/2.0 * KWidth_ScaleW;
    CGFloat goodsImgHeight = 179/2.0 * KWidth_ScaleH;
    CGFloat goodsImgGapFromLeft = 44/2.0 * KWidth_ScaleW;
    CGFloat goodsImgGapFromTop = 18/2.0 * KWidth_ScaleH;
    _goodsImgImageView.frame = CGRectMake(goodsImgGapFromLeft, goodsImgGapFromTop, goodsImgWidth, goodsImgHeight);
    _goodsImgImageView.image = [UIImage imageNamed:@"NewHomePageAuxiliaryIcon"];
    //2.
    NSString *goodsNameStr = @"库卡kuka kr 300-20垛机器人垛机器";
    CGFloat goodsNameLabelGapFromTop = 6/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelWidth = goodsImgWidth;
    CGSize goodsNameLblWidthSize = [_goodsNameLabel sizeThatFits:CGSizeMake(goodsNameLabelWidth,MAXFLOAT)];
    _goodsNameLabel.frame = CGRectMake(_goodsImgImageView.left,goodsNameLabelGapFromTop, goodsNameLabelWidth, goodsNameLblWidthSize.height);
    _goodsNameLabel.text = goodsNameStr;
    [_goodsNameLabel sizeToFit];
    //3.
    NSString *goodsPriceStr = @" 3,2000.00";
    if (goodsPriceStr == nil || goodsPriceStr == Nil) {
        goodsPriceStr = @"";
    }
    CGFloat goodsPriceLabelHeight = 15 * KWidth_ScaleH;
    NSString *profitStr = [NSString stringWithFormat:@"¥%@",goodsPriceStr];
    CGSize goodsPriceLblWidthSize = [_goodsPriceLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsPriceLabelHeight)];
    _goodsPriceLabel.frame = CGRectMake(_goodsNameLabel.left, _goodsNameLabel.bottom, goodsPriceLblWidthSize.width, goodsPriceLabelHeight);
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:profitStr];
    [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, 1)];
    [attr2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FF6600"] range:NSMakeRange(0, 1)];
//    [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.f] range:NSMakeRange(1, attr2.length - 1)];
    _goodsPriceLabel.attributedText = attr2;
    [_goodsPriceLabel sizeToFit];
}
@end
