//
//  ScienceResultCustomFounctionBtn.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/9.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ScienceResultCustomFounctionBtn.h"

@implementation ScienceResultCustomFounctionBtn

// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 创建子视图
        // 1.创建图片视图
        _titleImageView = [[UIImageView alloc] initWithFrame:frame];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_titleImageView];
        
        // 2.创建标题文本
        _titleLabel = [[UILabel alloc] initWithFrame:frame];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageViewWidth = 110/2.0 * KWidth_ScaleW;
    CGFloat imageViewGapFromTop = 26.1/2.0 * KWidth_ScaleW;
    _titleImageView.frame = CGRectMake((self.width - imageViewWidth) / 2.0, imageViewGapFromTop, imageViewWidth, imageViewWidth);
    
    CGFloat titleLabelGapFromTop = 10/2.0 * KWidth_ScaleH;
    CGFloat titleLabelHeight = 33/2.0 * KWidth_ScaleH;
    _titleLabel.frame = CGRectMake(0, _titleImageView.bottom + titleLabelGapFromTop, self.width, titleLabelHeight);
}
// 设置标题文本
- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}
// 设置标题图片
- (void)setTitleImage:(UIImage *)titleImage
{
    _titleImageView.image = titleImage;
}

@end
