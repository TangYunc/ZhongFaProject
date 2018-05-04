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
    _firstGoodsImgImageView.userInteractionEnabled = YES;
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
    _secondGoodsImgImageView.userInteractionEnabled = YES;
    
    //三、
    _thirdBJView = [[UIView alloc] initWithFrame:CGRectZero];
    _thirdBJView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_thirdBJView];
    //1.商品视图
    _thirdGoodsImgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _thirdGoodsImgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_thirdBJView addSubview:_thirdGoodsImgImageView];
    _thirdBJView.userInteractionEnabled = YES;
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
    _fourBJView.userInteractionEnabled = YES;
    //2.商品名
    _fourGoodsNameLabel = [[UILabel alloc] init];
    _fourGoodsNameLabel.textAlignment = NSTextAlignmentLeft;
    _fourGoodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _fourGoodsNameLabel.font = [UIFont systemFontOfSize:13.f];
    [_fourBJView addSubview:_fourGoodsNameLabel];
}

- (void)setTheDatas:(NewHomePageSmartShoppingMallDatas *)theDatas{
    if (_theDatas != theDatas) {
        _theDatas = theDatas;
        
        NSArray *lists = _theDatas.ad_list;
        NewHomePageSmartShoppingMallAd_list *adList1;
        NewHomePageSmartShoppingMallAd_list *adList2;
        NewHomePageSmartShoppingMallAd_list *adList3;
        NewHomePageSmartShoppingMallAd_list *adList4;
        if (lists.count == 0) {
            adList1 = nil;
            adList2 = nil;
            adList3 = nil;
            adList4 = nil;
        }
        if (lists.count == 1) {
            adList1 = lists[0];
            adList2 = nil;
            adList3 = nil;
            adList4 = nil;
        }else if (lists.count == 2){
            adList1 = lists[0];
            adList2 = lists[1];
            adList3 = nil;
            adList4 = nil;
        }else if (lists.count == 3){
            adList1 = lists[0];
            adList2 = lists[1];
            adList3 = lists[2];
            adList4 = nil;
        }else if (lists.count == 4){
            adList1 = lists[0];
            adList2 = lists[1];
            adList3 = lists[2];
            adList4 = lists[3];
        }
        //一、
        CGFloat firstBJViewWidth = 373/2.0 * KWidth_ScaleW;
        CGFloat firstBJViewHeight = 342/2.0 * KWidth_ScaleH;
        _firstBJView.frame = CGRectMake(0, 0, firstBJViewWidth, firstBJViewHeight);
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_firstBJView addGestureRecognizer:tap1];
        //1.
        CGFloat goodsImgWidth = 298/2.0 * KWidth_ScaleW;
        CGFloat goodsImgHeight = 179/2.0 * KWidth_ScaleH;
        CGFloat goodsImgGapFromLeft = 44/2.0 * KWidth_ScaleW;
        CGFloat goodsImgGapFromTop = 18/2.0 * KWidth_ScaleH;
        _firstGoodsImgImageView.frame = CGRectMake(goodsImgGapFromLeft, goodsImgGapFromTop, goodsImgWidth, goodsImgHeight);
        [_firstGoodsImgImageView sd_setImageWithURL:[NSURL URLWithString:adList1.res_path] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
        
        //2.
        NSString *goodsNameStr = adList1.name;
        CGFloat goodsNameLabelGapFromTop = 6/2.0 * KWidth_ScaleH;
        CGFloat goodsNameLabelWidth = goodsImgWidth;
        CGSize goodsNameLblWidthSize = [_firstGoodsNameLabel sizeThatFits:CGSizeMake(goodsNameLabelWidth,MAXFLOAT)];
        _firstGoodsNameLabel.frame = CGRectMake(_firstGoodsImgImageView.left,_firstGoodsImgImageView.bottom + goodsNameLabelGapFromTop, goodsNameLabelWidth, goodsNameLblWidthSize.height);
        _firstGoodsNameLabel.text = goodsNameStr;
        [_firstGoodsNameLabel sizeToFit];
        //3.
        NSString *goodsPriceStr = adList1.price;
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
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_secondBJView addGestureRecognizer:tap2];
        //1.
        NSString *secondGoodsNameStr = adList2.name;
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
        [_secondGoodsImgImageView sd_setImageWithURL:[NSURL URLWithString:adList2.res_path] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
        
        
        //三、
        CGFloat thirdBJViewWidth = 188/2.0 * KWidth_ScaleW;
        CGFloat thirdBJViewHeight = 176/2.0 * KWidth_ScaleH;
        _thirdBJView.frame = CGRectMake(_secondBJView.left, _secondBJView.bottom + 1, thirdBJViewWidth, thirdBJViewHeight);
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_thirdBJView addGestureRecognizer:tap3];
        //1.
        CGFloat thirdGoodsImgWidth = 102/2.0 * KWidth_ScaleW;
        CGFloat thirdGoodsImgHeight = 78/2.0 * KWidth_ScaleH;
        CGFloat thirdGoodsImgGapFromTop = 15/2.0 * KWidth_ScaleH;
        _thirdGoodsImgImageView.frame = CGRectMake(0, thirdGoodsImgGapFromTop, thirdGoodsImgWidth, thirdGoodsImgHeight);
        [_thirdGoodsImgImageView sd_setImageWithURL:[NSURL URLWithString:adList3.res_path] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
        _thirdGoodsImgImageView.centerX = _thirdBJView.frame.size.width / 2.0;
        //2.
        NSString *thirdGoodsNameStr = adList3.name;
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
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_fourBJView addGestureRecognizer:tap4];
        //1.
        CGFloat fourGoodsImgWidth = 102/2.0 * KWidth_ScaleW;
        CGFloat fourGoodsImgHeight = 78/2.0 * KWidth_ScaleH;
        CGFloat fourGoodsImgGapFromTop = 15/2.0 * KWidth_ScaleH;
        _fourGoodsImgImageView.frame = CGRectMake(0, fourGoodsImgGapFromTop, fourGoodsImgWidth, fourGoodsImgHeight);
        [_fourGoodsImgImageView sd_setImageWithURL:[NSURL URLWithString:adList4.res_path] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
        _fourGoodsImgImageView.centerX = _fourBJView.frame.size.width / 2.0;
        //2.
        NSString *fourGoodsNameStr = adList4.name;
        CGFloat fourGoodsNameLabelGapFromBottom = 22/2.0 * KWidth_ScaleH;
        CGFloat fourGoodsNameLabelHeight = 37/2.0 * KWidth_ScaleH;
        CGSize fourGoodsNameLblWidthSize = [_fourGoodsNameLabel sizeThatFits:CGSizeMake(MAXFLOAT,fourGoodsNameLabelHeight)];
        _fourGoodsNameLabel.frame = CGRectMake(0,0, fourGoodsNameLblWidthSize.width, fourGoodsNameLabelHeight);
        _fourGoodsNameLabel.text = fourGoodsNameStr;
        [_fourGoodsNameLabel sizeToFit];
        _fourGoodsNameLabel.bottom = _fourBJView.frame.size.height - fourGoodsNameLabelGapFromBottom;
        _fourGoodsNameLabel.centerX = _fourBJView.frame.size.width / 2.0;
    }
}

