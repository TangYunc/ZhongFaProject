//
//  SSMSecondSectionView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMSecondSectionView.h"

@implementation SSMSecondSectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubview];
    }
    return self;
}

- (void)setUpSubview{
    //1.商品视图
    _goodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _goodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImgImageView];
    //2.商品名
    _goodsNameLabel = [[UILabel alloc] init];
    _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _goodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _goodsNameLabel.numberOfLines = 2;
    _goodsNameLabel.font = [UIFont systemFontOfSize:KFloat(12.f)];
    [self addSubview:_goodsNameLabel];
    //2.月销量
    _salesVolumeLabel = [[UILabel alloc] init];
    _salesVolumeLabel.textAlignment = NSTextAlignmentLeft;
    _salesVolumeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _salesVolumeLabel.font = [UIFont systemFontOfSize:KFloat(11.f)];
    [self addSubview:_salesVolumeLabel];
    //4.商品价格
    _goodsPriceLabel = [[UILabel alloc] init];
    _goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    _goodsPriceLabel.textColor = [UIColor colorWithHexString:@"#FF6600"];
    _goodsPriceLabel.font = [UIFont systemFontOfSize:KFloat(11.f)];
    [self addSubview:_goodsPriceLabel];
    //5.
    _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_coverBtn setBackgroundColor:[UIColor clearColor]];
    [_coverBtn addTarget:self action:@selector(currentViewClock:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_coverBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.
    CGFloat goodsImgWidth = 230/2.0 * KWidth_ScaleW;
    CGFloat goodsImgHeight = 230/2.0 * KWidth_ScaleH;
//    CGFloat goodsImgGapFromLeft = 0;
//    CGFloat goodsImgGapFromTop = 22/2.0 * KWidth_ScaleH;
    _goodsImgImageView.frame = CGRectMake(0, 0, goodsImgWidth, goodsImgHeight);
    [_goodsImgImageView sd_setImageWithURL:[NSURL URLWithString:self.items.res_path] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
    //2.
    NSString *goodsNameStr = self.items.name;
    CGFloat goodsNameLabelGapFromTop = 13/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelWidth = self.frame.size.width;
    CGSize goodsNameLblWidthSize = [_goodsNameLabel sizeThatFits:CGSizeMake(goodsNameLabelWidth,MAXFLOAT)];
    _goodsNameLabel.frame = CGRectMake(18/2.0 * KWidth_ScaleW,_goodsImgImageView.bottom + goodsNameLabelGapFromTop, goodsNameLabelWidth, goodsNameLblWidthSize.height);
    _goodsNameLabel.text = goodsNameStr;
    [_goodsNameLabel sizeToFit];
    //3.月销:1000
    NSString *salesVolumeStr = [NSString stringWithFormat:@"月销:%@",self.items.sales_volume];
    CGSize salesVolumeStrSize =[salesVolumeStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KFloat(11.f)]}];
    _salesVolumeLabel.frame = CGRectMake(_goodsNameLabel.left, _goodsNameLabel.bottom + 5/2.0 * KWidth_ScaleH, salesVolumeStrSize.width, 30/2.0 * KWidth_ScaleH);
    _salesVolumeLabel.text = salesVolumeStr;
    
    //3.500.00
    NSString *goodsPriceStr = self.items.price;
    if (goodsPriceStr == nil || goodsPriceStr == Nil) {
        goodsPriceStr = @"";
    }
    CGFloat goodsPriceLabelHeight = 30/2.0 * KWidth_ScaleH;
    NSString *profitStr = [NSString stringWithFormat:@"¥%@",goodsPriceStr];
    CGSize goodsPriceLblWidthSize = [_goodsPriceLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsPriceLabelHeight)];
    _goodsPriceLabel.frame = CGRectMake(_goodsNameLabel.left, _salesVolumeLabel.bottom + 13/2.0 * KWidth_ScaleH, goodsPriceLblWidthSize.width, goodsPriceLabelHeight);
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:profitStr];
    [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, 1)];
    //    [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.f] range:NSMakeRange(1, attr2.length - 1)];
    _goodsPriceLabel.attributedText = attr2;
    [_goodsPriceLabel sizeToFit];
    //5.
    _coverBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _coverBtn.tag = self.tag;
}

#pragma mark -- 按钮事件
- (void)currentViewClock:(UIButton *)button{
    
    if (self.block) {
        self.block(button);
    }
}
@end
