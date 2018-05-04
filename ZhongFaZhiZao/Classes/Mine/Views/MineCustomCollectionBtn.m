//
//  MineCustomCollectionBtn.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "MineCustomCollectionBtn.h"

@implementation MineCustomCollectionBtn

// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSString *title = @"商品收藏";
        CGSize titleStrSize =[title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KFloat(14.f)]}];
        // 创建子视图
        // 1.创建图片视图
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 14 * KWidth_ScaleH, 13, 13)];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_titleImageView];
        _titleImageView.centerX = self.frame.size.width / 2.0 - titleStrSize.width / 2.0 - 13 / 2.0;
        
        // 2.创建标题文本
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleImageView.right + 5, 14 * KWidth_ScaleH, titleStrSize.width, 13)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = TEXT_GREY_COLOR;
        _titleLabel.font = [UIFont systemFontOfSize:KFloat(14.f)];
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
