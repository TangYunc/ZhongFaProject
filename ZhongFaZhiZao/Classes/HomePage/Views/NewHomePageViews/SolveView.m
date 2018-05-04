//
//  SolveView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/10.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SolveView.h"

@implementation SolveView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    //1.公司背景视图
    _companyBJView = [[UIView alloc] initWithFrame:CGRectZero];
//    _companyBJView.backgroundColor = UIColorFromRGBA(250, 59, 37, 1.0);
    [self addSubview:_companyBJView];
    //2.公司logo
    _companyLogoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _companyLogoImageView.backgroundColor = [UIColor clearColor];
    _companyLogoImageView.layer.masksToBounds = YES;
    _companyLogoImageView.layer.borderWidth = 1.0f;
    _companyLogoImageView.layer.borderColor = [UIColor clearColor].CGColor;
    [self addSubview:_companyLogoImageView];
    //3.公司名字
    _companyNameLabel = [[UILabel alloc] init];
    _companyNameLabel.textAlignment = NSTextAlignmentLeft;
    _companyNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _companyNameLabel.font = [UIFont boldSystemFontOfSize:12.f];
    [self addSubview:_companyNameLabel];
    //4.公司简介
    _companyInfoLabel = [[UILabel alloc] init];
    _companyInfoLabel.textAlignment = NSTextAlignmentLeft;
    _companyInfoLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _companyInfoLabel.font = [UIFont systemFontOfSize:10.f];
    [self addSubview:_companyInfoLabel];
    
    //5.公司解决方案背景视图
    _solutionBJView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_solutionBJView];
    //6.分割线
    _gapLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _gapLineView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [self addSubview:_gapLineView];
}

