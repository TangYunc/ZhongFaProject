//
//  RRPropertyEditSubview.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/12.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RRPropertyEditSubview.h"

@implementation RRPropertyEditSubview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showAuxiliaryIcon = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return self;
}

//初始化子视图
- (void)initSubviews{
    
    //名字
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _titleLabel.font = [UIFont systemFontOfSize:14.f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    //辅助视图
    _auxiliaryImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _auxiliaryImageView.clipsToBounds = YES;
    _auxiliaryImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_auxiliaryImageView];
    
    //底部的线
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self addSubview:_bottomView];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat titleLabelHeight = 40/2.0 * KWidth_ScaleH;
    CGFloat titleLabelGapFromLeft = 32/2.0 * KWidth_ScaleW;
    CGFloat titleLabelGapFromTop = (self.height - titleLabelHeight) / 2.0;
    _titleLabel.frame = CGRectMake(titleLabelGapFromLeft, titleLabelGapFromTop, 130 * KWidth_ScaleW, titleLabelHeight);
    _titleLabel.text = self.titleStr;
    
    CGFloat auxiliaryImgWidth = 16/2.0 * KWidth_ScaleW;
    CGFloat auxiliaryImgHeight = 30/2.0 * KWidth_ScaleH;
    CGFloat auxiliaryImgGapFromRight = 30/2.0 * KWidth_ScaleH;
    _auxiliaryImageView.frame = CGRectMake(0, 0, auxiliaryImgWidth, auxiliaryImgHeight);
    _auxiliaryImageView.image = [UIImage imageNamed:@"MineAuxiliaryIcon"];
    _auxiliaryImageView.centerY = _titleLabel.centerY;
    _auxiliaryImageView.right = self.frame.size.width - auxiliaryImgGapFromRight;
    
    CGFloat bottomViewHeight = 3/2.0 * KWidth_ScaleH;
    _bottomView.frame = CGRectMake(0, self.height - bottomViewHeight, self.width, bottomViewHeight);
    if (self.showAuxiliaryIcon) {
        _auxiliaryImageView.hidden = NO;
    }else{
        _auxiliaryImageView.hidden = YES;
    }
}
@end
