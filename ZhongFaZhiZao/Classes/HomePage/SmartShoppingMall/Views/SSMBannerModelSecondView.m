//
//  SSMBannerModelSecondView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/19.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMBannerModelSecondView.h"

@implementation SSMBannerModelSecondView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubview];
    }
    return self;
}

- (void)setUpSubview{
    //1.商品背景视图
    _bjImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bjImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_bjImageView];
    //2.商品名
    _goodsNameLabel = [[UILabel alloc] init];
    _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _goodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _goodsNameLabel.numberOfLines = 2;
    _goodsNameLabel.font = [UIFont systemFontOfSize:KFloat(12.f)];
    [_bjImageView addSubview:_goodsNameLabel];
    //3.商品价格
    _goodsPriceLabel = [[UILabel alloc] init];
    _goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    _goodsPriceLabel.textColor = [UIColor colorWithHexString:@"#FF6600"];
    _goodsPriceLabel.font = [UIFont systemFontOfSize:KFloat(14.f)];
    [_bjImageView addSubview:_goodsPriceLabel];
    //4.商品视图
    _goodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _goodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_bjImageView addSubview:_goodsImgImageView];
    
    //5.购买
    _purchaseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _purchaseLabel.textAlignment = NSTextAlignmentLeft;
    _purchaseLabel.textColor = [UIColor whiteColor];
    _purchaseLabel.font = [UIFont systemFontOfSize:KFloat(12.f)];
    [_bjImageView addSubview:_purchaseLabel];
    //6.
    _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_coverBtn setBackgroundColor:[UIColor clearColor]];
    [_coverBtn addTarget:self action:@selector(purchaseClock:) forControlEvents:UIControlEventTouchUpInside];
    [_bjImageView addSubview:_coverBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.
    _bjImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _bjImageView.image = [UIImage imageNamed:self.itemBJImageName];
    
    //2.施耐德ZA28-12.53 3123底轮二轴
    NSString *goodsNameStr = self.items.name;
    CGFloat goodsNameLabelGapFromTop = 20/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelWidth = self.frame.size.width - 110/2.0 * KWidth_ScaleW - 10/2.0 * KWidth_ScaleW * 2;
    CGSize goodsNameStrSize =[goodsNameStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KFloat(12.f)]}];
    _goodsNameLabel.frame = CGRectMake(10/2.0 * KWidth_ScaleW,_goodsImgImageView.bottom + goodsNameLabelGapFromTop, goodsNameLabelWidth, goodsNameStrSize.height);
    _goodsNameLabel.text = goodsNameStr;

    
    //3.500.00
    NSString *goodsPriceStr = self.items.price;
    if (goodsPriceStr == nil || goodsPriceStr == Nil) {
        goodsPriceStr = @"";
    }
    CGFloat goodsPriceLabelHeight = 30/2.0 * KWidth_ScaleH;
    NSString *profitStr = [NSString stringWithFormat:@"¥%@",goodsPriceStr];
    CGSize goodsPriceLblWidthSize = [_goodsPriceLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsPriceLabelHeight)];
    _goodsPriceLabel.frame = CGRectMake(_goodsNameLabel.left, _goodsNameLabel.bottom + 10/2.0 * KWidth_ScaleH, goodsPriceLblWidthSize.width, goodsPriceLabelHeight);
//    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:profitStr];
//    [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, 1)];
    //    [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.f] range:NSMakeRange(1, attr2.length - 1)];
    _goodsPriceLabel.text = profitStr;
    [_goodsPriceLabel sizeToFit];
    
    CGFloat goodsImgWidth = 110/2.0 * KWidth_ScaleW;
    CGFloat goodsImgHeight = 110/2.0 * KWidth_ScaleH;
    CGFloat goodsImgGapFromLeft = self.frame.size.width - goodsImgWidth - 10/2.0 * KWidth_ScaleW;
    CGFloat goodsImgGapFromTop = 20/2.0 * KWidth_ScaleH;
    _goodsImgImageView.frame = CGRectMake(goodsImgGapFromLeft, goodsImgGapFromTop, goodsImgWidth, goodsImgHeight);
    [_goodsImgImageView sd_setImageWithURL:[NSURL URLWithString:self.items.res_path] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
    
    //5.
    NSString *purchaseStr = @"立即购买";
   CGSize purchaseStrSize =[purchaseStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KFloat(12.f)]}];
    CGFloat purchaseLabelGapFromBottom = 10/2.0 * KWidth_ScaleH;
    CGFloat purchaseLabelHeight = 30/2.0 * KWidth_ScaleH;
    _purchaseLabel.frame = CGRectMake(0,0, purchaseStrSize.width, purchaseLabelHeight);
    _purchaseLabel.text = purchaseStr;
    _purchaseLabel.bottom = self.frame.size.height - purchaseLabelGapFromBottom;
    _purchaseLabel.centerX = self.frame.size.width / 2.0;
    //6.
    _coverBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _coverBtn.tag = self.tag;
}

#pragma mark -- 按钮事件
- (void)purchaseClock:(UIButton *)button{
    
}
@end
