//
//  FinanceCollectionViewCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "FinanceCollectionViewCell.h"

@implementation FinanceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell{
    
    _FinanceImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    _FinanceImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_FinanceImg];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _FinanceImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _FinanceImg.image = [UIImage imageNamed:self.imageName];
}
@end
