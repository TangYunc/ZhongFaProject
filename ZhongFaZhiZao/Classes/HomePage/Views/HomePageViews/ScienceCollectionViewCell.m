//
//  ScienceCollectionViewCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/5.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ScienceCollectionViewCell.h"

@implementation ScienceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self setUpCell];
    }
    return self;
    
}

- (void)setUpCell{
    
    _ScienceImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_ScienceImg];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _ScienceImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _ScienceImg.image = [UIImage imageNamed:self.imageName];
}
@end
