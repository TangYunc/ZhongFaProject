//
//  MineOrderCustomBtn.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/2.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MineOrderCustomBtn.h"

@implementation MineOrderCustomBtn

// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 创建子视图
        // 1.创建图片视图
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 28) / 2.0, 16 * KWidth_ScaleH, 28, 28)];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_titleImageView];
        
        // 2.创建标题文本
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleImageView.bottom + 8, self.width, 17)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColorFromRGBA(51, 51, 51, 1.0);
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:_titleLabel];
        
    }
    return self;
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
