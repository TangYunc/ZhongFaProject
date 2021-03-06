//
//  ScienceResultGoodsCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ScienceResultGoodsCell.h"

@implementation ScienceResultGoodsCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
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
    _goodsNameLabel.font = [UIFont boldSystemFontOfSize:14.f];
    [self.contentView addSubview:_goodsNameLabel];
    //3.商品可值得推荐类型
    _goodsTypeLabel = [[UILabel alloc] init];
    _goodsTypeLabel.textAlignment = NSTextAlignmentCenter;
    _goodsTypeLabel.textColor = [UIColor colorWithHexString:@"#FF6600"];
    _goodsTypeLabel.font = [UIFont systemFontOfSize:10.f];
    _goodsTypeLabel.layer.borderWidth = 0.5;
    _goodsTypeLabel.layer.borderColor = [UIColor colorWithHexString:@"#FF6600 "].CGColor;
    [self.contentView addSubview:_goodsTypeLabel];
    //4.商品价格
    _goodsPriceLabel = [[UILabel alloc] init];
    _goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    _goodsPriceLabel.textColor = [UIColor colorWithHexString:@"#FF6600"];
    _goodsPriceLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_goodsPriceLabel];
    //5.商品出货位置Label
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.textAlignment = NSTextAlignmentLeft;
    _locationLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _locationLabel.font = [UIFont systemFontOfSize:11.f];
    [self.contentView addSubview:_locationLabel];
    //6.商品出货位置视图
    _locationImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _locationImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_locationImageView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.
    CGFloat goodsImgWidth = 114/2.0 * KWidth_ScaleW;
    CGFloat goodsImgHeight = 118/2.0 * KWidth_ScaleH;
    CGFloat goodsImgGapFromLeft = 24/2.0 * KWidth_ScaleW;
    CGFloat goodsImgGapFromTop = 41/2.0 * KWidth_ScaleH;
    _goodsImgImageView.frame = CGRectMake(goodsImgGapFromLeft, goodsImgGapFromTop, goodsImgWidth, goodsImgHeight);
    [_goodsImgImageView sd_setImageWithURL:[NSURL URLWithString:self.datas.image] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
    //2.
    NSString *goodsNameStr = self.datas.product_name;
    CGFloat goodsNameLabelGapFromTop = 23.5/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelGapFromLeft = 44/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelHeight = 37/2.0 * KWidth_ScaleH;
    CGSize goodsNameLblWidthSize = [_goodsNameLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsNameLabelHeight)];
    _goodsNameLabel.frame = CGRectMake(_goodsImgImageView.right + goodsNameLabelGapFromLeft,goodsNameLabelGapFromTop, goodsNameLblWidthSize.width, goodsNameLabelHeight);
    _goodsNameLabel.text = goodsNameStr;
    [_goodsNameLabel sizeToFit];
    //3.
    NSString *goodsTypeStr = self.datas.label;
    CGFloat goodsTypeLblHeight = 36/2.0 * KWidth_ScaleH;
    CGFloat goodsTypeLabelGapFromTop = 20/2.0 * KWidth_ScaleH;
    CGSize goodsTypeLblWidthSize = [_goodsTypeLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsTypeLblHeight)];
    _goodsTypeLabel.frame = CGRectMake(_goodsNameLabel.left,_goodsNameLabel.bottom + goodsTypeLabelGapFromTop, goodsTypeLblWidthSize.width, goodsTypeLblHeight);
    _goodsTypeLabel.text = goodsTypeStr;
    [_goodsTypeLabel sizeToFit];
    _goodsTypeLabel.layer.cornerRadius = _goodsTypeLabel.width / 12.0;
    //4.
    NSString *goodsPriceStr = self.datas.price;
    if (goodsPriceStr == nil || goodsPriceStr == Nil) {
        goodsPriceStr = @"";
    }
    CGFloat goodsPriceLabelHeight = 15 * KWidth_ScaleH;
    CGFloat goodsPriceLabelGapFromBottom = 34.5/2.0 * KWidth_ScaleH;
    NSString *profitStr = [NSString stringWithFormat:@"¥%@",goodsPriceStr];
    CGSize goodsPriceLblWidthSize = [_goodsPriceLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsPriceLabelHeight)];
    _goodsPriceLabel.frame = CGRectMake(_goodsTypeLabel.left, 0, goodsPriceLblWidthSize.width, goodsPriceLabelHeight);
    _goodsPriceLabel.bottom = self.frame.size.height - goodsPriceLabelGapFromBottom;
    _goodsPriceLabel.text = profitStr;
    [_goodsPriceLabel sizeToFit];
    //5.
    NSString *locationStr = self.datas.corp_city_name;
    CGFloat locationLabelGapFrombottom = 34.5/2.0 * KWidth_ScaleH;
    CGFloat locationLabelGapFromRight = 30/2.0 * KWidth_ScaleW;
    CGFloat locationLabelHeight = 30/2.0 * KWidth_ScaleH;
    CGSize locationLblWidthSize = [_locationLabel sizeThatFits:CGSizeMake(MAXFLOAT,locationLabelHeight)];
    _locationLabel.frame = CGRectMake(0,0, locationLblWidthSize.width, locationLabelHeight);
    _locationLabel.bottom = self.frame.size.height - locationLabelGapFrombottom;
    _locationLabel.text = locationStr;
    [_locationLabel sizeToFit];
    _locationLabel.right = self.frame.size.width - locationLabelGapFromRight;
    //6.
    CGFloat locationImgWidth = 22/2.0 * KWidth_ScaleW;
    CGFloat locationImgHeight = 28/2.0 * KWidth_ScaleH;
    CGFloat locationImgGapFromRight = 7.6/2.0 * KWidth_ScaleW;
    _locationImageView.frame = CGRectMake(0, 0, locationImgWidth, locationImgHeight);
    _locationImageView.bottom = _locationLabel.bottom;
    _locationImageView.right = _locationLabel.left - locationImgGapFromRight;
    _locationImageView.image = [UIImage imageNamed:@"NewHomePageLocationIcon"];
}

@end