- (void)setSolveDatas:(NewHomePageSolveDatas *)solveDatas{
    
    if (_solveDatas != solveDatas) {
        _solveDatas = solveDatas;
        //1.公司背景视图
        CGFloat companyBJViewHeight = 123/2.0 * KWidth_ScaleH;
        _companyBJView.frame = CGRectMake(0, 0, self.frame.size.width, companyBJViewHeight);
        [self viewColorChangeFromCoror:UIColorFromRGBA(49, 22, 181, 0.6754) toColor:UIColorFromRGBA(160, 21, 63, 0.6754) withTheView:_companyBJView];
        //2.公司logo
        CGFloat companyLogoImageWidth = 87/2.0 * KWidth_ScaleH;
        CGFloat companyLogoImageGapFromLeft = 19/2.0 * KWidth_ScaleH;
        _companyLogoImageView.frame = CGRectMake(companyLogoImageGapFromLeft, 0, companyLogoImageWidth, companyLogoImageWidth);
        _companyLogoImageView.centerY = _companyBJView.height / 2.0;
        _companyLogoImageView.layer.cornerRadius = companyLogoImageWidth / 2.0f;
        [_companyLogoImageView sd_setImageWithURL:[NSURL URLWithString:_solveDatas.logo_url] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
        //3.公司名字
        NSString *companyNameStr = _solveDatas.name;
        CGFloat companyNameLabelGapFromTop = 33/2.0 * KWidth_ScaleH;
        CGFloat companyNameLabelGapFromLeft = 25/2.0 * KWidth_ScaleH;
        CGFloat companyNameLabelHeight = 33/2.0 * KWidth_ScaleH;
        CGSize companyNameLblWidthSize = [_companyNameLabel sizeThatFits:CGSizeMake(MAXFLOAT,companyNameLabelHeight)];
        _companyNameLabel.frame = CGRectMake(_companyLogoImageView.right + companyNameLabelGapFromLeft,companyNameLabelGapFromTop, companyNameLblWidthSize.width, companyNameLabelHeight);
        _companyNameLabel.text = companyNameStr;
        [_companyNameLabel sizeToFit];
        //4.公司简介
        NSString *companyInfoStr = _solveDatas.solveDatasDescription;
        CGFloat companyInfoLabelHeight = 28/2.0 * KWidth_ScaleH;
        CGSize companyInfoLblWidthSize = [_companyInfoLabel sizeThatFits:CGSizeMake(MAXFLOAT,companyInfoLabelHeight)];
        _companyInfoLabel.frame = CGRectMake(_companyNameLabel.left,_companyNameLabel.bottom, companyInfoLblWidthSize.width, companyInfoLabelHeight);
        _companyInfoLabel.text = companyInfoStr;
        [_companyInfoLabel sizeToFit];
        
        //5.公司解决方案背景视图
        CGFloat solutionBJViewWidth = self.frame.size.width;
        CGFloat solutionBJViewHeight = self.frame.size.height - _companyBJView.height;
        _solutionBJView.frame = CGRectMake(0, _companyBJView.bottom, solutionBJViewWidth, solutionBJViewHeight);
        
        //公司解决方案
        NSInteger tempCount = self.solveDatas.solution_data.count;
        CGFloat solveFirstLabelGapFromTop = 26/2.0 * KWidth_ScaleH;
        CGFloat solveFirstLabelGapFromLeft = 23/2.0 * KWidth_ScaleH;
        CGFloat solveFirstLabelHeight = 37/2.0 * KWidth_ScaleH;
        for (NSInteger i = 0; i < tempCount; i++) {
            NewHomePageSolution_data *theSolutin = _solveDatas.solution_data[i];
            NSString *solveFirstStr = theSolutin.name;
            CGSize solveFirstSize =[solveFirstStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]}];
            UILabel *solveFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(solveFirstLabelGapFromLeft, solveFirstLabelGapFromTop + i * (solveFirstLabelHeight + 92/2.0 * KWidth_ScaleH), solveFirstSize.width, solveFirstLabelHeight)];
            solveFirstLabel.textAlignment = NSTextAlignmentLeft;
            solveFirstLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            solveFirstLabel.font = [UIFont systemFontOfSize:14.f];
            solveFirstLabel.text = solveFirstStr;
            [_solutionBJView addSubview:solveFirstLabel];
            //6.公司解决方案一价格
            NSString *solvePriceStr = theSolutin.price;
            if (solvePriceStr == nil || solvePriceStr == Nil) {
                solvePriceStr = @"";
            }
            NSString *solvePriceProfitStr = [NSString stringWithFormat:@"¥%@",solvePriceStr];
            CGSize solvePriceSize =[solvePriceProfitStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]}];
            UILabel *solvePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(solveFirstLabel.left, 71/2.0 * KWidth_ScaleH + i * (solveFirstLabelHeight + 97/2.0 * KWidth_ScaleH), solvePriceSize.width, solveFirstLabelHeight)];
            solvePriceLabel.tag = 100 + i;
            solvePriceLabel.textAlignment = NSTextAlignmentLeft;
            solvePriceLabel.textColor = [UIColor colorWithHexString:@"#FF6600"];
            solvePriceLabel.font = [UIFont systemFontOfSize:14.f];
            solvePriceLabel.text = solvePriceProfitStr;
            [_solutionBJView addSubview:solvePriceLabel];
            
            UIButton *solveCoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            solveCoverBtn.frame = CGRectMake(0, i * _solutionBJView.height / 2.0, _solutionBJView.width, _solutionBJView.height / 2.0);
            solveCoverBtn.tag = 500 + i;
            [solveCoverBtn addTarget:self action:@selector(solveCoverClick:) forControlEvents:UIControlEventTouchUpInside
             ];
            [_solutionBJView addSubview:solveCoverBtn];
        }
        UILabel *solvePriceLabel1 = (UILabel *)[_solutionBJView viewWithTag:100];
        //7.分割线
        CGFloat gapLineGapFromTop = 25/2.0 * KWidth_ScaleH;
        _gapLineView.frame = CGRectMake(0, solvePriceLabel1.bottom + gapLineGapFromTop, self.frame.size.width, 0.5);
        if (self.solveDatas.solution_data.count == 2) {
            _gapLineView.hidden = NO;
        }else{
            _gapLineView.hidden = YES;
        }
    }
}

#pragma mark -- 按钮事件
- (void)solveCoverClick:(UIButton *)button{
    
    NewHomePageSolution_data *solutionData = self.solveDatas.solution_data[button.tag - 500];
    NSString *url = [NSString stringWithFormat:@"http://wap.cecb2b.com/corp/nicInfo/%@?corpId=%@",solutionData.solutionDataId,self.solveDatas.uid];
    [self pushToWKWebViewCtrlUrl:url withTitle:solutionData.name];
}


#pragma mark -- method

- (void)pushToWKWebViewCtrlUrl:(NSString *)urlStr withTitle:(NSString *)title{
    
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]initWithUrlStr:urlStr title:title];
    [self.viewControler.navigationController pushViewController:vc animated:YES];
}


- (void)viewColorChangeFromCoror:(UIColor *)fromColor toColor:(UIColor *)toColor withTheView:(UIView *)view{
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）,startPoint&endPoint    颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，如(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.6, 0);
    
    //设置颜色数组,colors渐变的颜色
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,
                             (__bridge id)toColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.0f)];
}

@end
