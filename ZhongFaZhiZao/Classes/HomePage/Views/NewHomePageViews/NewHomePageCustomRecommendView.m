//
//  NewHomePageCustomRecommendView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/8.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "NewHomePageCustomRecommendView.h"

@implementation NewHomePageCustomRecommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    
    //1.商品名
    CGFloat goodsNameLabelGapFromTop = 27.8/2.0 * KWidth_ScaleH;
    CGFloat goodsNameLabelHeight = 37.8/2.0 * KWidth_ScaleH;
    _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, goodsNameLabelGapFromTop, self.width, goodsNameLabelHeight)];
    _goodsNameLabel.font = [UIFont boldSystemFontOfSize:26/2.f];
    _goodsNameLabel.textColor = UIColorFromRGBA(51, 51, 51, 1.0);
    _goodsNameLabel.numberOfLines = 1;
    _goodsNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_goodsNameLabel];
    _goodsNameLabel.text = @"库卡码垛机器人";
    //2.折购提示
    NSString *tipStr = @"下单立项8折";
    CGFloat tipLabelGapFromTop = 14.7/2.0 * KWidth_ScaleH;
    CGFloat tipLabelHeight = 35.6/2.0 * KWidth_ScaleH;
    _tipLabel = [[UILabel alloc] init];
    CGSize tipLblWidthSize = [_tipLabel sizeThatFits:CGSizeMake(MAXFLOAT,tipLabelHeight)];
    _tipLabel.frame = CGRectMake(0,_goodsNameLabel.bottom + tipLabelGapFromTop, tipLblWidthSize.width, tipLabelHeight);
    _tipLabel.font = [UIFont boldSystemFontOfSize:20/2.f];
    _tipLabel.textColor = UIColorFromRGBA(255, 102, 0, 1.0);
    _tipLabel.numberOfLines = 1;
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.layer.borderWidth = 0.5;
    _tipLabel.layer.borderColor = UIColorFromRGBA(255, 102, 0, 1.0).CGColor;
    _tipLabel.text = tipStr;
    [self addSubview:_tipLabel];
    [_tipLabel sizeToFit];
    _tipLabel.centerX = self.frame.size.width / 2.0;
    _tipLabel.layer.cornerRadius = _tipLabel.width / 12.0;
    //3.商品图
    CGFloat goodsIconImageViewGapFromBottom = 7/2.0 * KWidth_ScaleH;
    _goodsIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _tipLabel.bottom, self.width, self.height - _tipLabel.bottom - goodsIconImageViewGapFromBottom)];
    _goodsIconImageView.centerX = _tipLabel.centerX;
    _goodsIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsIconImageView];
    [_goodsIconImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"DefaultSmallIcon"]];
}
@end