#pragma mark -- 手势
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    NSString *url;
    NSString *title = @"商品详情";
    
    NSArray *lists = _theDatas.ad_list;
    NewHomePageSmartShoppingMallAd_list *adList1;
    NewHomePageSmartShoppingMallAd_list *adList2;
    NewHomePageSmartShoppingMallAd_list *adList3;
    NewHomePageSmartShoppingMallAd_list *adList4;
    if (lists.count == 0) {
        adList1 = nil;
        adList2 = nil;
        adList3 = nil;
        adList4 = nil;
    }
    if (lists.count == 1) {
        adList1 = lists[0];
        adList2 = nil;
        adList3 = nil;
        adList4 = nil;
    }else if (lists.count == 2){
        adList1 = lists[0];
        adList2 = lists[1];
        adList3 = nil;
        adList4 = nil;
    }else if (lists.count == 3){
        adList1 = lists[0];
        adList2 = lists[1];
        adList3 = lists[2];
        adList4 = nil;
    }else if (lists.count == 4){
        adList1 = lists[0];
        adList2 = lists[1];
        adList3 = lists[2];
        adList4 = lists[3];
    }
    
    if (tap.view == _firstBJView) {
        url = adList1.click_link;
    }else if (tap.view == _secondBJView){
        url = adList2.click_link;
    }else if (tap.view == _thirdBJView){
        url = adList3.click_link;
    }else if (tap.view == _fourBJView){
        url = adList4.click_link;
    }
    [self pushWkWebViewWithAPIString:url withTitle:title];
    NSLog(@"点击的是智造商城视图");
}

#pragma mark -- 方法
- (void)pushWkWebViewWithAPIString:(NSString *)apiString withTitle:(NSString *)title{
    
    WKWebViewViewController *wkvc = [[WKWebViewViewController alloc]initWithUrlStr:apiString title:title];
    //        wkvc.hidesBottomBarWhenPushed = YES;
    [self.viewControler.navigationController pushViewController:wkvc animated:YES];
}
@end
