//
//  SolveCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SolveCell.h"

@implementation SolveCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell{
    UIView *_gapLineView;
    //1.公司背景视图
    _companyBJView = [[UIView alloc] initWithFrame:CGRectZero];
    _companyBJView.backgroundColor = UIColorFromRGBA(250, 59, 37, 1.0);
    [self.contentView addSubview:_companyBJView];
    //2.公司logo
    _companyLogoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _companyLogoImageView.backgroundColor = [UIColor clearColor];
    _companyLogoImageView.layer.masksToBounds = YES;
    _companyLogoImageView.layer.borderWidth = 1.0f;
    _companyLogoImageView.layer.borderColor = [UIColor clearColor].CGColor;
    [_companyBJView addSubview:_companyLogoImageView];
    //3.公司名字
    _companyNameLabel = [[UILabel alloc] init];
    _companyNameLabel.textAlignment = NSTextAlignmentLeft;
    _companyNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _companyNameLabel.font = [UIFont systemFontOfSize:12.f];
    [_companyBJView addSubview:_companyNameLabel];
    //4.公司简介
    _companyInfoLabel = [[UILabel alloc] init];
    _companyInfoLabel.textAlignment = NSTextAlignmentLeft;
    _companyInfoLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _companyInfoLabel.font = [UIFont systemFontOfSize:10.f];
    [_companyBJView addSubview:_companyInfoLabel];
    //5.公司解决方案一
    _solveFirstLabel = [[UILabel alloc] init];
    _solveFirstLabel.textAlignment = NSTextAlignmentLeft;
    _solveFirstLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _solveFirstLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_solveFirstLabel];
    //6.公司解决方案一价格
    _solvePriceFirstLabel = [[UILabel alloc] init];
    _solvePriceFirstLabel.textAlignment = NSTextAlignmentLeft;
    _solvePriceFirstLabel.textColor = [UIColor colorWithHexString:@"#FF6600"];
    _solvePriceFirstLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_solvePriceFirstLabel];
    //7.分割线
    _gapLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _gapLineView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [self.contentView addSubview:_gapLineView];
    //8.公司解决方案二
    _solveSecondLabel = [[UILabel alloc] init];
    _solveSecondLabel.textAlignment = NSTextAlignmentLeft;
    _solveSecondLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _solveSecondLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_solveSecondLabel];
    //9.公司解决方案二价格
    _solvePriceSecondLabel = [[UILabel alloc] init];
    _solvePriceSecondLabel.textAlignment = NSTextAlignmentLeft;
    _solvePriceSecondLabel.textColor = [UIColor colorWithHexString:@"#FF6600"];
    _solvePriceSecondLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_solvePriceSecondLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.公司背景视图
    CGFloat companyBJViewHeight = 123/2.0 * KWidth_ScaleH;
    _companyBJView.frame = CGRectMake(0, 0, self.frame.size.width, companyBJViewHeight);
    [self viewColorChangeFromCoror:[UIColor colorWithHexString:@"#3116B5"] toColor:[UIColor colorWithHexString:@"##A0153F"] withTheView:_companyBJView];
    //2.公司logo
    CGFloat companyLogoImageWidth = 87/2.0 * KWidth_ScaleH;
    CGFloat companyLogoImageGapFromLeft = 19/2.0 * KWidth_ScaleH;
    _companyLogoImageView.frame = CGRectMake(companyLogoImageGapFromLeft, 0, companyLogoImageWidth, companyLogoImageWidth);
    _companyLogoImageView.centerY = _companyBJView.height / 2.0;
    _companyLogoImageView.layer.cornerRadius = (64 * KWidth_ScaleW)/2.0f;
    //3.公司名字
    NSString *companyNameStr = @"盘古科技有限公司";
    CGFloat companyNameLabelGapFromTop = 33/2.0 * KWidth_ScaleH;
    CGFloat companyNameLabelGapFromLeft = 25/2.0 * KWidth_ScaleH;
    CGFloat companyNameLabelHeight = 33/2.0 * KWidth_ScaleH;
    CGSize companyNameLblWidthSize = [_companyNameLabel sizeThatFits:CGSizeMake(MAXFLOAT,companyNameLabelHeight)];
    _companyNameLabel.frame = CGRectMake(_companyLogoImageView.right + companyNameLabelGapFromLeft,companyNameLabelGapFromTop, companyNameLblWidthSize.width, companyNameLabelHeight);
    _companyNameLabel.text = companyNameStr;
    [_companyNameLabel sizeToFit];
    //4.公司简介
    NSString *companyInfoStr = @"一站式服务，助您变身4.0智能厂";
    CGFloat companyInfoLabelHeight = 28/2.0 * KWidth_ScaleH;
    CGSize companyInfoLblWidthSize = [_companyInfoLabel sizeThatFits:CGSizeMake(MAXFLOAT,companyInfoLabelHeight)];
    _companyInfoLabel.frame = CGRectMake(_companyNameLabel.left,_companyNameLabel.bottom, companyInfoLblWidthSize.width, companyInfoLabelHeight);
    _companyInfoLabel.text = companyInfoStr;
    [_companyInfoLabel sizeToFit];
    //5.公司解决方案一
    NSString *solveFirstStr = @"AOI集控与智能物流解决方案一";
    CGFloat solveFirstLabelGapFromTop = 26/2.0 * KWidth_ScaleH;
    CGFloat solveFirstLabelGapFromLeft = 23/2.0 * KWidth_ScaleH;
    CGFloat solveFirstLabelHeight = 37/2.0 * KWidth_ScaleH;
    CGSize solveFirstLblWidthSize = [_solveFirstLabel sizeThatFits:CGSizeMake(MAXFLOAT,solveFirstLabelHeight)];
    _solveFirstLabel.frame = CGRectMake(solveFirstLabelGapFromLeft,_companyBJView.bottom + solveFirstLabelGapFromTop, solveFirstLblWidthSize.width, solveFirstLabelHeight);
    _solveFirstLabel.text = solveFirstStr;
    [_solveFirstLabel sizeToFit];
    //6.公司解决方案一价格
    NSString *solvePriceFirstStr = @"3,2000.00";
    if (solvePriceFirstStr == nil || solvePriceFirstStr == Nil) {
        solvePriceFirstStr = @"";
    }
    CGFloat solvePriceFirstLabelHeight = 40/2.0 * KWidth_ScaleH;
    NSString *solvePriceFirstProfitStr = [NSString stringWithFormat:@"¥%@",solvePriceFirstStr];
    CGSize solvePriceFirstLblWidthSize = [_solvePriceFirstLabel sizeThatFits:CGSizeMake(MAXFLOAT,solvePriceFirstLabelHeight)];
    _solvePriceFirstLabel.frame = CGRectMake(_solveFirstLabel.left, _solveFirstLabel.bottom, solvePriceFirstLblWidthSize.width, solvePriceFirstLabelHeight);
    _solvePriceFirstLabel.text = solvePriceFirstProfitStr;
    [_solvePriceFirstLabel sizeToFit];
    //7.分割线
    CGFloat gapLineGapFromTop = 25/2.0 * KWidth_ScaleH;
    _gapLineView.frame = CGRectMake(0, _solvePriceFirstLabel.bottom + gapLineGapFromTop, self.frame.size.width, 0.5);
    //8.公司解决方案二
    NSString *solveSecondStr = @"AOI集控与智能物流解决方案二";
    CGFloat solveSecondLabelGapFromTop = 26.5/2.0 * KWidth_ScaleH;
    CGFloat solveSecondLabelHeight = 37/2.0 * KWidth_ScaleH;
    CGSize solveSecondLblWidthSize = [_solveSecondLabel sizeThatFits:CGSizeMake(MAXFLOAT,solveSecondLabelHeight)];
    _solveSecondLabel.frame = CGRectMake(_solveFirstLabel.left,_gapLineView.bottom + solveSecondLabelGapFromTop, solveSecondLblWidthSize.width, solveSecondLabelHeight);
    _solveSecondLabel.text = solveSecondStr;
    [_solveSecondLabel sizeToFit];
    //9.公司解决方案二价格
    NSString *solvePriceSecondStr = @"3,2000.00";
    if (solvePriceSecondStr == nil || solvePriceSecondStr == Nil) {
        solvePriceSecondStr = @"";
    }
    CGFloat solvePriceSecondLabelHeight = 40/2.0 * KWidth_ScaleH;
    NSString *solvePriceSecondProfitStr = [NSString stringWithFormat:@"¥%@",solvePriceSecondStr];
    CGSize solvePriceSecondLblWidthSize = [_solvePriceFirstLabel sizeThatFits:CGSizeMake(MAXFLOAT,solvePriceSecondLabelHeight)];
    _solvePriceFirstLabel.frame = CGRectMake(_solveSecondLabel.left, _solveSecondLabel.bottom, solvePriceSecondLblWidthSize.width, solvePriceSecondLabelHeight);
    _solvePriceFirstLabel.text = solvePriceSecondProfitStr;
    [_solvePriceFirstLabel sizeToFit];
}

#pragma mark -- method
- (void)viewColorChangeFromCoror:(UIColor *)fromColor toColor:(UIColor *)toColor withTheView:(UIView *)view{
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 0.6);
    
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,
                             (__bridge id)toColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.0f)];
}
@end
