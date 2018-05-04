//
//  MineCustomCollectionBtn.h
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/3/1.
//  Copyright © 2018年 中发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCustomCollectionBtn : UIControl
{
    UIImageView *_titleImageView;// 图片标题
    UILabel *_titleLabel;// 标题视图
    UIView *_bottomGapView;
}
@property(nonatomic, strong)UIImageView *titleImageView;
@property(nonatomic, strong)UILabel *titleLabel;
// 设置标题文本
- (void)setTitle:(NSString *)title;
// 设置标题图片
- (void)setTitleImage:(UIImage *)titleImage;

@end
