//
//  SamrtShoppingMallView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/11.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SamrtShoppingMallView.h"

@implementation SamrtShoppingMallView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    //一、
    _firstBJView = [[UIView alloc] initWithFrame:CGRectZero];
    _firstBJView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_firstBJView];
    //1.商品视图
    _firstGoodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _firstGoodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_firstBJView addSubview:_firstGoodsImgImageView];
    //2.商品名
    
    _firstGoodsNameLabel = [[UILabel alloc] init];
    _firstGoodsNameLabel.textAlignment = NSTextAlignmentRight;
    _firstGoodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _firstGoodsNameLabel.numberOfLines = 2;
    _firstGoodsNameLabel.font = [UIFont systemFontOfSize:13.f];
    [_firstBJView addSubview:_firstGoodsNameLabel];
    //3.商品价格
    _firstGoodsPriceLabel = [[UILabel alloc] init];
    _firstGoodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    _firstGoodsPriceLabel.textColor = [UIColor colorWithHexString:@"#FF6600"];
    _firstGoodsPriceLabel.font = [UIFont systemFontOfSize:14.f];
    [_firstBJView addSubview:_firstGoodsPriceLabel];
    
    //二、
    _secondBJView = [[UIView alloc] initWithFrame:CGRectZero];
    _secondBJView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_secondBJView];
    //1.商品名
    _secondGoodsNameLabel = [[UILabel alloc] init];
    _secondGoodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _secondGoodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _secondGoodsNameLabel.numberOfLines = 2;
    _secondGoodsNameLabel.font = [UIFont systemFontOfSize:13.f];
    [_secondBJView addSubview:_secondGoodsNameLabel];
    //2.商品视图
    _secondGoodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _secondGoodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_secondBJView addSubview:_secondGoodsImgImageView];
    
    //三、
    _thirdBJView = [[UIView alloc] initWithFrame:CGRectZero];
    _thirdBJView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_thirdBJView];
    //1.商品视图
    _thirdGoodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _thirdGoodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_thirdBJView addSubview:_thirdGoodsImgImageView];
    //2.商品名
    _thirdGoodsNameLabel = [[UILabel alloc] init];
    _thirdGoodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _thirdGoodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _thirdGoodsNameLabel.font = [UIFont systemFontOfSize:13.f];
    [_thirdBJView addSubview:_thirdGoodsNameLabel];
    
    //四、
    _fourBJView = [[UIView alloc] initWithFrame:CGRectZero];
    _fourBJView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_fourBJView];
    //1.商品视图
    _fourGoodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _fourGoodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_fourBJView addSubview:_fourGoodsImgImageView];
    //2.商品名
    _fourGoodsNameLabel = [[UILabel alloc] init];
    _fourGoodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _fourGoodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _fourGoodsNameLabel.font = [UIFont systemFontOfSize:13.f];
    [_fourBJView addSubview:_fourGoodsNameLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //一、
    CGFloat firstBJViewWidth = 373/2.0 * KWidth_ScaleW;
    CGFloat firstBJViewHeight = 342/2.0 * KWidth_ScaleH;
    _firstBJView.frame = CGRectMake(0, 0, firstBJViewWidth, firstBJViewHeight);
    //1.
    CGFloat goodsImgWidth = 298/2.0 * KWidth_ScaleW;
    CGFloat goodsImgHeight = 179/2.0 * KWidth_ScaleH;
    CGFloat goodsImgGapFromLeft = 44/2.0 * KWidth_ScaleW;
    CGFloat goodsImgGapFromTop = 18/2.0 * KWidth_ScaleH;
    _firstGoodsImgImageView.frame = CGRectMake(goodsImgGapFromLeft, goodsImgGapFromTop, goodsImgWidth, goodsImgHeight);
    [_firstGoodsImgImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
    //2.
    NSString *goodsNameStr = @"库卡kuka kr 300-20垛机器人垛机器";
    CGFloat goodsNameLabelGapFromTop = 6/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelWidth = goodsImgWidth;
    CGSize goodsNameLblWidthSize = [_firstGoodsNameLabel sizeThatFits:CGSizeMake(goodsNameLabelWidth,MAXFLOAT)];
    _firstGoodsNameLabel.frame = CGRectMake(_firstGoodsImgImageView.left,_firstGoodsImgImageView.bottom + goodsNameLabelGapFromTop, goodsNameLabelWidth, goodsNameLblWidthSize.height);
    _firstGoodsNameLabel.text = goodsNameStr;
    [_firstGoodsNameLabel sizeToFit];
    //3.
    NSString *goodsPriceStr = @" 3,2000.00";
    if (goodsPriceStr == nil || goodsPriceStr == Nil) {
        goodsPriceStr = @"";
    }
    CGFloat goodsPriceLabelHeight = 15 * KWidth_ScaleH;
    NSString *profitStr = [NSString stringWithFormat:@"¥%@",goodsPriceStr];
    CGSize goodsPriceLblWidthSize = [_firstGoodsPriceLabel sizeThatFits:CGSizeMake(MAXFLOAT,goodsPriceLabelHeight)];
    
    _firstGoodsPriceLabel.frame = CGRectMake(_firstGoodsNameLabel.left, _firstGoodsNameLabel.bottom, goodsPriceLblWidthSize.width, goodsPriceLabelHeight);
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:profitStr];
    [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, 1)];
    //    [attr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.f] range:NSMakeRange(1, attr2.length - 1)];
    _firstGoodsPriceLabel.attributedText = attr2;
    [_firstGoodsPriceLabel sizeToFit];
    
    
    //二、
    CGFloat secondBJViewWidth = 377/2.0 * KWidth_ScaleW;
    CGFloat secondBJViewHeight = 165/2.0 * KWidth_ScaleH;
    _secondBJView.frame = CGRectMake(_firstBJView.right + 1, 0, secondBJViewWidth, secondBJViewHeight);
    //1.
    NSString *secondGoodsNameStr = @"西门子链接总线 6ES7";
    //    CGFloat goodsNameLabelGapFromTop = 43/2.0 * KWidth_ScaleH;
    CGFloat secondGoodsNameLabelGapFromLeft = 34/2.0 * KWidth_ScaleH;
    CGFloat secondGoodsNameLabelWidth = 139/2.0 * KWidth_ScaleW;
    CGSize secondGoodsNameLblWidthSize = [_secondGoodsNameLabel sizeThatFits:CGSizeMake(secondGoodsNameLabelWidth,MAXFLOAT)];
    _secondGoodsNameLabel.frame = CGRectMake(secondGoodsNameLabelGapFromLeft,0, secondGoodsNameLabelWidth, secondGoodsNameLblWidthSize.height);
    _secondGoodsNameLabel.text = secondGoodsNameStr;
    [_secondGoodsNameLabel sizeToFit];
    _secondGoodsNameLabel.centerY = _secondBJView.frame.size.height / 2.0;
    //2.
    CGFloat secondGoodsImgWidth = 170/2.0 * KWidth_ScaleW;
    CGFloat secondGoodsImgHeight = 138/2.0 * KWidth_ScaleH;
    CGFloat secondGoodsImgGapFromRight = 16/2.0 * KWidth_ScaleW;
    _secondGoodsImgImageView.frame = CGRectMake(_secondGoodsNameLabel.right + secondGoodsImgGapFromRight, 0, secondGoodsImgWidth, secondGoodsImgHeight);
    _secondGoodsImgImageView.centerY = _secondBJView.frame.size.height / 2.0;
    [_secondGoodsImgImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
    
    
    //三、
    CGFloat thirdBJViewWidth = 188/2.0 * KWidth_ScaleW;
    CGFloat thirdBJViewHeight = 176/2.0 * KWidth_ScaleH;
    _thirdBJView.frame = CGRectMake(_secondBJView.left, _secondBJView.bottom + 1, thirdBJViewWidth, thirdBJViewHeight);
    //1.
    CGFloat thirdGoodsImgWidth = 102/2.0 * KWidth_ScaleW;
    CGFloat thirdGoodsImgHeight = 78/2.0 * KWidth_ScaleH;
    CGFloat thirdGoodsImgGapFromTop = 15/2.0 * KWidth_ScaleH;
    _thirdGoodsImgImageView.frame = CGRectMake(0, thirdGoodsImgGapFromTop, thirdGoodsImgWidth, thirdGoodsImgHeight);
    [_thirdGoodsImgImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
    _thirdGoodsImgImageView.centerX = _thirdBJView.frame.size.width / 2.0;
    //2.
    NSString *thirdGoodsNameStr = @"标准电机";
    CGFloat thirdGoodsNameLabelGapFromBottom = 22/2.0 * KWidth_ScaleH;
    CGFloat thirdGoodsNameLabelHeight = 37/2.0 * KWidth_ScaleH;
    CGSize thirdGoodsNameLblWidthSize = [_thirdGoodsNameLabel sizeThatFits:CGSizeMake(MAXFLOAT,thirdGoodsNameLabelHeight)];
    _thirdGoodsNameLabel.frame = CGRectMake(0,0, thirdGoodsNameLblWidthSize.width, thirdGoodsNameLabelHeight);
    _thirdGoodsNameLabel.text = thirdGoodsNameStr;
    [_thirdGoodsNameLabel sizeToFit];
    _thirdGoodsNameLabel.bottom = _thirdBJView.frame.size.height - thirdGoodsNameLabelGapFromBottom;
    _thirdGoodsNameLabel.centerX = _thirdBJView.frame.size.width / 2.0;
    
    //四、
    CGFloat fourBJViewWidth = 188/2.0 * KWidth_ScaleW;
    CGFloat fourBJViewHeight = 176/2.0 * KWidth_ScaleH;
    _fourBJView.frame = CGRectMake(_thirdBJView.right + 1, _thirdBJView.top, fourBJViewWidth, fourBJViewHeight);
    //1.
    CGFloat fourGoodsImgWidth = 102/2.0 * KWidth_ScaleW;
    CGFloat fourGoodsImgHeight = 78/2.0 * KWidth_ScaleH;
    CGFloat fourGoodsImgGapFromTop = 15/2.0 * KWidth_ScaleH;
    _fourGoodsImgImageView.frame = CGRectMake(0, fourGoodsImgGapFromTop, fourGoodsImgWidth, fourGoodsImgHeight);
    [_fourGoodsImgImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
    _fourGoodsImgImageView.centerX = _fourBJView.frame.size.width / 2.0;
    //2.
    NSString *fourGoodsNameStr = @"标准电机";
    CGFloat fourGoodsNameLabelGapFromBottom = 22/2.0 * KWidth_ScaleH;
    CGFloat fourGoodsNameLabelHeight = 37/2.0 * KWidth_ScaleH;
    CGSize fourGoodsNameLblWidthSize = [_fourGoodsNameLabel sizeThatFits:CGSizeMake(MAXFLOAT,fourGoodsNameLabelHeight)];
    _fourGoodsNameLabel.frame = CGRectMake(0,0, fourGoodsNameLblWidthSize.width, fourGoodsNameLabelHeight);
    _fourGoodsNameLabel.text = fourGoodsNameStr;
    [_fourGoodsNameLabel sizeToFit];
    _fourGoodsNameLabel.bottom = _fourBJView.frame.size.height - fourGoodsNameLabelGapFromBottom;
    _fourGoodsNameLabel.centerX = _fourBJView.frame.size.width / 2.0;
}

@end
