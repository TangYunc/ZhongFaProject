//
//  NewHomePageCustomRecommendGapView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/9.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "NewHomePageCustomRecommendGapView.h"

@implementation NewHomePageCustomRecommendGapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    
    CGFloat gapLineWidth = 28/2.0 * KWidth_ScaleW;
    CGFloat gapLineHeight = 4/2.0 * KWidth_ScaleH;
    UIColor *gapLineColor = [UIColor colorWithHexString:@"#FFFFFF"];
    CGFloat gapLineGapFromTop = (self.height - gapLineHeight) / 2.0;
    CGFloat gapLineGapWithOther = 17.5/2.0 * KWidth_ScaleW;
    //间隔横线1
    UIView *recommendLineFirst = [[UIView alloc] initWithFrame:CGRectMake(0, gapLineGapFromTop, gapLineWidth, gapLineHeight)];
    recommendLineFirst.backgroundColor = gapLineColor;
    [self addSubview:recommendLineFirst];
    //为您推荐
    UILabel *recommendLbl = [[UILabel alloc] init];
    CGSize recommendLblWidthSize = [recommendLbl sizeThatFits:CGSizeMake(MAXFLOAT,self.height)];
    recommendLbl.frame = CGRectMake(recommendLineFirst.right + gapLineGapWithOther,3, recommendLblWidthSize.width, self.height);
    recommendLbl.text = @"为您推荐";
    recommendLbl.textAlignment = NSTextAlignmentCenter;
    recommendLbl.textColor = gapLineColor;
    recommendLbl.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:recommendLbl];
    [recommendLbl sizeToFit];
    //间隔横线2
    UIView *recommendLineSecond = [[UIView alloc] initWithFrame:CGRectMake(recommendLbl.right + gapLineGapWithOther, recommendLineFirst.top, gapLineWidth, gapLineHeight)];
    recommendLineSecond.backgroundColor = gapLineColor;
    [self addSubview:recommendLineSecond];
}

@end
