//
//  NewHomePageCollectionSectionHeaderView.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/9.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "NewHomePageCollectionSectionHeaderView.h"

@implementation NewHomePageCollectionSectionHeaderView

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
    
    //1.展位线
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#31B3EF"];
    [self addSubview:_lineView];
    //2.展位标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _titleLabel.font = [UIFont systemFontOfSize:16.f];
    [self addSubview:_titleLabel];
    //3.展位子标题
    _subtitleLabel = [[UILabel alloc] init];
    _subtitleLabel.textAlignment = NSTextAlignmentLeft;
    _subtitleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _subtitleLabel.font = [UIFont systemFontOfSize:12.f];
    [self addSubview:_subtitleLabel];
    _subtitleLabel.hidden = YES;
    //4.辅助视图
    _auxiliaryView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _auxiliaryView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_auxiliaryView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat gapWidth = 18/2.0 * KWidth_ScaleW;
    //1.
    CGFloat lineViewGapFromLeft = (11 + 18)/2.0 * KWidth_ScaleW;
    CGFloat lineViewWidth = 3 * KWidth_ScaleW;
    CGFloat lineViewHeight = 45/2.0 * KWidth_ScaleH;
    CGFloat lineViewGapFromTop = (self.frame.size.height - lineViewHeight) / 2.0;
    _lineView.frame = CGRectMake(lineViewGapFromLeft, lineViewGapFromTop, lineViewWidth, lineViewHeight);
    //2.
    CGFloat titleLabelHeight = lineViewHeight;
    CGSize titleLblWidthSize = [_titleLabel sizeThatFits:CGSizeMake(MAXFLOAT,titleLabelHeight)];
    _titleLabel.frame = CGRectMake(_lineView.right + gapWidth,0, titleLblWidthSize.width, titleLabelHeight);
    _titleLabel.text = @"智造商城";
    [_titleLabel sizeToFit];
    _titleLabel.centerY = self.frame.size.height / 2.0;
    //3.
    CGFloat subtitleLabelGapFromLeft = 15/2.0 * KWidth_ScaleW;
    CGSize subtitleLblWidthSize = [_titleLabel sizeThatFits:CGSizeMake(MAXFLOAT,titleLabelHeight)];
    _subtitleLabel.frame = CGRectMake(_titleLabel.right + subtitleLabelGapFromLeft,0, subtitleLblWidthSize.width, titleLabelHeight);
    _subtitleLabel.text = @"聚全球最优科技资源";
    [_subtitleLabel sizeToFit];
    _subtitleLabel.centerY = self.frame.size.height / 2.0;
    //4.
    CGFloat auxiliaryViewWidth = 69/2.0 * KWidth_ScaleW;
    _auxiliaryView.frame = CGRectMake(0, 0, auxiliaryViewWidth, auxiliaryViewWidth);
    _auxiliaryView.right = kScreenWidth - 36/2.0 * KWidth_ScaleW;
    _auxiliaryView.image = [UIImage imageNamed:@"NewHomePageAuxiliaryIcon"];
    _auxiliaryView.centerY = self.frame.size.height / 2.0;
    
    NSString *title;
    NSString *subtitle;
    if ([self.sectionType isEqualToString:@"SamrtShoppingMall"]) {
        title = @"智造商城";
        subtitle = @"";
        _subtitleLabel.hidden = YES;
    }else if ([self.sectionType isEqualToString:@"ScienceResult"]){
        title = @"科技成果";
        subtitle = @"聚全球最优科技资源";
        _subtitleLabel.hidden = NO;
    }else if ([self.sectionType isEqualToString:@"Solve"]){
        title = @"解决方案";
        subtitle = @"数字化向智能化升级";
        _subtitleLabel.hidden = NO;
    }else if ([self.sectionType isEqualToString:@"Electronic"]){
        title = @"电子市场";
        subtitle = @"";
        _subtitleLabel.hidden = YES;
        _auxiliaryView.hidden = YES;
    }else if ([self.sectionType isEqualToString:@"SSMBannerModelCell"]){
        title = self.title;
        subtitle = @"";
        _subtitleLabel.hidden = YES;
        _auxiliaryView.hidden = YES;
    }
    _titleLabel.text = title;
    _subtitleLabel.text = @"聚全球最优科技资源";
}
@end
