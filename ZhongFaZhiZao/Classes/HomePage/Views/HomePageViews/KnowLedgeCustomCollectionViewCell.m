//
//  KnowLedgeCustomCollectionViewCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "KnowLedgeCustomCollectionViewCell.h"

@implementation KnowLedgeCustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell{
    
    _iconImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_iconImg];
    
    _textLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _textLbl.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:_textLbl];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _iconImg.frame = CGRectMake(45*KWidth_ScaleW, (self.contentView.frame.size.height-26)/2.0, 26, 26);
    _iconImg.image = [UIImage imageNamed:self.imageName];
    
    _textLbl.frame = CGRectMake(12*KWidth_ScaleW+CGRectGetMaxX(_iconImg.frame), (self.contentView.frame.size.height-16)/2.0, 80, 16);
    _textLbl.text = self.text;
}
@end
