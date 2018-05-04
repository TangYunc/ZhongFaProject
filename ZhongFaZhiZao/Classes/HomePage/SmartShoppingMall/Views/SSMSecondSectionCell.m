//
//  SSMSecondSectionCell.m
//  ZhongFaZhiZao
//
//  Created by 中发 on 2018/4/14.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "SSMSecondSectionCell.h"
#import "SSMSecondSectionView.h"

@interface SSMSecondSectionCell ()
{
    
    
}
@end

@implementation SSMSecondSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        //初始化子视图
        [self setUpSubViews];
        
    }
    return self;
}

//初始化子视图
- (void)setUpSubViews{
    //1.
//    _bjImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//    [self.contentView addSubview:_bjImgView];
//    _bjImgView.userInteractionEnabled = YES;
    
    _bjView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_bjView];
    
    
    //2.
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:KFloat(18)];
    [self.contentView addSubview:_titleLabel];
    //3.
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectZero;
    [_moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"SSMMoreIcon"] forState:UIControlStateNormal];
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:KFloat(12.f)];
    _moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    [_moreBtn addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat bjViewHeight = 561/2.0 * KWidth_ScaleH;
    _bjView.frame = CGRectMake(0, 0, kScreenWidth, bjViewHeight);
    
//    _bjView.frame = _bjImgView.frame;
    [self viewColorChangeFromCoror:[UIColor colorWithHexString:self.fromColorName] toColor:[UIColor colorWithHexString:@"#F4F4F4"] withTheView:_bjView];
//    _bjImgView.image = [self convertViewToImage:_bjView];
    
    NSString *titleStr = self.cates.cate_name;
    CGSize titleStrSize =[titleStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KFloat(18)]}];
    _titleLabel.frame = CGRectMake(0, 25/2.0 * KWidth_ScaleH, titleStrSize.width, 50/2.0 * KWidth_ScaleH);
    _titleLabel.centerX = _bjView.centerX;
    _titleLabel.text = titleStr;
    
    NSString *moreBtnStr = @"更多";
    CGSize moreBtnSize =[moreBtnStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KFloat(12.f)]}];
    _moreBtn.frame = CGRectMake(0, 0, moreBtnSize.width + 10, 33/2.0 * KWidth_ScaleH);
    _moreBtn.left = _bjView.width - (29.4 + 66)/2.0;
    _moreBtn.centerY = _titleLabel.centerY;
    
//    self.cates.items.count = 3;
    NSInteger tempCount = self.cates.items.count;
    
    CGFloat sectionViewWidth = 230/2.0 * KWidth_ScaleW;
    CGFloat sectionViewHeight = 423/2.0 * KWidth_ScaleH;
    for (NSInteger i = 0; i < tempCount; i++) {
        SSMSecondSectionView *sectionView = [[SSMSecondSectionView alloc] initWithFrame:CGRectMake(30/2.0 * KWidth_ScaleW + i * (sectionViewWidth + 0.5), _titleLabel.bottom + 32/2.0 * KWidth_ScaleH, sectionViewWidth, sectionViewHeight)];
        sectionView.tag = 30 + i;
        sectionView.items = self.cates.items[i];
        sectionView.block = ^(UIButton *button) {
            NSLog(@"点击了第%ld个视图",button.tag);
        };
        [_bjView addSubview:sectionView];
    }
}

#pragma mark -- 按钮事件
- (void)moreButtonClick:(UIButton *)button{
    NSLog(@"点击更多按钮");
}


- (void)viewColorChangeFromCoror:(UIColor *)fromColor toColor:(UIColor *)toColor withTheView:(UIView *)view{
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）,startPoint&endPoint    颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，如(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 0.6);
    
    //设置颜色数组,colors渐变的颜色
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,
                             (__bridge id)toColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.0f)];
}

-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, 1.0);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
