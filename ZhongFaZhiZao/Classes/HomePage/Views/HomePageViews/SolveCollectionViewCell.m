//
//  SolveCollectionViewCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SolveCollectionViewCell.h"

@implementation SolveCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell{
    
    _SolveImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_SolveImg];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _SolveImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _SolveImg.image = [UIImage imageNamed:self.imageName];
}

@end
